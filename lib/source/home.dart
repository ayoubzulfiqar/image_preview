import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_preview/source/bloc/app_bloc.dart';
import 'package:image_preview/source/bloc/app_event.dart';
import 'package:image_preview/source/bloc/app_state.dart';
import 'package:image_preview/source/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void startUpdating(BuildContext context) {
    Stream.periodic(const Duration(seconds: 5), (_) => const LoadNextImage())
        .forEach((event) {
      context.read<AppBloc>().add(
            event,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdating(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: BlocProvider<AppBloc>(
          create: (context) => AppBloc(
            urls: images,
            waitBeforeLoading: const Duration(seconds: 3),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
              if (appState.error != null) {
                return const Center(
                  child: Text("Error Occurred"),
                );
              } else if (appState.data != null) {
                return Image.memory(
                  appState.data!,
                  fit: BoxFit.cover,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
