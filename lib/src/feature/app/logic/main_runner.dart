// ignore_for_file: avoid-ignoring-return-values, unused_import
import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef AsyncDependencies<D> = Future<D> Function();

typedef AppBuilder<D> = Widget Function(D dependencies);

mixin MainRunner {
  static Future<Widget> _initApp<D>(
    bool shouldSend,
    AsyncDependencies<D> asyncDependencies,
    AppBuilder<D> app,
  ) async {
    final dependencies = await asyncDependencies();

    return app(dependencies);
  }

  static Future<void> run<D>({
    required AsyncDependencies<D> asyncDependencies,
    required AppBuilder<D> appBuilder,
    bool shouldSend = !kDebugMode,
  }) async {
    ///
    WidgetsFlutterBinding.ensureInitialized();
    final app = await _initApp(shouldSend, asyncDependencies, appBuilder);

    runApp(app);
  }
}
