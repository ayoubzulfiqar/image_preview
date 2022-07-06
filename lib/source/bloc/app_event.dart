import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class LoadNextImage implements AppEvent {
  const LoadNextImage() : super();
}
