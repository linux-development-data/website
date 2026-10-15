@def title = "Linux kernel as data"
@def hascode = true

~~~
<div class="home-page">
<section class="hero" aria-labelledby="hero-title">
  <div class="hero-copy"><span class="kicker">Linux kernel · 1991 → 2026 · one database</span>
    <h1 id="hero-title">Thirty-five years of the kernel.<br>Read as <em>data.</em></h1>
    <p>Every posting to every kernel mailing list, every commit to mainline, every bug report, the MAINTAINERS file as it changed week by week, and the source tree itself as a dependency graph. Collected from public archives, joined into one PostgreSQL database, and checked by specialists who tried to break it.</p>
    <div class="actions"><a class="button button-primary" href="/dataset/">Explore the dataset <span aria-hidden="true">→</span></a><a class="button button-secondary" href="/pipeline/">See how it was built</a></div>
  </div>
  <figure class="hero-figure"><div class="figure-header"><span>JOINED RECORDS</span><span>01 / ONE TIMELINE</span></div>
<svg class="hero-network" viewBox="0 0 450 370" role="img" aria-labelledby="records-title records-description">
<title id="records-title">Four kernel records on one timeline, linked to each other</title><desc id="records-description">Four horizontal timelines — mailing lists, commits, bug reports and maintainers — with links drawn where a posted patch became a commit, a commit closed a bug, and a maintainer reviewed the work. A schematic, not real data.</desc>
<g stroke="#b9b1a0" stroke-width="1.4"><line x1="40" y1="70" x2="430" y2="70"/>
<line x1="40" y1="160" x2="430" y2="160"/>
<line x1="40" y1="250" x2="430" y2="250"/>
<line x1="40" y1="330" x2="430" y2="330"/>
<line x1="95" y1="70" x2="130" y2="160"/>
<line x1="185" y1="70" x2="215" y2="160"/>
<line x1="290" y1="70" x2="320" y2="160"/>
<line x1="365" y1="70" x2="395" y2="160"/>
<line x1="215" y1="160" x2="240" y2="250"/>
<line x1="320" y1="160" x2="345" y2="250"/>
<line x1="150" y1="330" x2="185" y2="70"/>
<line x1="270" y1="330" x2="290" y2="70"/></g>
<g fill="none" stroke="#ddd6c4"><circle cx="185" cy="70" r="20"/><circle cx="290" cy="70" r="20"/><circle cx="320" cy="160" r="20"/></g>
<g><circle cx="60" cy="70" r="6" fill="#17171c"/>
<circle cx="95" cy="70" r="6" fill="#17171c"/>
<circle cx="130" cy="70" r="6" fill="#17171c"/>
<circle cx="185" cy="70" r="10" fill="#f5b400"/>
<circle cx="240" cy="70" r="6" fill="#17171c"/>
<circle cx="290" cy="70" r="10" fill="#f5b400"/>
<circle cx="330" cy="70" r="6" fill="#17171c"/>
<circle cx="365" cy="70" r="6" fill="#17171c"/>
<circle cx="410" cy="70" r="6" fill="#17171c"/>
<circle cx="130" cy="160" r="6" fill="#17171c"/>
<circle cx="215" cy="160" r="6" fill="#17171c"/>
<circle cx="265" cy="160" r="6" fill="#17171c"/>
<circle cx="320" cy="160" r="10" fill="#f5b400"/>
<circle cx="395" cy="160" r="6" fill="#17171c"/>
<circle cx="80" cy="250" r="6" fill="#17171c"/>
<circle cx="240" cy="250" r="6" fill="#17171c"/>
<circle cx="345" cy="250" r="6" fill="#17171c"/>
<circle cx="150" cy="330" r="6" fill="#17171c"/>
<circle cx="270" cy="330" r="6" fill="#17171c"/>
<circle cx="400" cy="330" r="6" fill="#17171c"/></g>
<g font-family="monospace" font-size="9" fill="#5b564b"><text x="40" y="54">MAILS</text><text x="40" y="144">COMMITS</text><text x="40" y="234">BUGS</text><text x="40" y="314">MAINTAINERS</text></g></svg>
    <figcaption class="figure-caption"><span>Post · review · merge · fix</span><span>Schematic</span></figcaption>
  </figure>
</section>
<div class="fact-strip"><span><strong>29.6M</strong> mailing-list postings</span><span><strong>1.5M</strong> mainline commits</span><span><strong>44k</strong> bug reports</span><span><strong>116</strong> source-tree releases</span><span>Figures as of {{asof}}</span></div>
<section class="home-section" aria-labelledby="workflow-title">
  <div class="section-heading"><div><span class="kicker">Start with your question</span><h2 id="workflow-title">What are you studying?</h2></div><a href="/methods/">Read the traps first →</a></div>
  <div class="workflow-grid">
    <a class="workflow-card" href="/dataset/#mails_the_as-posted_record"><span class="card-number">01 / COLLABORATION</span><h3>How code gets reviewed</h3><p>Follow patches from the mailing list to mainline: threads, review trailers, and 406,981 exact message→commit links.</p><span class="card-action">mails · commits · link <span aria-hidden="true">→</span></span></a>
    <a class="workflow-card" href="/dataset/#maintainers_and_filegraph_who_governs_what"><span class="card-number">02 / GOVERNANCE</span><h3>Who owns which code, when?</h3><p>MAINTAINERS as a time series of tenures, bridged to the real files each subsystem covered at every release.</p><span class="card-action">maintainers · filegraph <span aria-hidden="true">→</span></span></a>
    <a class="workflow-card" href="/dataset/#idres_and_org_people_and_employers"><span class="card-number">03 / CAREERS</span><h3>People and organisations</h3><p>Resolved identities and dated employer domains, so a job change reads as a move rather than a new person.</p><span class="card-action">idres · org <span aria-hidden="true">→</span></span></a>
  </div>
</section>
<section class="home-section analysis-feature" aria-labelledby="first-query-title">
  <div><span class="kicker">One query, the right entry point</span><h2 id="first-query-title">Count commits.<br>Without losing 11.5% of them.</h2><p>Filtering raw commits by project name silently drops part of mainline and fabricates a gap in 2022. The curated entry points exist so that the obvious query is also the correct one.</p><a href="/methods/">See the six classic traps →</a></div><div>
~~~

```sql
-- non-merge mainline commits per year
SELECT date_trunc('year', author_date) AS year,
       count(*)                        AS commits
FROM   commits.mainline
GROUP  BY 1
ORDER  BY 1;
```

~~~
  </div>
</section>
<section class="home-section project-note" aria-label="About this project">
  <div><h3>Open code, protected people</h3><p>Every collector, cleaning step and matching method is public. The database itself is not distributed, and no person-level data ever leaves it.</p><a href="/access/">What exists and what may be shared →</a></div>
  <div><h3>Built from public archives</h3><p>lore.kernel.org, Usenet, the mainline git tree, kernel Bugzilla and the MAINTAINERS file. The pipeline from raw archive to joined tables lives in seven repositories.</p><a href="/pipeline/">Walk through the pipeline →</a></div>
</section>
</div>
~~~
