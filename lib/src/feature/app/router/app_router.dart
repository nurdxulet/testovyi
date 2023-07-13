import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testovyi/src/feature/app/presentation/launcher.dart';
import 'package:testovyi/src/feature/home/presentation/view/aggregates_page.dart';
import 'package:testovyi/src/feature/home/model/crypto_dto.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute<void>(
      page: Launcher,
      initial: true,
      name: 'LauncherRoute',
      children: [],
    ),
    AutoRoute<void>(page: AggregatesPage),
  ],
)
class AppRouter extends _$AppRouter {}
