import 'package:haji_market/src/core/rest_client/rest_client.dart';
import 'package:haji_market/src/core/utils/talker_logger_util.dart';
import '../model/banners.dart';

abstract interface class IBannersRemoteDS {
  Future<List<Banners>> getBanners();
}

class BannersRemoteDSImpl implements IBannersRemoteDS {
  const BannersRemoteDSImpl({
    required this.restClient,
  });
  final IRestClient restClient;

  @override
  Future<List<Banners>> getBanners() async {
    try {
      final Map<String, dynamic> response =
          await restClient.get('/list/banners');

      return (response['data'] as List)
          .map((e) => Banners.fromJson(e))
          .toList();
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#getBanners- ', e, st);
      rethrow;
    }
  }
}
