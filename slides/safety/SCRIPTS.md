# Working Safely with Data and AI: Speaker Script

Speaking script for **Part 3: Working Safely with Data and AI** of the 2026 Agentic Workflows with Claude Code Workshop.

Organized into the three sections defined in `resources/part-3-overview.qmd`:

1. **Scripts, Not Results**
2. **Keep Real Data Out**
3. **You Are the Pilot**

After the three sections, one worked **bad example** shows a researcher violating all three rules in a single chat, then the deck closes with takeaways.

Audience note: attendees have a **data science background**. Parts 1 and 2 taught them to conduct agents and encapsulate skills. Part 3 is where that power meets real data, and the message shifts from "delegate more" to "delegate deliberately."

Pacing target: ~25 minutes, ~21 slides, matching Parts 1 and 2. No section divider slides; the roadmap previews the three parts once and every content slide self-explains.

---

## Opening

### Recap _(slide: Recap)_

_[~1 min]_

Quick recap. In Part 1 you learned to conduct an agent instead of handcrafting every step. In Part 2 you learned to wrap workflows into skills you can summon by name. You now have real leverage.

Part 3 asks the question that leverage raises: what happens when the agent meets your **actual data**? Data science is not a website demo. The data may be confidential, and the results may end up in a paper or a policy decision with your name on it.

### Today _(slide: Today)_

_[~1 min]_

Three habits keep AI-assisted data science safe, and they are the three parts of today:

1. **Scripts, not results.** Ask the agent how the answer is made, never for the answer itself.
2. **Keep real data out.** The agent can learn your data's structure without ever seeing its content.
3. **You are the pilot.** AI is the co-pilot. Every result still answers to you.

### Agents are inevitable _(slide: Agents are now part of the job)_

_[~1.5 min]_

Let me start with the honest premise: you **will** use agents for data work. Doing every step of wrangling, visualization, and modeling by hand no longer makes sense, any more than refusing a calculator. The productivity gap is too large to ignore, and pretending otherwise just means falling behind.

But data work is different from the website you built in Part 1 in two ways. First, the **input** can be sensitive: government records, patient data, proprietary business data. Second, the **output** carries your name: a finding, a figure, a coefficient someone will act on. So the question is never "should I use agents?" It is "how do I use them without leaking the input or losing ownership of the output?" That is the whole talk.

---

## 1. Scripts, Not Results

### Ask for the script, not the result _(slide: The script, not the result)_

_[~2 min]_

Here is the single most important habit change. The tempting prompt is: "Here is my data. Clean it and show me the table. What is the effect of X on Y?" The agent will answer. It will be fast, confident, and formatted. And you will have **no idea how the number was made**.

The better prompt costs ten more seconds: "Plan the cleaning steps and write an R script that does them. I will run it and read it." Same agent, same speed advantage. But now the deliverable is not a number, it is a **pipeline**. You can read the script, question the script, rerun the script. When a number comes out, you can point at the exact lines that produced it.

Rather than asking what the answer is, ask **how the answer is made**. That is the entire section in one sentence.

### What the agent should hand back _(slide: What the agent hands back)_

_[~1.5 min]_

Concretely, a good data-work session with an agent produces three things:

1. **The scripts.** Python or R, readable, rerunnable. The plan turned into code you can step through.
2. **The file structure.** Which files are sources, which are generated, which are support. You should be able to tell at a glance what feeds what.
3. **The judgment.** And this one is yours, not the agent's: read the pipeline and decide whether the processing is *reasonable*. The agent proposes; you evaluate.

If a session ends and you cannot point to these three things, you got a result, not an analysis.

### A structure you can audit _(slide: A structure you can audit)_

_[~1.5 min]_

The file structure deserves its own slide because it is the cheapest audit tool you have. A healthy project separates three kinds of files: **source** (the raw data, read-only, never edited in place), **scripts** (the numbered pipeline: wrangle, visualize, model), and **generated** (derived data, figures, tables, all reproducible by rerunning the scripts).

The test: could you delete every generated file and rebuild them all by running the scripts in order? If yes, the how of your analysis is fully captured. If no, somewhere a result exists that nothing can explain.

### The rule covers every stage _(slide: Every stage, same rule)_

_[~1.5 min]_

This is not just a data-cleaning rule. It covers the whole workflow:

