# Surge Rulesets

Surge rule-set files for iOS remote references.

Only `.list` files are stored here. Do not commit `.conf` files, proxy nodes,
certificates, passwords, or other private profile data.

## Raw URL

After this repository is pushed to GitHub, use this URL format in Surge:

```conf
RULE-SET,https://raw.githubusercontent.com/HansonChan/surge-rulesets/main/OpenAi.list,🧲 OpenAI
RULE-SET,https://raw.githubusercontent.com/HansonChan/surge-rulesets/main/Claude.list,🧲 Claude
```

Replace `OpenAi.list` or `Claude.list` with any file in this repository.

## Sync From iCloud

```bash
./scripts/sync-from-icloud.sh
git add .
git commit -m "Update rulesets"
git push
```
