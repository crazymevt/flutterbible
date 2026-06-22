# Contributing to StudyBible

Welcome! When contributing to this repository or assisting with code generation, please follow these guidelines to ensure consistency and seamless automation.

## Git Commit Guidelines

We use specific prefixes in our commit messages. Our automated release script (`scripts/release.sh`) parses these prefixes to automatically generate a structured `changelog.json` and updates the in-app "What's New" dialog.

**You MUST use one of the following prefixes for all commits:**

- `feat:` or `feature:`
  - Use this for adding new features, UI components, or significant capabilities.
  - *Example:* `feat: Add global version tracker to App Drawer`
  - *Changelog Category:* **New Features**

- `fix:` or `bug:`
  - Use this for bug fixes, crash resolutions, or repairing broken logic.
  - *Example:* `fix: Correct streak calculation to include time tracker`
  - *Changelog Category:* **Bugfixes**

- `update:`, `refactor:`, `perf:`
  - Use this for **user-noticeable** general improvements, UI tweaks, performance enhancements, or refactors that aren't strictly new features or bug fixes.
  - For purely internal refactors with no user impact, prefer `dev:` so they stay out of the changelog.
  - *Example:* `update: Reorganize settings screen layout`
  - *Changelog Category:* **Updates**

The following prefixes are for changes with **no user-facing impact**. They are intentionally filtered out and will *not* appear in the public changelog:

- `chore:`
  - Use this for routine tasks, dependency bumps, or release bumps.
  - *Example:* `chore: Release version 26.6.20+1`

- `dev:`
  - Use this for developer-facing changes that don't affect the shipped app behavior: tests, CI, build tooling, and internal refactors not worth surfacing to users.
  - *Example:* `dev: Add unit tests for the verse parser`

- `doc:`
  - Use this for documentation-only changes (README, DESIGN, CONTRIBUTING, code comments). `docs:` is also accepted.
  - *Example:* `doc: Clarify the sync architecture in DESIGN.md`

## Release Process

When you are ready to create a new release:
1. Ensure all your changes are committed using the prefixes above (the script aborts on a dirty working tree).
2. Run `./scripts/release.sh` from the root of the project.
3. The script first runs the quality gate (`tool/lint_domain.sh`, `flutter analyze`, `flutter test`) and aborts if anything fails, then calculates the new version tag, writes the changelog, updates `pubspec.yaml`, and creates the Git commit and tag.
4. Run `git push && git push --tags` to publish. The tag triggers the platform release builds, including the Linux Flatpak (`StudyBible-Linux.flatpak`).
5. **Flathub (when maintaining the Flathub package):** once the release assets are published, run `flatpak/pin-flathub.sh <tag>` to pin the Flathub manifest to the new tarball, then commit. Once the app is live on Flathub, `flatpak-external-data-checker` auto-PRs these bumps. See [flatpak/README.md](flatpak/README.md).
