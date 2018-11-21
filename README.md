# Flutter Router
[![pub package](https://img.shields.io/pub/v/flutter_router.svg)](https://pub.dartlang.org/packages/flutter_router)

Flutter routing library that adds flexible routing options like parameters and clear route definitions.

## Usage
To use this plugin, add `flutter_router` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Usage
``` dart
// Import package
import 'package:flutter_router/router.dart';
```

``` dart
runApp(MaterialApp(
  onGenerateRoute: Router({
    '/accounts/{id}': (context, match) => Account(id: match.parameters['id'),
    '/': (context, match) => Index(),
  }).get,
));
```
