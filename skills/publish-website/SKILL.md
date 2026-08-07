---
name: publish-website
description: Check a static website folder for problems, then walk the user through putting it live on Netlify by hand with drag and drop. Use whenever the user wants to publish, deploy, ship, or update their website.
---

# Publish Website

Get the user's website onto the internet using Netlify. The user already has
a free Netlify account. They publish by dragging their project folder onto a
page in their browser, and your job is to check the site first and then talk
them through the upload one step at a time.

## Rules

- NEVER install anything. No `netlify-cli`, no npm packages, no Homebrew, no
  command line tools of any kind.
- NEVER try to deploy the site yourself. The user does the upload in their
  browser. You are the guide, not the driver.
- Give ONE step at a time. Stop after each one and wait for the user to say
  they have done it before you give the next.
- Keep every step to one or two short sentences. Assume the user has never
  published a website before and does not know what "deploy" means.
- Use plain words. Say "folder" not "directory", and "the address of your
  site" not "the URL endpoint".

## Workflow

### 1. Check the site before publishing anything

- Confirm there is an `index.html` at the top level of the project folder.
  Netlify serves that file as the home page, so without it the published site
  shows a "Page not found" error.
- Open every HTML file. Check that each link points at a file that really
  exists, and that every stylesheet link resolves.
- Report what you found as a short list. Fix anything broken, show the user
  what you changed, and ask them to confirm before moving on.

### 2. Work out whether this is a first publish or an update

Look for a `SITE-URL.txt` file in the project folder.

- **No such file**: this is their first publish. Use step 3a.
- **File exists**: they already have a site. Read the address out of it and
  use step 3b. Dragging to the wrong page would create a second, separate
  site instead of updating the one they already have, which is the most
  common way this goes wrong.

### 3a. First publish

Tell them the full path of the folder to upload, and list the files inside
it. Stress that they drag the whole folder, not the files inside it. Then
walk them through, pausing after each step:

1. Go to <https://app.netlify.com/drop> in a browser and sign in.
2. Open the project folder in Finder (macOS) or File Explorer (Windows).
   Give them the exact path.
3. Drag the whole folder onto the dashed drop area on the Netlify page.
4. Wait for the upload to finish. Netlify shows an address ending in
   `.netlify.app`.
5. Click that address and confirm the site loads.

Ask them to paste the address back to you, then write it into
`SITE-URL.txt` so the next run can find it.

### 3b. Updating a site they already published

Dragging onto the Drop page again would create a brand new site. To update
the existing one, walk them through, pausing after each step:

1. Go to <https://app.netlify.com> and sign in.
2. Click the site whose address matches the one in `SITE-URL.txt`.
3. Open the **Deploys** tab.
4. Drag the whole project folder onto the deploy area at the bottom of that
   page.
5. Wait for the new deploy to finish, then reload the site and confirm the
   change is there.

### 4. Confirm and wrap up

Ask the user to open the live address and check the specific thing they
changed. If it looks stale, have them reload the page bypassing the cache
(Shift and reload). Finish by telling them the address of their live site.

## Notes

- Netlify gives every new site a random name like `bright-otter-4f2a91`. The
  user can rename it under Site configuration, but that is optional and not
  worth the detour during a workshop.
- If the user asks to connect the site to GitHub or set up automatic
  deploys, say that it is possible but out of scope here, and stick to the
  drag and drop flow.
