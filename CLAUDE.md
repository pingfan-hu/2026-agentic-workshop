# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Writing conventions

**Never use em dashes (—) in any generated text.** This covers slide copy, prose, comments, and commit messages. Use a colon, comma, parentheses, or two short sentences instead. It applies to all on-slide content under `slides/**` and every Markdown/qmd file in the repo.

## What this repo is

A Quarto **website** hosting the landing surface for a three-part workshop, with each part embedding a Quarto **revealjs** slide deck via `<iframe>`. The parent website and the per-deck slide projects are nested but separate Quarto projects, glued together by a post-render hook.

- Three workshop parts: **Agentic Basics**, **Skill Usage and Design**, **Working Safely with Data and AI**
- Four top-level content pages: `setup.qmd` (pre-workshop setup, with `optional-software.qmd` hanging off it) plus three slide pages (`basics.qmd`, `skills.qmd`, `safety.qmd`)
- Deployed to GitHub Pages via `.github/workflows/quarto-publish.yml` on push to `main`

## Build / preview

```bash
quarto render                                # full build (parent + all decks via post-render hook)
quarto preview                               # live website; post-render hook re-runs each render to keep _site/slides/* fresh
quarto preview slides/basics                 # live preview of a single deck (hot reload as you edit it)
```

The deployed `_site/` is built end-to-end by the parent `quarto render` — CI does nothing extra.

## Architecture: nested Quarto projects

The only non-obvious part of the repo. Read this before touching any `_quarto.yml` or the build flow.

**Parent project** (`/_quarto.yml`) — `type: website`, builds the landing pages. It explicitly excludes `slides/**` from its render list (`!slides/**`) so the website doesn't try to render the decks as website pages (which would fight revealjs format and apply the navbar/footer to slides). It also excludes `**/resources/*.qmd` so partials don't become standalone pages.

**Per-deck projects** (`slides/<deck>/_quarto.yml`) — each deck is its own `type: website` Quarto project so its `_site/` output dir, theme, and revealjs format stay isolated from the parent.

**Glue** — the parent declares `post-render: [scripts/render-slides.sh]`. After every parent render (including in `quarto preview`), the script renders each `slides/*/` subproject and copies its `_site/` into the parent's `_site/slides/<deck>/` so the iframes resolve. Without the hook the parent re-render would wipe `_site/slides/` and the iframes would 404.

**Quarto's `_metadata.yml` cascade does NOT cross nested project boundaries.** Shared deck config lives in `slides/_shared.yml` and is pulled in via `metadata-files: [../_shared.yml]` in each deck's `_quarto.yml` — the documented way to share metadata across nested projects.

**The deck theme is a custom Quarto format: `touhou-revealjs`.** The single real copy lives in `slides/_extensions/touhou/` (`_extension.yml` with all revealjs format options, `touhou.scss` theme, `lucide.html` icon loader, `practice-timer.html`, `control-buttons.html`, `print-footer.html`; asset paths in `_extension.yml` resolve relative to the extension dir). Quarto only searches for `_extensions` inside each project, and the decks are separate nested projects, so each deck has a symlink `slides/<deck>/_extensions -> ../_extensions` (tracked in git). A new deck needs only that symlink plus `format: touhou-revealjs`. Theme identity (fonts, colors, control buttons, timer, print footer, default navy title-slide attributes) belongs in the extension; workshop-specific content (author, footer text, execute defaults) stays in `slides/_shared.yml`.

## Top-level pages

Navbar order is the source of truth (`_quarto.yml` → `website.navbar.left`):

