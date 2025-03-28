import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/home/data/repository/cats_remote_ds.dart';

abstract interface class ICatsRepository {
  Future<List<CatsModel>> getCats();
}

class CatsRepositoryImpl implements ICatsRepository {
  const CatsRepositoryImpl({
    required ICatsRemoteDS remoteDS,
  }) : _remoteDS = remoteDS;

  final ICatsRemoteDS _remoteDS;

  @override
  Future<List<CatsModel>> getCats() async {
    try {
      return await _remoteDS.getCats();
    } catch (e) {
      rethrow;
    }
  }
}
