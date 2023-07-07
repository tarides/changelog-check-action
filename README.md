# changelog-check-action

This GitHub Action will check whether a PR also modifies the projects
changelog. This is useful to ensure that each change committed comes with an
user-readable explanation.

It doesn't check the format of the changelog but is still meant as a reminder
to add a change so the contents of the change itself can be discussed in the
review.

## How it works

1. Create a PR with some changes
2. See the action fail your build because the changelog wasn't modified
3. Add an entry in changelog and push
4. See the action succeed.

### Opting out

Not all changes need a changelog entry, some are not user-visible, like
changing CI or some internal refactoring. For those it is possible to disable
the check.

To do so, create a new label called `no changelog` and apply it to the PR. Then
the changelog check will re-run and succeed automatically. This label can also
be applied directly when opening the PR so the check will be automatically
omitted.

## Options

The file that is being checked by default is called `CHANGES.md` but you can
use the `changelog` argument to specify any other file as well.

## Set up

First, set up the action in `.github/workflows/<your-file>.yml`.

### Example

Add this to your GitHub workflow:

```yaml
- name: Check changelog
  uses: tarides/changelog-check-action@v2
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
      - uses: tarides/changelog-check-action@v2
        with:
          changelog: CHANGES.md
```
