import 'package:flutter/material.dart';
import 'package:testovyi/src/core/widget/scope.dart';
import 'package:testovyi/src/core/model/repository_storage.dart';

class RepositoryScope extends Scope {
  static const DelegateAccess<_RepositoryScopeDelegate> _delegateOf =
      Scope.delegateOf<RepositoryScope, _RepositoryScopeDelegate>;

  final IRepositoryStorage Function(BuildContext context) create;

  const RepositoryScope({
    required this.create,
    required super.child,
    super.key,
  });

  static IRepositoryStorage of(BuildContext context) => _delegateOf(context).storage;

  @override
  ScopeDelegate<RepositoryScope> createDelegate() => _RepositoryScopeDelegate();
}

class _RepositoryScopeDelegate extends ScopeDelegate<RepositoryScope> {
  late final IRepositoryStorage storage = widget.create(context);
}