| Page | File | Role |
|---|---|---|
| Home | `index.qmd` | Landing: author cards (`resources/authors.qmd`), GW affiliation, four Part-N section grids (`resources/part-{0,1,2,3}-overview.qmd`). Part 0 is a two-card row: Setup (links to `setup.qmd`) and Suggested Reading (external Anthropic article) |
| 0. Setup | `setup.qmd` | Pre-workshop setup — two sections (Essentials, Alternatives) pulled in from `resources/essentials.qmd` and `resources/alternatives.qmd` (both use the `.altgroup-*` titled-halves layout: Essentials is three halves via `.altgroup-row-3`, one full-size card each for IDE/Agent/Hosting in that deliberate order, since Positron has to exist before the Claude Code install steps below can run; Alternatives is a single full-width untitled group via `.altgroup-row-1`, two full-size agent cards, **Gemini CLI first because it is the free one**), plus the `resources/install-claude.qmd` walkthrough under Essentials and a button to `optional-software.qmd`. Alternatives lists **agents only**: alternative IDEs were cut because the workshop standardizes on Positron and offering editor choices undercut that. A `.freenote` callout under Essentials points cost-sensitive attendees at the `#alternatives` anchor, since "do I have to pay?" is the first question this page gets. The workshop runs the Claude Code **CLI inside Positron's terminal**, never the desktop app or the browser, so the Agent card links to Claude Pro signup (not the Claude Code product page, which leads with a desktop-app download) and the install steps stay inside Positron end to end. A caret button injected by `styles/styles.js` also hangs an "Optional Software" flyout off the navbar's Setup pill; it matches on `href$="setup.html"`, so renaming this page again means updating that selector |
| 1. Agentic Basics | `basics.qmd` | iframes `slides/basics/` |
| 2. Skill Usage and Design | `skills.qmd` | iframes `slides/skills/` |
| 3. Working Safely with Data and AI | `safety.qmd` | iframes `slides/safety/` |

Slide page filenames and their deck directories under `slides/` share the same short names (`basics`, `skills`, `safety`). The iframe `src` attribute inside each slide page is the source of truth — if you rename a deck directory, update the iframe `src`/`href` in the corresponding qmd to match.

### Body-width override on slide pages

`basics.qmd`, `skills.qmd`, `safety.qmd` each set `grid: { sidebar-width: 0px, body-width: 1200px, margin-width: 0px }` so the iframe stretches past Quarto's 800px default. `index.qmd` and `setup.qmd` use the same override without `body-width` (default 800px is fine for them).

## Shared assets

- `slides/_extensions/touhou/` — the `touhou-revealjs` custom format: every shared revealjs format option (`_extension.yml`), the deck SCSS (`touhou.scss`: TsangerJinKai font, color utility classes like `.amber` `.teal`, slide-variant classes like `.dark-centered` `.light-centered`), the Lucide loader, practice timer, control buttons, and print footer. Edit here to change all decks at once.
- `slides/_shared.yml` — workshop-level metadata shared across decks: author, footer text (under `format: touhou-revealjs:`), execute settings.
- `slides/<deck>/_quarto.yml` — `project:` + `resources: figs/` + `metadata-files: [../_shared.yml]` + `format: touhou-revealjs`. ~10 lines (basics adds `include-in-header: resources/_header.html` for its deck-specific embedded-site JS).
- `slides/<deck>/index.qmd` — front matter (`pagetitle`, `title`, **per-deck** `title-slide-attributes` for the banner image), then slide content.
- `slides/<deck>/figs/banner.png` — round PNG (transparent corners) used as the title slide's `data-background-image`. See "Title slide & banner mechanics". The `figs/` dir also holds any deck-local copies of shared images (headshots, logos): decks are nested projects and cannot reference the parent `images/` dir, so copy assets in.
- `styles/styles.scss` — parent **website** styles. All component CSS lives here (see "Component CSS conventions") — never inline `<style>` blocks in qmd files.
- `styles/styles.js` — parent-website JS entry, loaded via `include-after-body` in `_quarto.yml` alongside the Lucide icons CDN. Touch this for landing-page behavior or icon rendering changes.
- `images/` — parent website static assets, registered as a Quarto resource in `_quarto.yml` so it's copied into `_site/` as-is. `images/software/` holds the app icons used by `resources/optional-software.qmd`; `images/{pingfan-hu,john-helveston}.png` are the author headshots.
- `resources/*.qmd` — partials included into top-level pages via `{{< include >}}`. Excluded from the parent render list so they never render as standalone pages.
- `skills/` — the workshop's own Claude Code skills, which attendees copy into their project's `.claude/skills/` during the Part 2 practice. They are **shipped for participants, not used by this repo**. Two of them:
  - `build-webpage/` — adds one page in the bundled Tom Hanks example site's design (`template/` holds that example site and its stylesheet).
  - `publish-website/` — one `index.html` check, then seven steps walking the user through Netlify Drop **by hand, drag and drop**. It must never install a CLI or deploy anything itself: attendees sign up for Netlify beforehand and do the upload in a browser, and the skill giving one step at a time is the whole lesson. **Keep it short.** An earlier version tracked the deployed address in a `SITE-URL.txt` and branched between a first-publish and an update path; that was cut as too much machinery for an 18-minute practice where nobody redeploys. Re-dropping a folder makes a *new* site rather than updating the old one, which the skill now just mentions in a note instead of handling.