- **Wrangling:** scripts, not pasted-back tables.
- **Visualization:** scripts, not one-off images. A figure you cannot regenerate is a screenshot, not a result.
- **Modeling:** scripts, not quoted coefficients. If the model spec lives only inside a chat transcript, you do not have a model, you have an anecdote.

At every stage the question is the same: **can I trace how this was made?** If the answer lives in a script in your repo, yes. If it lives in the agent's reply bubble, no.

---

## 2. Keep Real Data Out

### Some data can never leave _(slide: Some data can never leave)_

_[~1.5 min]_

Now the input side. Some datasets are simply not yours to share, with anyone, including an AI service: **government records** (say you work for an agency and the microdata is classified or restricted), **health and personal data** (HIPAA, IRB protocols), **proprietary business data** (contracts, NDAs), **human subjects research** (consent forms that never mentioned a model provider).

For these, "the model provider promises not to train on it" is not a policy. The safe assumption is brutal and simple: **anything that enters the chat has left the building.** Design your workflow so it never has to enter.

### Leaks happen quietly _(slide: Leaks happen quietly)_

_[~1.5 min]_

Nobody leaks a database on purpose. Leaks look like this:

- Pasting "just a few sample rows so the agent understands the format."
- Letting the agent read files freely in a directory that contains the real data.
- Uploading the CSV "just this once" to debug a parsing error.
- Screenshotting a spreadsheet to ask about a weird value.

Each one feels harmless in the moment. Each one is the whole leak. The fix is not more willpower in the moment; it is a workflow where the real data is never within reach.

### The fake-data workflow _(slide: The fake-data workflow)_

_[~2 min]_

Here is the workflow I use, and it is the centerpiece of this section:

1. **Keep the structure, fake the content.** Build a stand-in dataset with the same columns, same types, same shape, same quirks (missing values, weird codes), but entirely fabricated rows. A small script or even the agent itself can generate it from the schema.
2. **Build the pipeline on fake data.** The agent plans, writes, and tests the whole pipeline: wrangling, visualization, modeling, on the stand-in. It iterates freely because nothing it touches is sensitive.
3. **Run the real data yourself, offline.** When the pipeline is done, you swap the file path and run the scripts on the real data, on your machine, with no agent in the loop.

The agent got everything it needed, which was the structure. It never saw a single real row. And notice how this depends on Section 1: this handoff only works because the deliverable was **scripts**. You cannot swap the input of an answer bubble.

### Same structure, fake content _(slide: Same structure, fake content)_

_[~1 min]_

This is what the split looks like side by side. Two files, identical columns, identical types. The real one stays on your disk and is read only by scripts you run. The fake one is the only file the agent ever opens. The pipeline transfers perfectly between them because pipelines run on structure, not on content.

### More ways to keep data out _(slide: More shields)_

_[~1.5 min]_

Fake data is one shield. Depending on how sensitive the data is and what your policies allow, you can layer more:

- **De-identify first.** Strip names, IDs, exact dates and locations before anything is shared. (Careful: de-identification is harder than it looks; rare combinations can still re-identify someone.)
- **Share schema, not rows.** Often the agent needs only column names, types, and a description. Text, no data.
- **Deny by configuration.** Use your agent's permission settings to block the data directory outright, so even a careless prompt cannot expose it. Guardrails beat willpower.
- **Keep the model local.** For the most restricted settings, run models on hardware you control, so nothing leaves the machine.

These stack. A schema-only prompt inside a sandboxed agent working on a fake dataset is defense in depth.

### The principle _(slide: dark pull-quote)_

_[~0.5 min]_

The whole section in two lines: **give the agent your structure, never your content. The pipeline transfers. The rows do not.**

---

## 3. You Are the Pilot

### Co-pilot, not autopilot _(slide: Co-pilot, not autopilot)_

_[~1.5 min]_

Last section, and it is the foundation under the other two. The metaphor that gets AI right is the **co-pilot**. A co-pilot is genuinely capable: handles the radio, watches the instruments, flies stretches of the route, and makes everything faster and safer. But a co-pilot does not choose the destination, and when something is at stake, it is not the co-pilot's landing.

Calling AI a co-pilot implies the other half: **you are the pilot.** You set the course, you make the judgment calls, you sign off. The moment that flips, when the agent decides and you just accept, you are not doing data science faster. You have stopped doing it at all.

