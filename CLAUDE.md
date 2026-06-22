# StudyBible — contributor notes

Guidance for anyone (human or agent) working in this repo. See
[CONTRIBUTING.md](CONTRIBUTING.md) and [DESIGN.md](DESIGN.md) for detail.

## Commits

Use the prefixes from CONTRIBUTING.md — `scripts/update_version.dart` parses
them to build the in-app "What's New" changelog:

- **User-facing** (appear in the changelog): `feat:` / `feature:`,
  `fix:` / `bug:`, `update:` / `refactor:` / `perf:`
- **Internal** (filtered out of the changelog): `chore:` (routine/releases),
  `dev:` (tests, CI, tooling, internal refactors), `doc:` / `docs:`

## Releasing

Run `./scripts/release.sh` from the repo root. It aborts on a dirty tree,
runs the quality gate (`tool/lint_domain.sh`, `flutter analyze`,
`flutter test`), then bumps the version, writes the changelog, commits, and
tags. Publish with `git push && git push --tags` (the tag triggers the
platform release builds).

## Architecture & conventions

- Layered: `domain` (pure Dart) ← `data` (Drift/SQLite, IO, HTTP) ←
  `app` (Riverpod) ← `ui` (widgets).
- The **domain layer (`lib/domain/`) must stay pure Dart** — no Flutter or
  `dart:io` imports. Enforced by `tool/lint_domain.sh` (also runs in CI).
- Generated Drift/Riverpod code (`*.g.dart`) is committed; after changing a
  table or provider, run `dart run build_runner build --delete-conflicting-outputs`.
- CI (`.github/workflows/ci.yml`) runs lint + analyze + tests on push/PR.