## Component CSS conventions

For tables, card grids, author cards, etc.:

- HTML lives in a `resources/<name>.qmd` partial, wrapped in a `{=html}` fence.
- CSS lives in `styles/styles.scss` under a topic header comment like `// ---- Authors ----` or `// ---- Software Table ----`.
- **Never inline `<style>` or `<link>` blocks in the qmd file** — Maple Mono is `@import`-ed at the top of `styles.scss` and Lucide icons are loaded globally via `_quarto.yml`'s `include-after-body`.
- Dark-mode overrides live inside the single `body.quarto-dark { ... }` block in `styles.scss`.
- Mobile breakpoint is `@media (max-width: 640px)` (used consistently across all components).

Current component families in `styles/styles.scss`:
- `.swtbl-*` — two-column table in `resources/optional-software.qmd` (icon + name on left, description on right, with a head/body layout that flips on mobile)
- `.instl-*` — numbered install walkthrough on the setup page (`resources/install-claude.qmd`). Unlike the other partials this one is **plain fenced divs, not a `{=html}` fence**, so its ```bash / ```powershell blocks stay real Quarto code blocks and keep the copy button plus the language label from `styles.js`. Step numbers come from a CSS counter on `.instl-step::before`, so steps renumber themselves when reordered. `.instl-title` / `.instl-os` need `p { margin: 0 }` because Pandoc wraps fenced-div contents in a paragraph
- `.altgroup-*` / `.esscard-*` — grouped card rows on the setup page (`resources/essentials.qmd` and `resources/alternatives.qmd`): titled halves with a soft vertical divider, cards with icon tile + name + description. Two halves by default; `.altgroup-row-3` makes it three (Essentials), `.altgroup-row-1` makes it one full-width group (Alternatives). The divider keys off `.altgroup + .altgroup`, so extra halves need no further CSS and a single group draws none
- `.freenote` — tinted teal callout on the setup page pointing at the free agent in Alternatives. Deliberately louder than `.agents-disclaimer`. Written as plain fenced divs, so `.freenote-icon` needs `p { margin: 0 }` (Pandoc wraps the icon span in a paragraph)
- `.auth-*` — author headshot cards in `resources/authors.qmd`
- `.section-*` — colored Part-N section grids in `resources/part-{0,1,2,3}-overview.qmd`
- `.slide-embed*` — iframe wrapper used by the three slide pages
- `.affiliation*` — GW affiliation row at the top of `index.qmd`

## Hover effects on slide elements — avoid the shake

Hover effects on cards or in-card links must not visibly shift the surrounding card. Two failure modes seen in this repo:

1. **`transform: translateY(-Npx)` on hover.** On retina displays the transform promotes the hovered element to a new GPU compositor layer, which forces a subpixel repaint of its siblings inside the same card. The whole card appears to "shake" for a frame. Fix: drop the hover transform — use only `box-shadow` and/or `background-color` changes to signal hover. A press transform on `:active` is fine (momentary).
2. **First-time layer promotion on `opacity` transition.** Same root cause: when the opacity transition starts, the browser creates the layer on the fly. Pre-promote with `will-change: opacity, transform;` (and optionally `backface-visibility: hidden;`) so the layer exists before hover.

`.instructor-link` (about slide), `.tool-link` (s1-three-tools slide), `.tool-card` (practice cards), and `.thanks-card` / `.logo-chip` (safety thank-you slide: whole-card links with a blue hover tint on a dark slide) in `slides/_extensions/touhou/touhou.scss` all follow this pattern. When adding a new hoverable element, default to: no hover transform, `box-shadow`/`background`/`color` changes only, `will-change` pre-set, `:active` for the click press.

## Quarto theme overrides

Quarto's bundled theme CSS uses high-specificity selectors with the `.quarto-title-block.default` chain. Naïve `#title-block-header .description` rules **lose** to Quarto's `#title-block-header.quarto-title-block.default .description { margin-top: 0 }`. Match the full chain to compete on equal specificity (later-source rules then win); reach for `!important` only as a last resort. The page-description block styling under `// ---- Page description block ----` in `styles.scss` is the working example.

## Title slide & banner mechanics

Each deck has a navy title slide with a circular banner image on the right. Three things must stay in sync:

