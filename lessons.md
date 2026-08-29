# Lessons Learned

- A base Surge profile can validate while a downloaded ruleset still contains an invalid runtime `URL-REGEX`; compile every external regex separately before publishing.
- A `198.18.0.0/15` answer from the macOS system resolver may be a Surge Fake-IP and does not prove that the public DNS name exists. Query the zone's authoritative nameservers before diagnosing or overriding an empty answer.
- Do not invent a host mapping for an authoritative `NXDOMAIN`. Update or clear the requesting app first; use an exact reject rule only when the user explicitly wants fail-fast suppression of a retired endpoint.
- A domain present in a Reject ruleset may still route DIRECT when an earlier broad rule already matches it. Verify the effective runtime order with `dump rule` and `rule match`; use an earlier exact override instead of reordering whole rulesets when only one hostname should change.
