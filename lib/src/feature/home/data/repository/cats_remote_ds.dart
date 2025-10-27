import 'package:haji_market/src/core/rest_client/rest_client.dart';
import 'package:haji_market/src/core/utils/talker_logger_util.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';

abstract interface class ICatsRemoteDS {
  Future<List<CatsModel>> getCats();
  Future<List<CatsModel>> getBrandCats(int brandId);
}

class CatsRemoteDSImpl implements ICatsRemoteDS {
  const CatsRemoteDSImpl({
    required this.restClient,
  });
  final IRestClient restClient;

  @override
  Future<List<CatsModel>> getCats() async {
    try {
      final Map<String, dynamic> response = await restClient.get('/list/cats');

      return (response['data'] as List)
          .map((e) => CatsModel.fromJson(e))
          .toList();
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#getCats- ', e, st);
      rethrow;
    }
  }

  Future<List<CatsModel>> getBrandCats(int brandId) async {
    try {
      final Map<String, dynamic> response =
          await restClient.get('/list/cats?brand_id=$brandId');

      return (response['data'] as List)
          .map((e) => CatsModel.fromJson(e))
          .toList();
    } catch (e, st) {
      TalkerLoggerUtil.talker.error('#getCats- ', e, st);
      rethrow;
    }
  }
}
