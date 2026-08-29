# Task Memory

## Scope

- This repository is the canonical Git source for the personal Surge rule sets published from `HansonChan/surge-rulesets`.
- Treat repository files and installed iCloud/Surge mirrors as separate artifacts; validate and report each one explicitly.

## Current state

- 2026-08-29: repaired the malformed `URL-REGEX` in `Rule.CustomDirect.list` by adding its missing closing parenthesis. The rule keeps its existing BT/download matching behavior.
- Synced the same one-character repair to the installed mirror at `TAG_local_rulesets/Rule.CustomDirect.list`; its pre-change copy is `Rule.CustomDirect.list.bak-20260829-190600`.
- `hilo.bilibili.com` was not overridden or assigned a fabricated address. Both authoritative DNS servers for `bilibili.com` returned authoritative `NXDOMAIN` on 2026-08-29.
- 2026-08-29: added `DOMAIN,hilo.bilibili.com` to `Rule.Reject.list` and published it in commit `6d83e34`. Because both live profiles had a higher-priority broad Bilibili DIRECT rule, added the requested exact `DOMAIN,hilo.bilibili.com,REJECT` override before that rule in `new5.conf` and `mobile20260724-v2.conf`; other Bilibili traffic remains DIRECT.

## Verification

- Foundation `NSRegularExpression` compilation: all 7 `URL-REGEX` entries passed in both the repository source and installed mirror (`invalid_count=0`).
- Behavior samples: tracker and magnet URLs matched; an ordinary URL did not.
- Surge CLI profile validation: current profile is `new5`; `new5.modified.conf` and `mobile20260724-v2.conf` both returned `OK`.
- Published commit `e84d5a5` to `origin/main`; GitHub Raw read-back showed the repaired rule at line 478. The active Surge external resource refresh returned `success` and its timestamp advanced to `2026-08-29 19:08:24 +08:00`.
- Hilo reject verification: GitHub Raw read-back showed the entry in `Rule.Reject.list`; the active resource refresh returned `success` at `2026-08-29 19:15:03 +08:00`; both profiles returned `OK`; after reselecting `new5`, `rule match hilo.bilibili.com` returned the exact rule and policy `REJECT` at runtime rule index 0.
- External DNS evidence and exact validation commands are recorded in `test-results/2026-08-29-rule-customdirect-regex-fix.md`.
- Exact reject-rule evidence is recorded in `test-results/2026-08-29-hilo-bilibili-reject.md`.
