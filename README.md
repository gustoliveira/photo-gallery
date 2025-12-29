# CloudWalk Photo Gallery

A Flutter application that fetches photos from the Picsum API and displays them in a grid view.

## Features

- Scrollable grid of photos.
- Each item shows the author's name.
- Favorite button to toggle favorite state.
- Persistence of favorites using `shared_preferences`.
- State management using `provider`.
- Unit and Widget tests.

## Requirements

This project uses `asdf` for version management. Ensure you have the Flutter and Dart plugins installed.

### Setup

1.  **Install dependencies**:
    ```bash
    asdf install
    ```

2.  **Get Flutter packages**:
    ```bash
    flutter pub get
    ```

## Development and Build

### Running Tests

To run all tests:
```bash
flutter test
```

### Linting and Formatting

To check for linting issues and format the code:
```bash
flutter analyze
dart format lib test
```

### Running the App

To run the application:
```bash
flutter run
```

### Building the Application

#### Android
```bash
flutter build apk
```

#### iOS
```bash
flutter build ios
```