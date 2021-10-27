# changelog-check-action

This GitHub Action will check whether your PR also modifies the changelog. This
is useful to ensure that each change committed comes with an user-readable
explanation.

## How it works

1. Create a PR with some changes
2. See the action fail your build because the `CHANGES.md` wasn't modified
3. Add an entry in `CHANGES.md` and push
4. See the action succeed.

Not all changes need a changelog entry, some are not user-visible, like
changing CI or some internal refactoring. For those it is possible to disable
the check. Just create a new label, `no changelog` and apply it to the PR, then
the changelog check will be disabled for this PR.

## Set up

First, set up the action in `.github/workflows/<your-file>.yml`.

### Example

Add this to your GitHub workflow:

```yaml
- name: Check changelog
  uses: tarides/changelog-check-action@v1
```

### Full example

A complete `.github/workflows/changelog.yml` might look like this:

```yaml
name: Check Changelog
on:
  pull_request:
    types: [assigned, opened, synchronize, reopened, labeled, unlabeled]
    branches:
      - main
jobs:
  Check-Changelog:
    name: Check Changelog Action
    runs-on: ubuntu-20.04
    steps:
      - uses: tarides/changelog-check-action@v1
```