1. **The banner is a CSS background on the `#title-slide` section, NOT Reveal's `data-background` layer.** Each deck's `index.qmd` `title-slide-attributes` sets the image inline per-deck via `style: "text-align:left; background-image: url(figs/banner.png);"` (the url resolves relative to that deck's index.html). Reveal's `data-background-image` was deliberately dropped: that layer fills the whole unscaled iframe, so the banner drifted off-position and stayed huge when the viewport got short. As a CSS background on the section, the banner lives INSIDE the scaled `.slides` stage, so it sizes and positions relative to the slide content and scales with it, exactly like a body slide. The `title-slide-attributes` block must still include `data-background-color` and `class: dark-centered`.
2. **The banner PNGs are circularly masked** (transparent outside the circle). Generated by `/ph-image` skill, then post-processed with PIL ellipse mask. If you regenerate a banner, re-apply the mask or it'll show as a square.
3. **Two rules in `slides/_extensions/touhou/touhou.scss` finish the job.** `#title-slide.dark-centered { background-color: transparent !important; }` keeps the section transparent so the navy `data-background-color` layer shows behind the circular banner (without it, `.dark-centered`'s opaque navy fill would cover the area). Scoped to `#title-slide` so other `.dark-centered` slides keep their solid navy fill. `#title-slide { background-size: 24%; background-position: right 20% center; background-repeat: no-repeat; }` sets the banner's size and placement (percentages relative to the 1050x700 stage).

The banner image path lives in each deck's `index.qmd` (inline `style`); the shared size/position live once in `slides/_extensions/touhou/touhou.scss` under `#title-slide`. To resize or reposition the banner for all decks, edit that `#title-slide` rule; to swap the image for one deck, edit that deck's inline `style`.

## Slide content conventions

There are no speaker scripts (the per-deck `SCRIPTS.md` files were removed); each deck's `index.qmd` plus its `resources/*.qmd` partials are the single source of truth.

- Pacing target: ~25 minutes per part, ~19-26 slides each. Content slides use `.light-centered` or default; `.dark-centered` is reserved for the title slide, the roadmap, practice slides, and punctuation/closing slides (quotes, thank-you)
- **Roadmaps**: every deck's roadmap is exactly three bars (icon tile + title only, no subtitles, no header line). The three titles and Lucide icons must stay in sync with the matching home-page part cards in `resources/part-{1,2,3}-overview.qmd`
- **Panel slides** all share one anatomy (left accent bar, uppercase kicker, headline, stacked icon cards, hairline footer line) and differ only by accent color and kicker. Three variants exist, and the color is what tells the room whether to type or to watch:
  - **Practice** (amber `#FFB84D`, has a `practice-timer`): exactly one per deck that has one, both unnumbered (`— practice —`): basics 20 min, skills 18 min. Each closes with two footer lines, a `Thumbs up when…` line so the room can signal it is done over Zoom, and a `Finished early?` stretch line so fast people have somewhere to go
  - **Checkpoint** (teal `#6FC2B0`, no timer): `slides/basics/resources/checkpoint.qmd`, a short "make the folder, open it in Positron, start `claude`" sync, deliberately not numbered so the practice reads as the fun part. It absorbed the old "Open your workspace" slide, so this is the only place the project folder gets created; its footer links the live setup page for anyone who arrives with nothing installed
  - **Demo** (blue `#7FB0E6`, no timer): `slides/safety/resources/demo.qmd`. Safety has **no hands-on practice at all** by design, since it is last in a 2-hour webinar. It is a recreation exercise: a dashed callout names the target chart and links it (an Our World in Data grapher), then three cards describe what the instructor does, and the footer says outright that there is nothing to type
- Panel slides keep the `.practice` class on their `## &nbsp;` header regardless of variant: that class hides the placeholder `h2` and positions the timer, so it is doing layout duty, not semantics
- **Tall panels overflow easily and Reveal clips rather than scrolls.** The stage is 1050x700 and a panel with four cards plus two footer lines runs past it. The two practice partials and the safety demo wrap their content in `.practice-box` (defined in `touhou.scss`), whose `font-size` scales the entire panel at once, since every size inside those partials is em-based. If a panel gains a card, shorten the copy first and drop that one font-size second. Do not trim the inline sizes individually: that is how the panels drift out of sync. The checkpoint panel is short enough that it keeps its own inline wrapper
- **The safety deck's Africa sequence is three slides in a fixed order** (`africa-bad` → `africa-good` → `africa-code`), between the Code-Based Pipelines divider and the pipeline example. It runs the argument end to end: a real State Department slide with every country shape in the wrong place, then the BBC graphic showing exactly what was wrong, then the same map rebuilt from code over real boundaries. Both photos carry a tiny BBC source line. **Both are sized by `max-height` on the `<img>`, never by width**, inside a `width:max-content` card: height is the scarce dimension on the 700px stage, and a width percentage would let the aspect ratio push either photo off the bottom (`africa-bad.png` is landscape 1024x576, `africa-good.png` portrait 1024x1338). To resize either photo, edit that one `max-height` and nothing else. `africa-code.qmd` is a live plotly widget, a country-level Africa port of the `codify-map.qmd` USA pattern (same map-plus-bars subplot, same `onRender` click/hover JS) with two deliberate differences: all six countries start **selected** (bars showing, reset restores the all-selected state rather than clearing), and each country keeps the **categorical color of the original State Department slide** (hues sampled from the photo with saturation restored; the `pal` vector in the R chunk, applied to both map fill and bar fill via a discrete colorscale and `marker.color` restyles). Clicking a country toggles its bar; each bar carries a two-line label (dollars, then award count), and the hover tag and bar hover show both metrics as "Up to $X / Up to N awards". Its data is the real APS figures read off `figs/africa-bad.png`, kept in `data/africa-aps.csv` (iso, name, funding in raw dollars so `$~s` tick formatting works, awards). Funding drives bar length; awards ride along as labels, since the two scales cannot share an axis. The slide replaced the old `usa-map.qmd`, whose `figs/usa-map.png` is still in the repo
- **Total practice time is a hard budget.** The workshop is 2 hours against ~50 content slides, so timers cannot drift upward without something else being cut. Current total is 38 min (20 basics, 18 skills). Basics used to run two practices (20 + 10) split across the deck; they were merged into one 20-minute practice sitting *after* the modes and commands slides, so attendees build the site once with plan mode, `/rewind`, `/clear`, and `/init` all in play rather than building it twice
- Quote/closing slides put `margin-top:1.1em` on the first content block so the title breathes; roadmaps use the same gap on the bar stack

## Project hooks

There are **no project-level hooks**. `.claude/settings.local.json` is an empty file, and there is no `scripts/refresh-preview.sh` (the only file in `scripts/` is `render-slides.sh`, the post-render glue). Nothing auto-cleans `_site/` or restarts `quarto preview`.

**Do not delete `_site/`** as a cleanup step. The user may have a live `quarto preview` build there; removing it wipes their served output. If you need Quarto's compiled output to inspect (e.g. the generated CSS), render into a throwaway location or leave the existing `_site/` in place, and never `rm -rf _site` in this repo.

## Stale `.quarto/idx` after editing shared format config

Changes to **format-level** options in `slides/_shared.yml` or `slides/_extensions/touhou/_extension.yml` (the shared revealjs config) may not take effect on the next render, because Quarto bakes those values into each deck's `.quarto/idx` cache and reuses it for fast incremental rebuilds. The compiled `_site/index.html` then keeps re-emitting the old value no matter how many times you restart `quarto preview` — the source config looks right but the behavior doesn't change.

Symptom seen once: flipping `preview-links: auto` → `false` correctly set reveal's `previewLinks: false`, but Quarto's separate `previewLinksAuto` (the fullscreen link-preview handler that produces the "Unable to load iframe … x-frame-options" overlay when a slide links to an external site like GitHub) stayed `true` from cache, so external links kept opening in a failing iframe instead of a new tab.

Fix: force a clean render of the affected deck(s) — `rm -rf slides/<deck>/.quarto slides/<deck>/_site && (cd slides/<deck> && quarto render)`. If the option lives in `_shared.yml` or the extension, it affects all three decks, so clear and re-render **all** of `slides/*/`. Verify with `grep -o "previewLinksAuto': [a-z]*" slides/<deck>/_site/index.html`. Content-only edits (qmd/scss) don't hit this — only shared **format metadata** does.

## Gitignore behavior

`.gitignore` has a bare `_site` entry, which matches `_site/` anywhere in the tree (parent's `_site/` and each deck's `slides/<deck>/_site/`). Don't change this to `/_site` — the nested build outputs would start getting committed.

## Settings file

`.claude/settings.local.json` is intentionally an **empty file** — no hooks, no permissions. The user runs in auto mode, so accumulated permission allowlists aren't kept around. Don't add a `permissions.allow` block (or any other config) back unless explicitly asked.
