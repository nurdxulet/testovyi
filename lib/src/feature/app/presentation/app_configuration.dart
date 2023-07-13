import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:testovyi/src/feature/app/presentation/app_router_builder.dart';
import 'package:testovyi/src/feature/app/router/app_router.dart';

class AppConfiguration extends StatelessWidget {
  const AppConfiguration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppRouterBuilder(
      createRouter: (context) => AppRouter(),
      builder: (context, parser, delegate) => MaterialApp.router(
        routeInformationParser: parser,
        routerDelegate: delegate,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
