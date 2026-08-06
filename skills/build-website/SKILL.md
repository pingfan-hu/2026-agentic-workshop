---
name: build-website
description: Build or extend a website starting from the bundled template. Use for any request that creates a site, adds a page, changes layout, or touches styling.
---

# Build Website

Build websites that all share one look and one structure. Start every site
from the template in this skill's `template/` folder, then adapt it to what
the user asks for.

## Workflow

1. Copy `template/styles.css` into the project as the shared stylesheet.
2. Create the home page from `template/index.html`.
3. Create every other page from `template/page.html`.
4. Fill in the user's content, keeping the template's structure intact.

## Site structure

- Every page links the same `styles.css`; do not write inline styles.
- Every page has the same nav bar at the top, linking to every page of the
  site. When adding a new page, update the nav on every existing page.
- Every page ends with the same footer.
- The home page is `index.html`; other pages get short lowercase filenames
  like `about.html` or `projects.html`.

## Design conventions

The template's CSS already implements these; keep them when editing:

- Colors: background `#FAF7F2`, text `#2C3E50`, teal accent `#2C8475` for
  links and buttons, amber `#FFB84D` sparingly for callouts.
- Typography: Georgia for headings, Helvetica/Arial for body, 18px body text
  with line-height 1.6.
- Layout: content column max-width 720px, centered, at least 2em between
  sections.

## Notes

- Follow the user's instructions for content and pages; the template decides
  the look and structure unless they say otherwise.
- Keep the writing voice friendly and short.
