# Task Memory

## Scope

- This repository is the canonical Git source for the personal Surge rule sets published from `HansonChan/surge-rulesets`.
- Treat repository files and installed iCloud/Surge mirrors as separate artifacts; validate and report each one explicitly.

## Current state

- 2026-08-29: repaired the malformed `URL-REGEX` in `Rule.CustomDirect.list` by adding its missing closing parenthesis. The rule keeps its existing BT/download matching behavior.
- Synced the same one-character repair to the installed mirror at `TAG_local_rulesets/Rule.CustomDirect.list`; its pre-change copy is `Rule.CustomDirect.list.bak-20260829-190600`.
- `hilo.bilibili.com` was not overridden or assigned a fabricated address. Both authoritative DNS servers for `bilibili.com` returned authoritative `NXDOMAIN` on 2026-08-29.

## Verification

- Foundation `NSRegularExpression` compilation: all 7 `URL-REGEX` entries passed in both the repository source and installed mirror (`invalid_count=0`).
- Behavior samples: tracker and magnet URLs matched; an ordinary URL did not.
- Surge CLI profile validation: current profile is `new5`; `new5.modified.conf` and `mobile20260724-v2.conf` both returned `OK`.
- External DNS evidence and exact validation commands are recorded in `test-results/2026-08-29-rule-customdirect-regex-fix.md`.
