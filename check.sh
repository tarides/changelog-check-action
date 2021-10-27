#!/bin/bash
set -uo pipefail

if [ "${NO_CHANGELOG_LABEL}" = "true" ]; then
    # 'no changelog' set, so finish successfully
    exit 0
else
    # a changelog check is required
    # fail if the diff is empty
    ! git diff --exit-code "origin/${BASE_REF}" -- CHANGES.md
fi
