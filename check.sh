#!/bin/bash
set -uo pipefail

CHANGELOG_FILE="${1:-CHANGES.md}"

if [ "${NO_CHANGELOG_LABEL}" = "true" ]; then
    # 'no changelog' set, so finish successfully
    exit 0
else
    # a changelog check is required
    # fail if the diff is empty
    if git diff --exit-code "origin/${BASE_REF}" -- "${CHANGELOG_FILE}"; then
        >&2 echo "User-visible changes should come with an entry in the changelog. This behavior
can be overridden by using the \"no changelog\" label, which is used for changes
that are not user-visible."
        exit 1
    fi
fi
