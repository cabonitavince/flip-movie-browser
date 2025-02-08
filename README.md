# Movie Browser App with Clean Architecture and BLoC

## Table of Contents

- [Introduction](#introduction)
- [Architecture](#architecture)
- [Building and Running](#building-and-running)
- [Dependencies](#dependencies)
- [Code Generation](#code-generation)
- [Trade-offs](#trade-offs)
- [Testing](#testing)

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