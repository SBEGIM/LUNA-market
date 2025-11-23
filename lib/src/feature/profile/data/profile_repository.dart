import 'dart:convert';
import 'dart:typed_data';
import 'package:haji_market/src/feature/auth/data/models/common_lists_dto.dart';
import 'package:haji_market/src/feature/auth/data/models/profile_data_dto.dart';
import 'package:haji_market/src/feature/auth/data/models/request/user_payload.dart';
import 'package:haji_market/src/feature/auth/data/models/user_dto.dart';
import 'package:haji_market/src/feature/auth/database/auth_dao.dart';
import 'package:haji_market/src/feature/profile/data/profile_remote_ds.dart';

abstract interface class IProfileRepository {
  Future<ProfileDataDTO> getProfile();

  Future logout();

  Future deleteAccount();

  Future updateLanguage({required String languageCode});

  Future<UserDTO> updateAvatar({required Uint8List? imageByteUint8List});

  Future<CommonListsDTO> getProfileUpdateFormOptions();

  Future<List<UserDTO>> getChildren();

  Future<void> addChild({required int id});

  Future<void> deleteChild({required int id});

  Future<int> updatePhoneSmsSend({required String phone});

  Future<UserDTO> updatePhoneSmsCheck({required String phone, required String code});

  Future<UserDTO> changePassword({
    required String oldPassword,
    required String password,
    required String passwordConfirmation,
  });

  Future makeAchievementShown({required int achievementId});
}

class ProfileRepositoryImpl implements IProfileRepository {
  const ProfileRepositoryImpl({required IProfileRemoteDS remoteDS, required IAuthDao authDao})
    : _remoteDS = remoteDS,
      _authDao = authDao;
  final IProfileRemoteDS _remoteDS;
  final IAuthDao _authDao;

  @override
  Future<ProfileDataDTO> getProfile() async {
    try {
      final result = await _remoteDS.getProfile();

      await _authDao.user.setValue(
        jsonEncode(
          result.user
              .copyWith(
                accessToken: UserDTO.fromJson(
                  jsonDecode(_authDao.user.value!) as Map<String, dynamic>,
                ).accessToken,
              )
              .toJson(),
        ),
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addChild({required int id}) async {
    try {
      return await _remoteDS.addChild(id: id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteChild({required int id}) async {
    try {
      return await _remoteDS.deleteChild(id: id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteAccount() async {
    try {
      await _remoteDS.deleteAccount();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future logout() async {
    try {
      await _remoteDS.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateLanguage({required String languageCode}) async {
    try {
      await _remoteDS.updateLanguage(languageCode: languageCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> updateAvatar({required Uint8List? imageByteUint8List}) async {
    try {
      final result = await _remoteDS.updateAvatar(imageByteUint8List: imageByteUint8List);

      await _authDao.user.setValue(
        jsonEncode(
          result
              .copyWith(
                accessToken: UserDTO.fromJson(
                  jsonDecode(_authDao.user.value!) as Map<String, dynamic>,
                ).accessToken,
              )
              .toJson(),
        ),
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommonListsDTO> getProfileUpdateFormOptions() async {
    try {
      return await _remoteDS.getProfileUpdateFormOptions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserDTO>> getChildren() async {
    try {
      return await _remoteDS.getChildren();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> updateProfile({required UserPayload payload}) async {
    try {
      final result = await _remoteDS.updateProfile(payload: payload);

      await _authDao.user.setValue(
        jsonEncode(
          result
              .copyWith(
                accessToken: UserDTO.fromJson(
                  jsonDecode(_authDao.user.value!) as Map<String, dynamic>,
                ).accessToken,
              )
              .toJson(),
        ),
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> updatePhoneSmsSend({required String phone}) async {
    try {
      return await _remoteDS.updatePhoneSmsSend(phone: phone);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> updatePhoneSmsCheck({required String phone, required String code}) async {
    try {
      final result = await _remoteDS.updatePhoneSmsCheck(phone: phone, code: code);

      await _authDao.user.setValue(
        jsonEncode(
          result
              .copyWith(
                accessToken: UserDTO.fromJson(
                  jsonDecode(_authDao.user.value!) as Map<String, dynamic>,
                ).accessToken,
              )
              .toJson(),
        ),
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> changePassword({
    required String oldPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final result = await _remoteDS.changePassword(
        oldPassword: oldPassword,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      await _authDao.user.setValue(
        jsonEncode(
          result
              .copyWith(
                accessToken: UserDTO.fromJson(
                  jsonDecode(_authDao.user.value!) as Map<String, dynamic>,
                ).accessToken,
              )
              .toJson(),
        ),
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future makeAchievementShown({required int achievementId}) async {
    try {
      await _remoteDS.makeAchievementShown(achievementId: achievementId);
    } catch (e) {
      rethrow;
    }
  }
}
