# Workshop Improvement Plan (Advisor Feedback, 2026-08-05)

Feedback from advisor after a full read-through of all three decks. Discussion scheduled for Friday (2026-08-07). Slide numbers below are revealjs slide positions (title slide = 1), each mapped to the actual slide title and source partial so items are directly actionable.

---

## A. General, workshop-wide feedback

### A1. One running example across the entire workshop
- Use the SAME project (the personal website) as the single example and practice vehicle through all three parts.
- Part 1 builds the website. Part 2 practices skills that MODIFY that same website. Part 3 practices safety/data work inside that same project.
- Participants should create the project once and keep returning to it: **one folder, one Positron window, one Claude session**.
- Implication: every practice slide in decks 2 and 3 must be rewritten to build on the `my-site` project instead of introducing new contexts.

### A2. Simplify aggressively for the audience
- Most attendees will not know how these tools work internally. Aim for very, very simple examples everywhere.
- Cut anything that assumes background knowledge (symlinks, Quarto, git jargon, mac app deployment, complex plugins).

### A3. The website task is the right anchor
- Claude is very good at writing HTML, so the website works even for people who do not understand HTML. Keep it as the throughline example.

---

## B. Deck 1: Agentic Basics (`slides/basics/`)

### B1. Slide 7 "Where you launch matters" (`resources/two-directories.qmd`): CUT
- Feels out of place: it references CLAUDE.md before the audience knows what a CLAUDE.md file is.
- The concept is covered later on slide 18 "The CLAUDE.md file" (`resources/claude-md.qmd`), so just cut slide 7.

### B2. Slide 17 practice 2 (`resources/practice-2.qmd`): two changes

**(a) Add a step 4: publish to Netlify**
- New final step: publish the site to https://www.netlify.com/.
- Deliberately do NOT explain how Netlify works. Instruct participants to ask Claude for help figuring it out (that IS the lesson).
- Payoff: they get a real URL they can drop in the chat to share. Without this they have no way to deploy the site.

**(b) Give explicit "how to start" instructions**
- Mirror the explicitness of slide 8 "Open your workspace" (`resources/setup.qmd`).
- Remind them the very first step is making a folder. Spell it out literally, e.g.:
  1. On your Desktop, make a folder called `my-site`
  2. Open Positron and open that folder
  3. In the terminal, type `claude`
  4. THEN start prompting for the website
- (This folder/window/session is the one they keep for the whole workshop, per A1.)

### B3. Slides 21 to 23, the skills block: CUT
- Slide 21 "Skills" (`resources/skills.qmd`)
- Slide 22 "Installing skills" (`resources/install-skills.qmd`)
- Slide 23 "Build your skill" (`resources/website-to-skill.qmd`)
- All of this is covered in Deck 2. Remove from Deck 1 entirely.

### B4. Slide 24 practice 3 (`resources/practice-3.qmd`): REPLACE with a simpler slash-command practice
- Since the skills block is cut, the current skill-building practice no longer fits.
- New practice: exercise the basic slash commands, for example:
  - change the model
  - change the effort level
  - use `/compact`
  - use `/clear`
- Reference example from advisor's class: https://eda.seas.gwu.edu/2026-Fall/class/2-agentic-workflows/index.html#/your-turn

### B5. Slide 26 "One More Thing..." (`resources/hardest-skill.qmd`): MOVE
- Move this closing slide to the end of the ENTIRE workshop (end of Deck 3), not the end of Part 1.

---

## C. Deck 2: Skill Usage and Design (`slides/skills/`)

### C1. Restructure the opening: definition first, then a simpler motivating example
- Current slide 5 "What is a skill?" (`resources/what-skill.qmd`) should come FIRST, before any examples.
- Broaden the definition. It is too constrained as "multi-step processes". A skill is more broadly **a way of codifying sets of instructions you want Claude to use**: norms, patterns, and even full workflows.
- Start with a SIMPLER first skill example than the current one. Advisor's chart-styling skill is a better opener: https://eda.seas.gwu.edu/2026-Fall/class/2-agentic-workflows/index.html#/42
  - No need to fully explain the skill yet; just show the idea that skills codify norms and patterns.
- THEN escalate to skills that capture multi-step workflows, using the existing image-creation example (current slide 4, `resources/motivation-image.qmd`, which advisor likes).

### C2. Slide 3 "Without vs with a skill" mac-app example (`resources/motivation.qmd`): CUT
- Deploying a mac app is a major conceptual jump. One good example is enough, and the image example on slide 4 is the better one.

### C3. Slide 7 "/read demo" (`resources/read-demo.qmd`): swap the demo page
- Showing `/read` is good, but the Quarto blog post is full of jargon (Quarto, git) most attendees will not know.
- Use a simple page everyone can understand: something on Wikipedia, or a GW website page.

### C4. Slide 8 practice 1 (`resources/practice-1.qmd`): drop Waza, use a simpler skill tied to the website
- Waza is a complex plugin with lots of skills; too much for this audience.
- Find one simple skill that lets them build on the website they made in Part 1 (per A1).
- Note: this likely also affects slide 6, the Waza showcase (`resources/waza-skills.qmd`), which may need rethinking or cutting once Waza is out of the practice.

