import 'package:testovyi/src/core/network/layers/network_executer.dart';
import 'package:testovyi/src/feature/home/datasource/home_remote_ds.dart';
import 'package:testovyi/src/feature/home/repository/home_repository.dart';

abstract class IRepositoryStorage {
  // dao's
  // AuthDao get authDao;

  // Repositories
  IHomeRepository get homeRepository;

  // Data sources
  IHomeRemoteDS get homeRemoteDS;
}

class RepositoryStorage implements IRepositoryStorage {
  // ignore: unused_field
  final NetworkExecuter _networkExecuter;

  RepositoryStorage({
    required NetworkExecuter networkExecuter,
  }) : _networkExecuter = networkExecuter;

  // @override
  // AuthDao get authDao => AuthDao(sharedPreferences: _sharedPreferences);

  ///
  /// Repositories
  ///
  @override
  IHomeRepository get homeRepository => HomeRepositoryImpl(
        remoteDS: homeRemoteDS,
      );

  ///
  /// Remote datasources
  ///

  @override
  IHomeRemoteDS get homeRemoteDS => HomeRemoteDSImpl(client: _networkExecuter);
}
