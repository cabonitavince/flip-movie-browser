# Movie Browser App with Clean Architecture and BLoC

## Table of Contents

- [Introduction](#introduction)
- [Architecture](#architecture)
- [Building and Running](#building-and-running)
- [Dependencies](#dependencies)
- [Code Generation](#code-generation)
- [Trade-offs](#trade-offs)
- [Testing](#testing)
- [API Source](#api-source)

## Introduction

This application allows users to browse, search, view, and favorite movies. It showcases how to
structure a Flutter app for maintainability, testability, and scalability using Clean Architecture.

## Architecture

This project follows the Clean Architecture principles, separating concerns into distinct layers:

- **Core:** Contains shared code that can be used across different features.
- **Entities:** Plain Dart objects representing the domain model.
- **Use Cases:** Encapsulate business logic and interact with repositories.
- **Repositories:** Abstract interfaces for data access, implemented by data sources.
- **Data:** Handle actual data fetching (API, database, etc.).
- **Presentation (UI):** Flutter widgets and BLoCs for state management.
- **Data Flow:** The architecture emphasizes a unidirectional data flow, typically following the
  pattern: UI -> BLoC -> Use Cases -> Repository -> Data. When the UI interacts with the
  application, it triggers an event in the BLoC. The BLoC then calls the appropriate Use Case. The
  Use Case, in turn, interacts with the Repository to fetch or manipulate data. Finally, the Data
  layer (via its data sources) interacts with the actual data source (API, database, etc.) and
  returns the result back up the chain. This structured flow helps to maintain a clear separation of
  concerns and improves the overall organization of the application.

The `BLoC pattern` is used for state management in the UI layer. Each feature has its own BLoC,
handling events and emitting states. Dependency injection is managed using `get_it`.

## Building and Running

To build and run the Movie Browser App, follow these steps:

1. **Clone the repository:**
   ```sh
   git https://github.com/cabonitavince/flip-movie-browser.git
   cd movie_browser
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Create a `.env` file:**
   Create a `.env` file in the root directory of the project and paste the following content:
   ```sh
   API_BASE_URL=[your_api_base_url]
   BEARER_TOKEN=[your_bearer_token]
   MOVIE_IMAGE_BASE_URL=[your_movie_image_base_url]
   MOVIE_POPULAR_URL=[your_movie_popular_url]
   MOVIE_SEARCH_URL=[your_movie_search_url]
   ```
4. **Run the build runner:**
   ```sh
   dart run build_runner build --delete-conflicting-outputs
   ```
5. **Run the app:**
   ```sh
    flutter run
    ```

## Dependencies

- **`flutter_dotenv: ^5.2.1`**: Loads environment variables from a `.env`
  file. [Official documentation](https://pub.dev/packages/flutter_dotenv)
- **`json_annotation: ^4.9.0`**: Annotations for JSON serialization/deserialization code
  generation. [Official documentation](https://pub.dev/packages/json_annotation)
- **`http: ^1.3.0`**: For making HTTP
  requests. [Official documentation](https://pub.dev/packages/http)
- **`build_runner: ^2.4.14`**: Runs code generation
  tools. [Official documentation](https://pub.dev/packages/build_runner)
- **`json_serializable: ^6.9.3`**: Generates JSON serialization/deserialization
  code. [Official documentation](https://pub.dev/packages/json_serializable)
- **`get_it: ^8.0.3`**: A service locator for dependency
  injection. [Official documentation](https://pub.dev/packages/get_it)
- **`flutter_bloc: ^9.0.0`**: For state management with
  BLoC. [Official documentation](https://pub.dev/packages/flutter_bloc)
- **`equatable: ^2.0.7`**: For simplifying equality checks in BLoC states and
  events. [Official documentation](https://pub.dev/packages/equatable)
- **`logger: ^2.5.0`**: For logging in the
  application. [Official documentation](https://pub.dev/packages/logger)
- **`mockito: ^5.4.5`**: For creating mocks in unit
  tests. [Official documentation](https://pub.dev/packages/mockito)
- **`bloc_test: ^10.0.0`**: For testing
  BLoCs. [Official documentation](https://pub.dev/packages/bloc_test)
- **`cached_network_image: ^3.4.1`**: For displaying and caching images from the
  internet. [Official documentation](https://pub.dev/packages/cached_network_image)
- **`hive: ^2.2.3`**: Lightweight and fast key-value
  database. [Official documentation](https://pub.dev/packages/hive)
- **`hive_flutter: ^1.1.0`**: Extension for Hive to work with
  Flutter. [Official documentation](https://pub.dev/packages/hive_flutter)
- **`hive_generator: ^2.0.1`**: Code generator for Hive type
  adapters. [Official documentation](https://pub.dev/packages/hive_generator)

## Code Generation

This project uses `build_runner` for code generation. To generate code, run the following command:

```sh
dart run build_runner build --delete-conflicting-outputs
```

## Trade-offs

This project initially used `Freezed` for model generation. However, due to incompatibility issues
with the `bloc_test` dependency and the specific structure of the API response data, the decision
was made to switch to `json_serializable`. `json_serializable` proved to be a better fit for
handling the API's snake_case naming conventions and nullable fields, simplifying the data mapping
process. While Freezed offers powerful features like immutability and `copyWith`,
`json_serializable` effectively addresses the project's current needs and integrates well with the
existing architecture.

## Testing

This project includes unit tests and widget tests on each layer to ensure the app's functionality
and reliability. The following packages are used for testing:

- **`flutter_test`**: Provides a framework for writing tests in Flutter.
- **`mockito`**: Used for creating mock objects in unit tests.
- **`bloc_test`**: Provides utilities for testing BLoCs.

To run the tests, use the following commands:

```sh
flutter test
```

## API Source

This app uses the [TMDB API](https://www.themoviedb.org/) to fetch movie data.