# Surge ruleset repair test result — 2026-08-29

## Scope

- Source: `Rule.CustomDirect.list`
- Installed mirror: `/Users/Shuai/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents/TAG_local_rulesets/Rule.CustomDirect.list`
- Related log: `/Users/Shuai/Downloads/2026-08-27-181157.log`
- Change: add the single missing closing parenthesis to the malformed BT/download `URL-REGEX`.

## Success criteria

1. The previous invalid-regex baseline is reproducible.
2. Every `URL-REGEX` in both source and installed mirror compiles with Foundation's regex engine.
3. Representative BT/download inputs match and an ordinary URL does not.
4. Relevant Surge profiles validate.
5. The `hilo.bilibili.com` diagnosis is confirmed against authoritative DNS, without adding an unsupported host override.

## Results

| Check | Result | Evidence |
| --- | --- | --- |
| Pre-change baseline | PASS | Foundation rejected source line 478; `invalid_count=1`. |
| Source regex compilation | PASS | 7 checked; `invalid_count=0`. |
| Installed mirror regex compilation | PASS | 7 checked; `invalid_count=0`. |
| Match behavior | PASS | `tracker` and `magnet:` samples matched; ordinary URL did not. |
| Installed backup | PASS | Original and `Rule.CustomDirect.list.bak-20260829-190600` had the same SHA-256: `3979925265abc58965e07c65a91f21f9b8a42a779c30e937bc70f9ff5ccd6945`. |
| Surge current profile | PASS | Surge CLI reported `Current Profile: new5`. |
| Surge profile checks | PASS | `new5.modified.conf` and `mobile20260724-v2.conf` both returned `OK`. |
| Remote publication | PASS | `origin/main` resolved to commit `e84d5a553ccce8f212e3513ffb1ce82146f12126`; GitHub Raw read-back contained the repaired line 478. |
| Active resource refresh | PASS | Surge external resource key `ae66a44b042424f39fe2cd0741c0881a` returned `success`, `ready`, updated `2026-08-29 19:08:24 +08:00`; the following 300 in-memory log entries contained no invalid-regex warning. |
| Authoritative DNS | PASS | `dig @ns3.dnsv5.com hilo.bilibili.com A +norecurse` and the same query to `ns4.dnsv5.com` both returned `status: NXDOMAIN` with the `aa` flag. |
| Recursive DNS comparison | PASS | `223.5.5.5`, `114.114.114.114`, `1.1.1.1`, and `8.8.8.8` all returned `NXDOMAIN`. |

## Commands

```bash
swift -e 'import Foundation /* read each URL-REGEX and compile with NSRegularExpression */'
/Applications/Surge.app/Contents/Applications/surge-cli --check "/Users/Shuai/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents/new5.modified.conf"
/Applications/Surge.app/Contents/Applications/surge-cli --check "/Users/Shuai/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents/mobile20260724-v2.conf"
/Applications/Surge.app/Contents/Applications/surge-cli external-resource update ae66a44b042424f39fe2cd0741c0881a
dig @ns3.dnsv5.com hilo.bilibili.com A +norecurse +noall +comments +answer +authority
dig @ns4.dnsv5.com hilo.bilibili.com A +norecurse +noall +comments +answer +authority
```

## Conclusion

The ruleset syntax defect is fixed in both editable source and installed mirror. The Bilibili hostname failure is an authoritative DNS removal/nonexistence condition, not a local DNS outage; no host or Fake-IP workaround was added.
