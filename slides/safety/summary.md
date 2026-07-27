# Data Safety with AI: Quick Summary

- **Use AI agents wisely**: AI agents are inevitable in data science. There's no way that we can avoid AI agents, so we need to use them wisely.

- **Establish pipelines**: Instead of asking the AI agent to directly show the result after data analysis, we need to ask the agent to go through the scripts and establish a full, reusable workflow.

- **Data safety**: In case of sensitive data, the best practice is to let the AI agents know that we are dealing with sensitive data, and we generate a bunch of fake data, but using the same data structure, we can work with AI agents until the full workflow and the pipeline is established, and then later on, we can manually run the real data with the established pipeline.

- **Bad example**: Use one bad example that ties everything together.

- **Summarize**: In the end, we can emphasize that a human is the pilot and AI is the co-pilot, so the human researchers are still responsible for gatekeeping all the working results. As a data scientist, it is important to understand the structure of the data and the best practice of setting up the pipelines.