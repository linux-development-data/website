@def title = "The dataset"
@def hascode = true

# The dataset

~~~<p class="lead">One PostgreSQL 18 database, <code>linuxkernel</code>, about 595 GB, plus a 14 GB historical database exposed to it as a foreign schema. Sixteen schemas. Every figure on this page was read from the live database on {{asof}}.</p>~~~

## Coverage

| Record | Extent |
| :--- | :--- |
| Span | 1987 → June 2026 |
| Mailing-list email | 29,556,155 postings / 18,081,107 unique messages, across 519 canonical lists (332 of them kernel lists) |
| Commits | 1,511,507, all `torvalds/linux` mainline, 1991 → 2026-06-07 |
| Bug reports | 44,128 real bugs (2002 → 2026), 380,260 comments |
| MAINTAINERS | 6,149 revisions of the file, 8,782 stitched maintainer tenures |
| Source tree | 116 release snapshots, 1991-09-17 → 2026-04-12 |
| Usenet / netnews | 2,276,867 unique messages, 1987-01-16 → 2013-06-23 (frozen) |

## mails: the as-posted record

Every message that reached a kernel list: patches, reviews, flames and bug reports, accepted or not. Rejected and abandoned patches live here and nowhere else. The schema stores **two grains at once**:

- **`mails.posts`**: 29,556,155 rows, one per (message, list).
- **`mails.messages`**: 18,081,107 rows, one per unique message.

A message cross-posted to four lists is four postings and one message. Both counts are correct; they answer different questions. The ratio between them climbs from 1.00× in 1995 to 1.99× in 2023, so counting postings inflates modern activity against the 1990s roughly twofold.

Around that core sit the message bodies, the address dimension, the review-trailer graph (`mails.roles`, 22.4M rows), threads built from explicit `In-Reply-To` and `References` headers, and a list dimension that records which lists are kernel lists.

**Entry points:** `mails.emails_unique` for message-level analysis, `mails.emails_panel` for anything longitudinal.

## commits: the accepted record

`torvalds/linux` traversed in full: 1,511,507 commits with a **closed DAG**, so every parent edge resolves. Sign-off, review and ack trailers become a collaboration graph.

**Entry point:** `commits.mainline` (1,379,463 non-merge commits). Use `author_date`, never `committer_date`: the latter compresses all pre-2002 history into 2002, the year of the BitKeeper import.

## bugzilla: bug reports

44,128 real bugs out of an id range of 221,620 that was walked exhaustively. Deleted ids are stored as stubs, so absence is recorded rather than inferred.

**Entry point:** `bugzilla.bug_universe`.

## maintainers and filegraph: who governs what

MAINTAINERS is parsed as a time series rather than a snapshot: 41,134 field episodes with validity windows. The `F:` (file pattern) field only enters the file on 2007-10-12, so the build refuses any file→subsystem map dated before then.

`filegraph` is the kernel source tree itself, per release, over 116 snapshots: 191,743 paths and 63,178,283 dependency edges (C includes, Kconfig, Makefile, devicetree, Rust), with a bridge from MAINTAINERS globs to the real files they matched.

> **Two limits, stated up front.** The dependency graph is multiplexed by architecture (`#include <asm/io.h>` names a different file on every arch), so filter on `arch`. And it is static, not build-resolved: it does not know your `.config`.

## idres and org: people and employers

`idres` resolves 856,361 addresses to 591,745 persons, with per-edge rule provenance. Measured against a held-out slice of the kernel's own `.mailmap`: 91.9% recall, cluster precision 0.978, published at three operating points so a result can be shown to survive the merge threshold.

`org` profiles 253,763 email domains and 1,046 organisations with dated validity windows, so a corporate rename reads as a rename rather than as everybody changing jobs at once.

## link: from email to commit

406,981 exactly resolved message→commit pairs, joined on the kernel's own `Link:`, `Closes:` and `Message-Id:` trailers, with no inference. Coverage depends strongly on the era, so never publish a pooled match rate.

## meta: provenance and the health gate

Every collection wave, tool version and clone SHA is recorded. A row-count contract over derived tables and a set of semantic invariants form the regression net:

```sql
SELECT meta.assert_all();   -- raises if the database is silently broken
```
