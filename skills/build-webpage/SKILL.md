---
name: build-webpage
description: Add one new page to an existing website, styled after the bundled Tom Hanks example site (its shared stylesheet and page designs). Use for any request that adds a page to a site.
---

# Build Webpage

Add ONE page at a time to the user's existing website, in the design of the
bundled example site. The example lives in `template/`: a Tom Hanks site
where `index.html` (hero, then a list of linked cards) links to five film
pages (top bar with a back link, hero, one content section), all sharing
`template/styles.css`.

## Workflow

1. Bring the stylesheet into the project:
   - If the project has no shared stylesheet, copy `template/styles.css`
     into it as `styles.css` and link it from the new page.
   - If the project already has a shared stylesheet, paste the full
     contents of `template/styles.css` into that existing file (keep the
     existing rules; append the template's rules after them) and link the
     existing file from the new page.
2. Pick the example page that matches the request:
   - a landing or overview page: model it on `template/index.html`
   - a detail page about one thing: model it on any film page, e.g.
     `template/forrest-gump.html`
3. Create the new page from that model: same head, same section order, same
   class names (`hero`, `eyebrow`, `tagline`, `film-list`, `film-link`,
   `back-link`, `bio`), with the user's content swapped in.
4. Wire it up: link the new page from the page(s) it belongs under, and if
   it is a detail page give it the top-bar back link.

## Rules

- One page per request. Do not rebuild, restyle, or touch the other pages
  beyond adding the link to the new page.
- No inline styles and no new stylesheet: the shared stylesheet and the
  template's classes carry the whole design.
- If a needed style truly does not exist, add it to the shared stylesheet,
  following the template's naming and variable conventions (`--accent`,
  `--ink`, `--muted`, `--surface`, `--bg`, `--line`).
- Keep the writing voice friendly and short.