### C5. Slide 11 "Create symlinks" (`resources/link-skills.qmd`): CUT
- Symlinks are too advanced. Just teach putting skills in the project-local `.claude/skills/` folder inside the website project they are already working in.

### C6. Slide 15 "Skill for a same topic" (`resources/case-subsections.qmd`): CUT
- The image skill already demonstrates that skills can be much more complicated. This one is not needed.

### C7. Slide 17 block (determinism / patterns content): MOVE BEFORE the final practice
- The content starting at slide 17 (`resources/determinism.qmd`, plus `randomness-gift.qmd` and `seasoning.qmd`), specifically the idea that skills capture patterns like image styling for consistency, should come BEFORE the final practice.
- That "skills codify patterns for consistency" message is all that is needed to show how powerful skills are. THEN let them build and test their own skill.

### C8. Slide 16 practice 2 (`resources/practice-2.qmd`): make it specific and website-based
- This becomes the LAST practice of the section (after the reordering in C7).
- Current version is too open-ended: "we've described all these cool things" but attendees will not know where to start.
- New task: have them make their own skill that is specifically related to their website (per A1). We need to design one concrete, specific skill task for them.

---

## D. Deck 3: Working Safely with Data and AI (`slides/safety/`)

### D1. Add plain-background section-divider title slides
- One plain, colored, few-words divider slide per main idea, to break the talk into sub-sections:
  1. Using GitHub
  2. Building code-based pipelines
  3. Protecting sensitive data
- Different plain background colors per divider help signpost the core ideas.

### D2. Slide 3 "Use agents wisely" (`resources/use-wisely.qmd`): CUT
- Risk of offending: it can be read as claiming everybody (especially "mentors") says do not use AI, which is not true and not the intent.
- The real point ("we need to learn to use these tools wisely") can be said verbally on the title slide, then go straight into the safe-usage content.

### D3. Slide 6 pipeline section (`resources/pipeline-example.qmd`): rename and reframe
- Rename to "code-based pipelines": most attendees do not know what "pipelines" means.
- Center the section on the core mantra: **"build the code, not the artifact"** (the language advisor uses in classes and the posit::conf talk).
- Frame: we use Claude to build the code, then we run the code to build the artifact.

### D4. Slide 13 fake data (`resources/fake-vs-real.qmd`): layout and content changes
- Put the "Real" data example on the LEFT and the "Fake" one on the RIGHT, titled exactly "Real" and "Fake".
- Add the Python `faker` package (https://github.com/joke2k/faker) alongside charlatan:
  - more people know Python than R
  - faker came first; charlatan is a port of faker

### D5. Slide 14 maps example (`resources/codify-map.qmd` and `codify-map-au.qmd`): MOVE into the pipelines section
- The USA/Australia map example actually belongs in the code-based pipelines section (D3), not where it is now.
- Suggested flow for the pipelines section:
  1. Open with the Africa image as motivation (how embarrassing it is when you do NOT use pipelines)
  2. Explain what code-based pipelines are
  3. Show the map examples as the payoff: how easy it is to get things right when you ask for code instead of the artifact directly

### D6. Slide 16 final practice (`resources/practice.qmd`): make it a concrete data-analysis task
- Ask them specifically to do a data analysis in Positron.
- Use Python, not R: most computers have Python installed, most do not have R.
- Concrete direction: go to a specific page, pull the data from it, and reproduce the figure in Python.
- Suggested target: https://ourworldindata.org/population-growth
- Rationale: attendees probably do not know R or Python, so a very specific target gives them something to aim at (and Claude does the coding).

---

## E. Cross-cutting implications to resolve while implementing

- **Practice continuity (A1):** audit every practice slide in all three decks so each one explicitly continues in the `my-site` folder / same Claude session.
- **Roadmap sync:** cutting/moving slides changes each deck's roadmap and the matching home-page part cards (`resources/part-{1,2,3}-overview.qmd`). Both must stay in sync per repo convention.
- **Deck 1 flow after cuts:** removing slides 7 and 21 to 23 and replacing practice 3 changes Deck 1's arc; check pacing still lands near the ~25 minute target.
- **Deck 2 reordering:** C1 + C7 amount to a substantial resequencing of Deck 2 (definition first, simple example, workflow example, authoring, patterns/consistency content, then one final specific practice).
- **Deck 3 ending:** Deck 3 gains the moved "One More Thing..." slide from Deck 1 (B5), plus divider slides (D1); check the closing sequence still flows (practice, takeaways, One More Thing, closing, thank-you or similar).
- **Open design questions to settle before implementing:**
  1. Which simple skill to use for Deck 2 practice 1 (C4) that modifies the website?
  2. What exact website-related skill task to assign in Deck 2's final practice (C8)?
  3. Whether the Waza showcase slide survives at all once Waza leaves the practice (C4).
  4. Where the Africa image comes from / needs to be sourced for D5.
