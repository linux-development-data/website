# lk-as-data

Showcase website for the *Linux kernel as data* project, built with
[Franklin.jl](https://franklinjl.org).

**Live:** https://linux-development-data.github.io/lk-as-data/

The layout follows the
[statistical-network-analysis-with-Julia](https://github.com/statistical-network-analysis-with-Julia/statistical-network-analysis-with-Julia.github.io)
site (MIT), recoloured after Tux.

## Preview locally

```bash
julia --project -e 'using Pkg; Pkg.instantiate(); using Franklin; serve()'
```

## Publish

Pushing to `main` runs `.github/workflows/deploy.yml`, which builds the site
with `optimize()` and pushes `__site/` to the `gh-pages` branch. In the
repository settings, set **Pages → Source** to *Deploy from a branch*,
`gh-pages` / root.

## Rules

- Figures are read from the live database; `asof` in `config.md` records when.
- No person-level data, ever (see `lk/docs/DATA_GOVERNANCE.md`).