### Your name on the results _(slide: Your name on the results)_

_[~1.5 min]_

Being the pilot means full responsibility across the whole pipeline: the original data, the wrangling, the visualization, the modeling and simulation, the conclusions. Every step must survive your questions. When a reviewer, a colleague, or your future self asks "why did you do it that way?", the answer has to come from you, not from a chat log. AI made the pipeline fast. It did not sign it. You did.

### The hand-craft test _(slide: The hand-craft test)_

_[~1.5 min]_

A litmus test for every delegated step: **could you do this step yourself, without AI?**

- If yes: delegate freely. You are delegating the typing, not the thinking. You can verify the output because you know what correct looks like.
- If no: stop. Do not ship what you cannot check. Learn the method first, then let the agent accelerate it.

AI changes the speed of your work. It does not change what you are responsible for understanding. If you could not have crafted it, you cannot verify it, and if you cannot verify it, it should not ship under your name.

---

## The bad example

### How it goes wrong _(slide: How it goes wrong)_

_[~2 min]_

Now that you have the three rules, watch one researcher break all of them in ninety seconds, without ever feeling like they did anything wrong. Friday, 4:55 pm, report due Monday:

They paste two hundred real rows from a restricted benefits database into the chat, "so the agent understands the data." They ask: "what is the effect of the program on income? Just give me the number." The agent answers, confident and tidy: +$1,240, p = 0.03. They say thanks and paste the number into the report.

Walk through it slowly and every step feels reasonable. Deadline pressure, a helpful agent, a plausible number. That is exactly why this fails quietly: nothing errored, nothing warned, and the work looks done.

### Three violations in one chat _(slide: Three violations, one chat)_

_[~1.5 min]_

Score it against the three sections:

1. **Real rows left the building.** Restricted microdata is now in a third-party context window. Rule 2, gone, in one paste.
2. **They asked for the number, not the pipeline.** No script exists. Nobody, including them, can say how the estimate was produced, or reproduce it.
3. **They shipped a result they cannot defend.** The number is in the report; the first hard question ends the story. The co-pilot flew, and nobody was piloting.

The fix costs minutes: generate a fake dataset with the same columns, have the agent write the pipeline against it, run it on the real data locally, read the scripts, then decide whether to believe the number. Same deadline. Same agent. A defensible result.

---

## Closing

### Three takeaways _(slide: Three takeaways)_

_[~1 min]_

1. **Scripts, not results.** Ask how the answer is made. Keep the scripts and the file structure; judge the reasonableness yourself.
2. **Keep real data out.** Structure goes to the agent, content stays home. Fake data, schema-only prompts, deny rules, local models.
3. **You are the pilot.** AI expedites the work; it does not own it. Everything ships under your name, so everything must survive your questions.

### Closing quote _(slide: dark pull-quote)_

_[~0.5 min]_

AI is a brilliant co-pilot: it makes the whole flight faster. But the destination, the judgment calls, and the landing belong to the pilot. **That is you.**

Thank the audience; hand back to the workshop wrap-up.

---

## Speaker notes

_(Working notes for the speaker, not slide content.)_

- **Tone:** pro-AI throughout. Parts 1 and 2 sold delegation; Part 3 is not a retraction, it is the operating manual. The message is "delegate the mechanics, own the decisions and the data."
- **Pacing:** opening ~3.5 min, Section 1 ~6.5 min, Section 2 ~8 min, Section 3 ~4.5 min, bad example ~3.5 min, closing ~1.5 min. Total ~27 min; trim the leak-paths or hand-craft slides if running long.
- **The fake-data workflow is the demo-able moment.** If live tooling allows, a 60-second demo (agent generates a fake CSV from a schema, writes a wrangling script, you run it on the "real" file) would land harder than the slides. Decide on the day.
- **Government example:** the narration frames Section 2 with "suppose I work for the government and the data is seriously sensitive." Keep that framing verbal; it makes the stakes concrete for a DC-area audience.
- **Section card icons** (wired in `resources/part-3-overview.qmd`):
  - Section 1: `file-code` (scripts as the deliverable)
  - Section 2: `shield-check` (data protection)
  - Section 3: `plane` (the pilot)
