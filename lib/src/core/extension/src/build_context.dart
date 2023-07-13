import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testovyi/src/core/model/repository_storage.dart';
import 'package:testovyi/src/core/widget/dependencies_scope.dart';
import 'package:testovyi/src/core/widget/repository_scope.dart';
import 'package:testovyi/src/core/model/dependencies_storage.dart';

extension BuildContextX on BuildContext {
  // IEnvironmentStorage get environment => EnvironmentScope.of(this);
  IDependenciesStorage get dependencies => DependenciesScope.of(this);
  Dio get dio => dependencies.dio;

  IRepositoryStorage get repository => RepositoryScope.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  // AppBloc get appBloc => BlocProvider.of<AppBloc>(this);
  // ProfileBloc get profileBloc => BlocProvider.of<ProfileBloc>(this);
}
