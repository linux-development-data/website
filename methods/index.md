@def title = "Methods and traps"
@def hascode = true

# Methods and traps

~~~<p class="lead">Most quantitative work on the Linux kernel starts by scraping something and counting rows. That is where errors get in. Each trap below was made, caught, and then designed against.</p>~~~

## Six ways to publish a wrong number

1. **Counting postings as messages.** Cross-posting grew over time, so a raw count of mail rows overstates the 2020s against the 1990s by about two times. Use `mails.emails_unique`.
2. **Choosing kernel lists by hostname.** A hostname filter silently deletes the whole graphics subsystem. Use the list dimension's `is_kernel` flag.
3. **Filtering commits by project name.** Parallel collection gave mainline commits names like `m1`…`m21`; filtering them out drops 11.5% of history and invents a gap in 2022. Use `commits.mainline`.
4. **Using the committer date.** It compresses all pre-2002 history into the year of the BitKeeper import. Use `author_date`.
5. **Building a time trend from raw yearly series.** Lists enter and leave the archives. Use `mails.emails_panel`, 61 lists present in every year from 2008 to 2024.
6. **Mapping files to subsystems before 2007.** The `F:` field did not exist yet. Any such map is a fabrication.

## Entry points

| Question | Query this | Not this |
| :--- | :--- | :--- |
| How much email? | `mails.emails_unique` | `mails.rawdata` |
| Any time trend | `mails.emails_panel` | any raw yearly series |
| Commits | `commits.mainline` | raw commits filtered by `project_name` |
| Bugs | `bugzilla.bug_universe` | the collected id range |
| Dependencies | `filegraph.edge_dep` with an `arch` filter | `edge_dep` unfiltered |
| Who is a person | `idres.person` | any older identity table |

## The expert panels

In July 2026 the database was put in front of successive panels of independent reviewers: a PostgreSQL engineer, a data engineer, a kernel-community developer, a computational social scientist, a record-linkage methodologist, a name-matching specialist, a labor economist and a data-governance reviewer. An adversarial fact-checker then tried to refute every claim against the live database and the upstream sources.

Several reviewers were wrong, and that was the most useful result. A proposal to deduplicate "twin" commits would have deleted real ones. A proposed backfill of three orphan roots was refused once upstream showed Linux really is a four-root DAG. A rule to infer a posting's list from its siblings was measured against ground truth, found wrong 61% of the time, and dropped.

Read each reviewer's view at [linuxkernel-db](https://linux-development-data.github.io/linuxkernel-db/lenses/).
