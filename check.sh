#!/bin/bash
set -uo pipefail

if [ "${NO_CHANGELOG_LABEL}" = "true" ]; then
    # 'no changelog' set, so finish successfully
    exit 0
else
    # a changelog check is required
    # fail if the diff is empty

    >&2 echo "User-visible changes should come with an entry in the changelog. This behavior
can be overridden by using the \"no changelog\" label, which is used for changes
that are not user-visible."

    ! git diff --exit-code "origin/${BASE_REF}" -- CHANGES.md
fi
