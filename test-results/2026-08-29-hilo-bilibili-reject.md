# Surge `hilo.bilibili.com` reject-rule test — 2026-08-29

## Scope

- Published rule source: `Rule.Reject.list`
- Active macOS profile: `/Users/Shuai/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents/new5.conf`
- Log-corresponding mobile profile: `/Users/Shuai/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents/mobile20260724-v2.conf`
- Requested outcome: make `hilo.bilibili.com` fail fast with `REJECT` without changing routing for other Bilibili hosts.

## Success criteria

1. The exact domain is present once in the canonical Reject ruleset and published.
2. Higher-priority broad Bilibili DIRECT rules do not shadow the exact rejection.
3. Both profiles validate with Surge CLI.
4. The active Surge runtime matches the exact rule and returns policy `REJECT`.

## Results

| Check | Result | Evidence |
| --- | --- | --- |
| Baseline runtime | PASS | Before the change, `rule match hilo.bilibili.com` matched `DOMAIN-SUFFIX,bilibili.com,DIRECT`. |
| Canonical Reject rule | PASS | `Rule.Reject.list` contains one `DOMAIN,hilo.bilibili.com` entry under the Bilibili section. |
| Publication | PASS | Commit `6d83e34` was pushed to `origin/main`; GitHub Raw read-back showed the new entry at line 416. |
| Active resource refresh | PASS | Resource key `cff3150e3f7a83ed36b8b4a6b15e3458` returned `success`, `ready`, updated `2026-08-29 19:15:03 +08:00`. |
| Priority correction | PASS | Each profile has `DOMAIN,hilo.bilibili.com,REJECT` immediately before its broad `DOMAIN-SUFFIX,bilibili.com,DIRECT` rule. |
| Profile validation | PASS | `new5.conf` and `mobile20260724-v2.conf` both returned `OK`. |
| Runtime match | PASS | After `profile switch new5`, `rule match hilo.bilibili.com` returned `DOMAIN,hilo.bilibili.com,REJECT`; policy `REJECT`; `dump rule` listed it at index 0. |
| Unrelated Bilibili routing | PASS | The existing suffix DIRECT rule remains at runtime index 1, immediately after the exact override. |
| Recoverability | PASS | Pre-change backups are `new5.conf.bak-20260829-191415` and `mobile20260724-v2.conf.bak-20260829-191415`; each initially matched its source SHA-256. |

## Commands

```bash
/Applications/Surge.app/Contents/Applications/surge-cli --check "/Users/Shuai/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents/new5.conf"
/Applications/Surge.app/Contents/Applications/surge-cli --check "/Users/Shuai/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents/mobile20260724-v2.conf"
/Applications/Surge.app/Contents/Applications/surge-cli external-resource update cff3150e3f7a83ed36b8b4a6b15e3458
/Applications/Surge.app/Contents/Applications/surge-cli profile switch new5
/Applications/Surge.app/Contents/Applications/surge-cli rule match hilo.bilibili.com
/Applications/Surge.app/Contents/Applications/surge-cli dump rule
```

## Conclusion

The exact retired Bilibili endpoint now fails fast with `REJECT` in the active runtime and the mobile profile, while the pre-existing DIRECT behavior for other `bilibili.com` hosts is preserved.
