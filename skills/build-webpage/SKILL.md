---
name: build-webpage
description: Add a new page to an existing website, reusing the site's design and CSS. Use for any request that adds a page or extends a site that already has pages.
---

# Build Webpage

Add one page to a site that already exists. The new page must look like it
was always there: same stylesheet, same nav, same footer, same voice.

## Workflow

1. Read the existing pages (start with `index.html`) to learn the site's
   stylesheet link, nav bar, footer, and title pattern.
2. Create the new page from `template/page.html`, swapping in the site's
   real nav and footer and linking the site's existing stylesheet.
3. Fill in the requested content, keeping the template's section structure.
4. Add the new page to the nav bar of every existing page.

## Page conventions

- Reuse the site's shared stylesheet and its existing classes; do not write
  inline styles or create a second stylesheet.
- If a new style is truly needed, add it to the shared stylesheet so every
  page can use it.
- Short lowercase filename like `about.html` or `projects.html`.
- Structure: a title section with the page's `h1` and a one-sentence intro,
  then one section per topic.
- Keep the writing voice friendly and short.

## Notes

- Follow the user's instructions for content; the existing site decides the
  look and structure unless they say otherwise.
- If the site has no shared stylesheet (styles live inline on each page),
  first move the common look into a `styles.css` that every page links,
  then add the new page.
