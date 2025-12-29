# Development Report: Photo Gallery App

**Date:** December 29, 2025
**Platform:** Gemini CLI
**Project:** `photo_gallery_app`
**Framework Version:** Flutter 3.35.7

---

## 1. Summary

The objective was to develop a mobile application in Flutter that consumes a photo API (`picsum.photos`), displays the results in a grid, and allows items to be favorited. The development process went through structural creation phases, business logic implementation, refactoring for dependency injection, and an extensive iteration of automated testing to ensure quality and compliance with acceptance criteria.

---

## 2. Technical Specifications

* **Language:** Dart 3.9.2
* **State Management:** `setState` (Native)
* **Main Dependencies:**
* `http`: For API requests.
* `mockito`: For creating mocks in tests.

* **Endpoints:** `https://picsum.photos/v2/list`

---

## 3. Development Chronology and Prompts

### Phase 1: Initialization and Core Implementation

This phase focused on the base structure and main functionality, initiated by the following prompt:

> **Original Prompt:**
> "You must create a android project using Flutter Framework, read the @.tool-version to get the current flutter version used, and create the mobile app to fetch the values from an API and show in a grid
> Each photo, must be a card, and each card must have a favoritable action
> You must fetch from the API ENDPOINT: [https://picsum.photos/v2/list](https://picsum.photos/v2/list)
> The response is a list of photos:
> Example of photo response: {"id":"0","author":"Alejandro Escamilla","width":5000,"height":3333,"url":"[https://unsplash.com/photos/yC-Yzbqy7PY](https://unsplash.com/photos/yC-Yzbqy7PY)","download_url":"[https://picsum.photos/id/0/5000/3333](https://picsum.photos/id/0/5000/3333)"}
> Use the download_url to fetch the picutere, and the author as a description
> Use setState as a state management" 
> 
> 

**Actions Taken:**

* 
**Project Creation:** Executed command `flutter create photo_gallery_app`.

* 
**Modeling:** Created the `Photo` class with JSON serialization support and an `isFavorite` field .

* 
**Service:** Implemented `PhotoService` to fetch data and handle HTTP response codes (200 vs Error) .

* **Interface (UI):**
* Implemented `PhotoGalleryScreen` using `FutureBuilder` for loading states.

* Used `GridView.builder` for efficient display.

* Implemented favorite interaction logic via `setState` .

### Phase 2: Testing Cycle and Refactoring

In this stage, the focus shifted to quality assurance and automated testing, as requested:

> **Original Prompt:**
> "Remove the old test files, and create tests to make sure the application is following all the acceptces critereas" 
> 
> 

**Actions and Challenges:**

* 
**Dependency Injection:** `PhotoService` was refactored to accept an optional `http.Client`, allowing mocks during tests .


* 
**UI Bug Fix:** Identified and fixed an error where the `_photos` variable was not properly defined in the state class scope in `main.dart` .


* **Mockito Issues:**
* Typing errors such as `type 'Null' is not a subtype of type 'Future<Response>'`.


* State errors such as `Bad state: Cannot call 'when' within a stub response`.


* Pending timer errors (`Timer is still pending`) in widget tests.

### Phase 3: Final Solution and Stabilization

After difficulties with the mock library, a definitive approach was requested to fix the test suite:

> **Original Prompt:**
> "Remove the commented tests and rewrite the tests in order to work
> It should work the better way possible" 
> 
> 

**Actions Taken:**

* **New Testing Strategy:**
* 
**Unit Tests:** Replaced complex Mockito usage with the native `MockClient` class from the `http/testing` package, defining direct responses via callbacks.

* 
**Widget Tests:** Implemented a `FakePhotoService` that allows injecting behaviors (success, error, loading) without relying on complex HTTP mocks .

* 
**Result:** All tests passed successfully.

* 
**Code Quality:** The final project passed static analysis (`flutter analyze`) and formatting (`dart format`) without errors.

---

## 4. Challenges and Solutions

| Challenge | Root Cause | Applied Solution |
| --- | --- | --- |
| **`_photos` Variable Error** | Accidental removal of list initialization during refactoring. | Reintroduction of `List<Photo> _photos = [];` in the widget state.|
| **Mockito Failures** | Difficulty correctly stubbing async calls and complex types. | Abandoned Mockito for the `Client` in favor of a functional `MockClient`.|
| **Pending Timers** | Use of `Future.delayed` in tests without advancing test time (`pump`). | Use of `Completer` to manually control Future completion in tests.|

---

## 5. Conclusion

The **Photo Gallery** app was delivered meeting all functional and non-functional requirements. The final architecture supports testability through dependency injection, and the test suite covers:

1. Initial rendering and loading state.
2. API error handling and display.
3. Correct data display in the Grid.
4. Favorite button interactivity.
