import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testovyi/src/core/model/dependencies_storage.dart';
import 'package:testovyi/src/core/model/repository_storage.dart';
import 'package:testovyi/src/core/widget/dependencies_scope.dart';
import 'package:testovyi/src/core/widget/repository_scope.dart';
import 'package:testovyi/src/feature/app/presentation/app_configuration.dart';

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final PackageInfo packageInfo;
  const MyApp({
    super.key,
    required this.sharedPreferences,
    required this.packageInfo,
  });

  @override
  Widget build(BuildContext context) => DependenciesScope(
        create: (context) => DependenciesStorage(
          sharedPreferences: sharedPreferences,
          packageInfo: packageInfo,
        ),
        child: RepositoryScope(
          create: (context) => RepositoryStorage(
            networkExecuter: DependenciesScope.of(context).networkExecuter,
          ),
          child: const AppConfiguration(),
        ),
      );
}
