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

- **Entities:** Plain Dart objects representing the domain model.
- **Use Cases:** Encapsulate business logic and interact with repositories.
- **Repositories:** Abstract interfaces for data access, implemented by data sources.
- **Data:** Handle actual data fetching (API, database, etc.).
- **Presentation (UI):**  Flutter widgets and BLoCs for state management.

The BLoC pattern is used for state management in the UI layer. Each feature has its own BLoC,
handling events and emitting states. Dependency injection is managed using `get_it`.

## Building and Running

## Dependencies

- **`flutter_dotenv: ^5.2.1`**: Loads environment variables from a `.env`
  file. [Official documentation](https://pub.dev/packages/flutter_dotenv)
- **`freezed_annotation`**: Annotations for code generation of immutable
  classes. [Official documentation](https://pub.dev/packages/freezed_annotation)
- **`json_annotation`**: Annotations for JSON serialization/deserialization code
  generation. [Official documentation](https://pub.dev/packages/json_annotation)
- **`http: ^1.3.0`**: For making HTTP
  requests. [Official documentation](https://pub.dev/packages/http)
- **`build_runner: ^2.4.14`**: Runs code generation
  tools. [Official documentation](https://pub.dev/packages/build_runner)
- **`freezed: ^3.0.0-0.0.dev`**: Generates immutable
  classes. [Official documentation](https://pub.dev/packages/freezed)
- **`json_serializable: ^6.9.3`**: Generates JSON serialization/deserialization
  code. [Official documentation](https://pub.dev/packages/json_serializable)
- **`get_it: ^7.6.0`**: A service locator for dependency
  injection. [Official documentation](https://pub.dev/packages/get_it)
- **`flutter_bloc: ^9.0.0`**: For state management with
  BLoC. [Official documentation](https://pub.dev/packages/flutter_bloc)
- **`equatable: ^2.0.7`**: For simplifying equality checks in BLoC states and
  events. [Official documentation](https://pub.dev/packages/equatable)
- **`logger: ^2.5.0`**:  For logging in the
  application. [Official documentation](https://pub.dev/packages/logger)
- **`mockito: ^5.0.0`**: For creating mocks in unit
  tests. [Official documentation](https://pub.dev/packages/mockito)
- **`bloc_test: ^10.0.0`**: For testing
  BLoCs. [Official documentation](https://pub.dev/packages/bloc_test)

## Code Generation

## Trade-offs

## Testing

## API Source

This app uses the [TMDB API](https://www.themoviedb.org/) to fetch movie data.