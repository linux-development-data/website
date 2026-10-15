@def title = "Pipeline"
@def hascode = true

# Pipeline

~~~<p class="lead">From public archives to joined tables in four stages. Each stage lives in its own repository; the formats passed between them are the contract.</p>~~~

```plaintext
data-gathering  →  data-cleaning  →  PostgreSQL linuxkernel  →  data-matching
 (raw archives)    (clean, load)      (one database, PG18)       (people, employers, links)
```

## 1. Gathering

[`data-gathering`](https://github.com/linux-development-data/data-gathering) holds one collector per source: commits from the mainline git tree, email from lore.kernel.org, the older FTP and Usenet archives, Marc and Indiana mirrors, Bugzilla, and the MAINTAINERS history. A file-tree collector turns each release into the `filegraph` dependency graph.

lore.kernel.org now sits behind a proof-of-work wall, so a re-crawl has to use the git protocol, not HTTP.

## 2. Cleaning and loading

[`data-cleaning`](https://github.com/linux-development-data/data-cleaning) imports raw collections into MongoDB for inspection, cleans them, and exports them to PostgreSQL. The loaders are parallel and idempotent, and a commensurability check proves that a refactor produces byte-identical output before a full load.

## 3. The database

[`postgres-mainteneance`](https://github.com/linux-development-data/postgres-mainteneance) records every operation on the database: the PostgreSQL 15 → 18 migration, the consolidation of two email schemas into `mails`, de-duplication, and the rebuild manifests. [`data-info`](https://github.com/linux-development-data/data-info) holds the data dictionary, the authoritative reference for every schema, table and column.

## 4. Matching

[`data-matching`](https://github.com/linux-development-data/data-matching) resolves entities:

- **Identity resolution** collapses the many addresses one developer uses across lists, commits and bug reports into one person, so careers can be followed across employers.
- **Message–commit matching** links posted patches to the commits they became.

## Verification

None of these repositories has a unit-test suite. Verification happens in the database itself: after any change, `meta.assert_all()` must pass, stage counts are compared against the documented build record, and the rows are read. Every invariant exists because that exact failure happened once and nothing caught it.

## Repositories

| Repository | Role |
| :--- | :--- |
| [data-gathering](https://github.com/linux-development-data/data-gathering) | Per-source collectors |
| [data-cleaning](https://github.com/linux-development-data/data-cleaning) | Raw → MongoDB → clean → PostgreSQL |
| [postgres-mainteneance](https://github.com/linux-development-data/postgres-mainteneance) | Database operations log and rebuild manifests |
| [data-matching](https://github.com/linux-development-data/data-matching) | Identity resolution and email→commit matching |
| [data-info](https://github.com/linux-development-data/data-info) | Data dictionary, ERDs, descriptive statistics |
| [linuxkernel-db](https://linux-development-data.github.io/linuxkernel-db/) | The database reviewed through nine expert lenses |
| [rust-adoption](https://github.com/linux-development-data/rust-adoption) | A companion study of Rust in Linux |
