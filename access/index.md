@def title = "Access"

# Access

~~~<p class="lead">What exists today, what a replication package would contain, and what can never be released.</p>~~~

## Today

**The database is not distributed.** It is a single-user PostgreSQL cluster on a research machine. There is no hosted copy and no public endpoint, and no replication package has been cut yet.

## What is open now

- **All the code.** Collectors, cleaning, database operations, identity resolution and matching, in the [linux-development-data](https://github.com/linux-development-data) organisation. The repositories contain no data.
- **The methods.** Every design decision is documented, including the ones that turned out to be wrong.
- **The corpus, by re-collection.** Every source is a public archive, and the collectors will re-derive it.

## What a release would contain

| Ships | Does not ship |
| :--- | :--- |
| All code | The database dump |
| A de-identified analysis panel: salted per-release person keys, month grain, organisation class rather than raw domain, no free text | Raw corpora and any free text: bodies, comments, commit messages, subjects |
| Provenance tables and rebuild manifests | Address dimensions |
| The aggregates behind every published figure | The bug-reporter bridge, in any form, including hashed |
| The identity-resolution evaluation against the kernel's public `.mailmap` | The salt |

The goal: *a reviewer can reproduce every number and figure without receiving a re-identifiable copy of 591,745 developers.*

## What can never be released

The resolved person key, internal identity ids, raw email addresses, and anything derived from the bug-reporter bridge, in identified or hashed form. Hashing a public address space is reversible, so a hashed key is still a person.

## Asking

If you want to use this data, send **the question** rather than a request for the database. The most productive outcome is usually a de-identified extract shaped to your design, or a collaboration. Open an issue in the [organisation](https://github.com/linux-development-data).
