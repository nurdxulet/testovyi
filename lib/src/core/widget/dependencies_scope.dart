import 'package:flutter/material.dart';
import 'package:testovyi/src/core/widget/scope.dart';
import 'package:testovyi/src/core/model/dependencies_storage.dart';

class DependenciesScope extends Scope {
  static const DelegateAccess<_DependenciesScopeDelegate> _delegateOf =
      Scope.delegateOf<DependenciesScope, _DependenciesScopeDelegate>;

  final IDependenciesStorage Function(BuildContext context) create;

  const DependenciesScope({
    required this.create,
    required super.child,
    super.key,
  });

  static IDependenciesStorage of(
    BuildContext context,
  ) =>
      _delegateOf(context).storage;

  @override
  ScopeDelegate<DependenciesScope> createDelegate() => _DependenciesScopeDelegate();
}

class _DependenciesScopeDelegate extends ScopeDelegate<DependenciesScope> {
  late final IDependenciesStorage storage = widget.create(context);

  @override
  void dispose() {
    storage.close();
    super.dispose();
  }
}
