import 'package:haji_market/src/feature/home/data/repository/banners_remote_ds.dart';

import '../model/banners.dart';

abstract interface class IBannersRepository {
  Future<List<Banners>> getBanners();
}

class BannersRepositoryImpl implements IBannersRepository {
  const BannersRepositoryImpl({
    required IBannersRemoteDS remoteDS,
  }) : _remoteDS = remoteDS;

  final IBannersRemoteDS _remoteDS;

  @override
  Future<List<Banners>> getBanners() async {
    try {
      return await _remoteDS.getBanners();
    } catch (e) {
      rethrow;
    }
  }
}
