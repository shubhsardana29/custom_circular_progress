# Custom Circular Progress Indicator

A Flutter package that provides a customizable circular progress indicator with a dashed unfilled portion and animation support.

## Features

- Circular progress indicator with customizable colors
- Dashed line for the unfilled portion
- Smooth animation when updating progress
- Customizable size and stroke width

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  custom_circular_progress: ^0.0.1
```

## Usage

```dart
import 'package:custom_circular_progress/custom_circular_progress.dart';

CustomCircularProgressIndicator(
  progress: 0.7,
  filledColor: Colors.blue,
  unfilledColor: Colors.grey,
  strokeWidth: 10,
  size: 100,
)
```

## Additional information

For more information on how to use this package, please refer to the example project or file an issue on the GitHub repository.
