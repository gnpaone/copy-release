# Copy Repo Release

Copy a release—including metadata and assets—from one GitHub repository to another.

This GitHub Action is useful when you maintain multiple mirrors, split repos, or need to propagate releases across orgs or repos automatically.

---

## ✨ Features

* Copies an existing release from a **source repository** to a **destination repository**
* Preserves release metadata: title, body, draft status, prerelease flag
* Optionally override title, body, draft/prerelease flags
* Supports copying release assets (or skipping them)
* Automatically uses the triggering tag if none is provided
* Works across orgs when provided a token with appropriate permissions

---

## 🛠 Inputs

| Input                 | Required | Default                | Description                                                                |
| --------------------- | -------- | ---------------------- | -------------------------------------------------------------------------- |
| `source_repo`         | ✔️ Yes   | —                      | The `owner/repo` to copy the release *from*.                               |
| `destination_repo`    | ❌ No    | Current repo           | The `owner/repo` to create/update the release *in*.                        |
| `github_token`        | ✔️ Yes   | `secrets.GITHUB_TOKEN` | A token with access to both source & destination repos.                    |
| `tag`                 | ❌ No    | Triggering tag         | The release tag to copy.                                                   |
| `override_body`       | ❌ No    | —                      | Overrides the release body in the destination repo.                        |
| `override_name`       | ❌ No    | —                      | Overrides the release name/title in the destination repo.                  |
| `override_draft`      | ❌ No    | —                      | Explicit `true`/`false` to set draft status. Otherwise uses source.        |
| `override_prerelease` | ❌ No    | —                      | Explicit `true`/`false` to set prerelease flag. Otherwise uses source.     |
| `skip_assets`         | ❌ No    | `false`                | If `true`, does not copy assets.                                           |

---

## 🚀 Usage

<!-- COPY_RELEASE_WORKFLOW_START -->
```yaml
name: Copy Release

on:
  workflow_dispatch:
    inputs:
      tag:
        description: "Release tag to copy"
        required: true

jobs:
  copy-release:
    runs-on: ubuntu-latest
    steps:
      - name: Copy GitHub Release
        uses: gnpaone/copy-repo-release@v1.1.2
        with:
          source_repo: my-org/source-repo
          tag: 
```

---

## 🔧 Example: Overriding Fields

```yaml
- name: Copy with Overrides
  uses: gnpaone/copy-repo-release@v1.1.2
  with:
    source_repo: user/project-A
    destination_repo: user/project-B
    github_token: 
    override_name: "Rebranded Release Name"
    override_body: |
      This release is synced but modified.
      It has a multi-line description.
    override_draft: "true"
    skip_assets: "true"
```

<!-- COPY_RELEASE_WORKFLOW_END -->
