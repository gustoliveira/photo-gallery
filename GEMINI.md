AGENTS Guidelines

This file provides guidance to AI agents when working with code in this repository. Adherence to these guidelines is crucial for maintaining code quality, readability, and maintainability.

## Core Software Development Principles

This project strictly follows established software engineering best practices:

-   **DRY (Don’t Repeat Yourself):** Avoid duplication of code. Utilize functions, classes, and other abstractions to reuse logic.
-   **SRP (Single Responsibility Principle):** Each class, module, or function should have one, and only one, reason to change. Ensure components are focused and cohesive.
-   **KISS (Keep It Simple, Stupid):** Strive for simplicity in design and implementation. Avoid unnecessary complexity.

## Specific Coding Constraints

In addition to the core principles, the following constraints MUST be observed:

-   **Avoid Nested IF Statements:** Refactor complex conditional logic. Prefer guard clauses, polymorphism, state patterns, or other techniques to flatten conditional structures.
-   **Concise Methods:** Methods and functions MUST NOT exceed 20 lines of code (excluding blank lines and single-line curly braces). If a method grows larger, refactor it into smaller, more focused units.
-   **No Code Comments:** Code should be self-documenting. Choose clear and descriptive names for variables, functions, and classes. Complex logic should be broken down into smaller, understandable steps rather than explained with comments.

## Build & Test Commands

When working with this project, AI agents just execute tests from changed files:

-   Run a single test file: `flutter test test/unit_test.dart`
-   Run a specific test: `flutter test --name="test name pattern" test/file.dart`

AI Agents must always run the linting and fix the warnings and errors:

-   Check for linting issues: `flutter analyze`
-   Always run the formatter: `dart format lib and dart format test`

By following these guidelines, AI agents will contribute effectively to the project, ensuring a high-quality and maintainable codebase.

