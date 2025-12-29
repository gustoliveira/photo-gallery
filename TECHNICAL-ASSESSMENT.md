# 10 Minute Technical Assessment

Create a simple Flutter application using your preferred AI assistant (ChatGPT, Claude, DeepSeek, GitHub Copilot, etc.) that fetches a collection of photos from a publicly available API endpoint and displays them in a grid view. Additionally, include at least one interactive element (e.g., a button to favorite an item or filter the list).

## Requirements

Using an AI assistant to generate code, open up your favorite editor, share your screen and narrate your thought process and AI prompting strategy. The development environment and how effectively you leverage its tools will be an important part of the assessment.

### The app should include:

- A main screen with a scrollable grid.
- Each grid item should show a thumbnail image and a title (or description).
- Basic error handling (e.g., show a message if the fetch fails).
- At least one interactive element (e.g., a ‘Favorite’ button that toggles state for an item).
- Simple state management for handling favorites (can be a basic setState, Provider, or Riverpod).

## Evaluation criteria

- AI integration: Quality of prompts and the ability to iterate on AI-generated code.
- Flutter skills: Understanding of core concepts (widget tree, rendering a list, async data fetching, state management).
- Code organization: Cleanliness and logical structure of the code, even if minimal.
- Problem solving: How you handle and recover from AI-generated errors or limitations.
- Time management: Ability to produce a functional prototype within 10 minutes.

## Additional notes

- You may use any AI tool you are comfortable with.
- Focus on functionality rather than design aesthetics.
- Feel free to clarify requirements before starting.

### Photo APIs suggestions

- https://picsum.photos/v2/list

#### RESPONSE EXAMPLE

```
[
    {"id":"0","author":"Alejandro Escamilla","width":5000,"height":3333,"url":"https://unsplash.com/photos/yC-Yzbqy7PY","download_url":"https://picsum.photos/id/0/5000/3333"},
    {"id":"1","author":"Alejandro Escamilla","width":5000,"height":3333,"url":"https://unsplash.com/photos/LNRyGwIJr5c","download_url":"https://picsum.photos/id/1/5000/3333"}
]
```
