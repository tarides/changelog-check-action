#!/usr/bin/env bash

set -uo pipefail

if ! valid_args=$(getopt -o h --long base-ref:,labels-set:,labels-to-skip:,changelog-file: -- "$@") ; then
  exit 1
fi
eval set -- "$valid_args"

while true; do
  case "$1" in
    --base-ref)
      BASE_REF="$2"
      shift 2
      ;;
    --changelog-file)
      CHANGELOG_FILE="$2"
      shift 2
      ;;
    --labels-to-skip)
      readarray -d ';' -t labels_to_skip < <( echo -n "$2" )
      shift 2
      ;;
    --labels-set)
      readarray -d ';' -t labels_set < <( echo -n "$2" )
      shift 2
      ;;
    -h)
      echo "Usage: ./check.sh --base-ref <ref-name> --labels-set <semicolon-separated-list> --labels-to-skip <semicolon-separated-list> --changelog-file <filename>"
      shift
      exit 0
      ;;
    --)
      shift
      break
      ;;
  esac
done

for skip_label in "${labels_to_skip[@]}"
do
  for supplied_label in "${labels_set[@]}"
  do
    if [[ "$supplied_label" == "$skip_label" ]]; then
      # one of the labels to skip was set
      exit 0
    fi
  done
done

# a changelog check is required
# fail if the diff is empty
if git diff --exit-code "origin/${BASE_REF}" -- "${CHANGELOG_FILE}"; then
  skip_labels=$(printf ", '%s'" "${labels_to_skip[@]}")
  skip_labels=${skip_labels:1}
    echo >&2 "User-visible changes should come with an entry in the changelog. This behavior
can be overridden by using one of$skip_labels labels, which is used for changes
that are not user-visible."
    exit 1
fi
