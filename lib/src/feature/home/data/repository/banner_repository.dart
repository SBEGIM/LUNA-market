import 'package:haji_market/src/feature/home/data/repository/banners_remote_ds.dart';

import '../model/banner_model.dart';

abstract interface class IBannersRepository {
  Future<List<BannerModel>> getBanners();
}

class BannersRepositoryImpl implements IBannersRepository {
  const BannersRepositoryImpl({required IBannersRemoteDS remoteDS}) : _remoteDS = remoteDS;

  final IBannersRemoteDS _remoteDS;

  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      return await _remoteDS.getBanners();
    } catch (e) {
      rethrow;
    }
  }
}
