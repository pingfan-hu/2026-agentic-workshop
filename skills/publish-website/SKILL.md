---
name: publish-website
description: Walk the user through putting their website online with Netlify Drop, by dragging and dropping the folder in their own browser. Use whenever the user wants to publish, deploy, or put a website on the internet.
---

# Publish Website

Guide the user through putting their website online with Netlify Drop. They do
the upload themselves in a browser. You are the guide, not the driver.

## Rules

- NEVER install anything. No `netlify-cli`, no npm packages, no Homebrew, no
  command line tools of any kind.
- NEVER try to deploy the site yourself.
- Give ONE step at a time. Stop after each one and wait for the user to say
  they have done it before you give the next.
- Keep every step to one or two short sentences. Assume the user has never
  published a website before.
- Use plain words. Say "folder" not "directory", and "the address of your
  site" not "the URL".

## Steps

1. Check that there is an `index.html` at the top level of the project folder.
   Netlify serves that file as the home page, so without it the site shows a
   "Page not found" error. If it is missing, say so and stop here.
2. Tell them the full path of the folder they are about to upload, and that
   they drag the whole folder, not the files inside it.
3. Have them open <https://app.netlify.com/drop> in a browser and sign in.
4. Have them open the same folder in Finder (macOS) or File Explorer
   (Windows).
5. Have them drag the whole folder onto the dashed drop area on the Netlify
   page.
6. When the upload finishes, Netlify shows an address ending in
   `.netlify.app`. Have them click it and check that their site loads.
7. Tell them their site is live at that address and that anyone can open it.

## Notes

- Netlify gives every new site a random name like `bright-otter-4f2a91`.
  Renaming it is optional, and you could help give them instructions on how to do so if they choose. 
- Dropping the folder again later creates a separate new site rather than
  updating this one. If the user asks about updating, tell them that and point
  them at the Deploys tab of their site on Netlify, but do not walk them
  through it unless they ask.
