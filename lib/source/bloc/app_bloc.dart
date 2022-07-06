import 'dart:math' as math show Random;

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_preview/source/bloc/app_event.dart';
import 'package:image_preview/source/bloc/app_state.dart';

typedef AppBlocUrlPicker = String Function(Iterable<String> allUrls);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandom(Iterable<String> allUrls) => allUrls.getRandomElement();
  AppBloc({
    required Iterable<String> urls,
    AppBlocUrlPicker? urlPicker,
    Duration? waitBeforeLoading,
  }) : super(const AppState.initial()) {
    on<LoadNextImage>((event, emit) async {
      emit(
        const AppState(
          isLoading: true,
          data: null,
          error: null,
        ),
      );
      final url = (urlPicker ?? _pickRandom)(urls);
      try {
        if (waitBeforeLoading != null) {
          await Future.delayed(waitBeforeLoading);
        }
        final bundle = NetworkAssetBundle(Uri.parse(url));
        final data = (await bundle.load(url)).buffer.asUint8List();

        emit(
          AppState(
            isLoading: false,
            data: data,
            error: null,
          ),
        );
      } catch (e) {
        emit(
          AppState(
            isLoading: false,
            data: null,
            error: e,
          ),
        );
      }
    });
  }
}
