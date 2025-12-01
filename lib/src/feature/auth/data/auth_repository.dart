import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/auth/data/DTO/register.dart';
import 'package:haji_market/src/feature/auth/data/auth_remote_ds.dart';
import 'package:haji_market/src/feature/auth/database/auth_dao.dart';
import 'package:haji_market/src/feature/auth/data/models/user_dto.dart';

abstract interface class IAuthRepository {
  bool get isAuthenticated;

  UserDTO? get user;

  Future<void> clearUser();

  // Forgot password API's
  Future<int> forgotPasswordSmsSend({required String phone});

  Future<String> forgotPasswordSmsCheck({required String phone, required String code});

  /// Auth
  Future<UserDTO> login({required String phone, required String password});

  Future<UserDTO> registerSmsCheck({required String phone, required String code});

  Future<UserDTO> register({required RegisterDTO registerDto});

  Future<UserDTO> lateAuth();

  Future<UserDTO> editProfile({
    required String firstName,
    required String lastName,
    required String surName,
    required String phone,
    String? avatarPath,
    required String gender,
    required String birthday,
    required String country,
    required String city,
    required String street,
    required String home,
    required String porch,
    required String floor,
    required String room,
    required String email,
  });

  Future<void> editPush({required int pushStatus});

  Future<void> updateCityCode({required String code});

  Future<void> deleteAccount();

  Future<void> sendRegisterCode({required String phone});

  Future<void> passwordResetByPhone({required String phone, required String password});
}

class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl({required IAuthRemoteDS remoteDS, required IAuthDao authDao})
    : _remoteDS = remoteDS,
      _authDao = authDao;
  final IAuthRemoteDS _remoteDS;
  final IAuthDao _authDao;
  final _box = GetStorage();

  void _saveToGetStorage(UserDTO user) {
    // TODO: Remove GetStorage after full migration to DAO
    if (user.accessToken != null) _box.write('token', user.accessToken);
    _box.write('user_id', user.id.toString());
    if (user.firstName != null) _box.write('first_name', user.firstName);
    if (user.lastName != null) _box.write('last_name', user.lastName);
    if (user.surName != null) _box.write('sur_name', user.surName);
    if (user.phone != null) _box.write('phone', user.phone);
    if (user.gender != null) _box.write('gender', user.gender);
    if (user.avatar != null) _box.write('avatar', user.avatar);
    if (user.birthday != null) _box.write('birthday', user.birthday);
    if (user.country != null) _box.write('country', user.country);
    
    if (user.city != null) {
        _box.write('city', user.city?.name ?? ''); 
    }

    if (user.street != null) _box.write('street', user.street);
    if (user.home != null) _box.write('home', user.home);
    if (user.porch != null) _box.write('porch', user.porch);
    if (user.floor != null) _box.write('floor', user.floor);
    if (user.room != null) _box.write('room', user.room);
    if (user.email != null) _box.write('email', user.email);
    if (user.active != null) _box.write('active', user.active.toString());
    
    if (user.hasNotification != null) _box.write('push', user.hasNotification.toString());
  }

  @override
  bool get isAuthenticated => _authDao.user.value != null;

  @override
  UserDTO? get user {
    try {
      final userStr = _authDao.user.value;
      if (userStr != null) {
        return UserDTO.fromJson(jsonDecode(userStr) as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await _authDao.user.remove();
      // TODO: Remove GetStorage after full migration to DAO
      await _box.erase();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> login({required String phone, required String password}) async {
    try {
      final deviceToken = _authDao.deviceToken.value ?? 'DEVICE_TOKEN_ERROR';
      final user = await _remoteDS.login(phone: phone, password: password, deviceToken: deviceToken);

      await _authDao.user.setValue(jsonEncode(user.toJson()));
      _saveToGetStorage(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> register({required RegisterDTO registerDto}) async {
    try {
      final deviceToken = _authDao.deviceToken.value ?? 'DEVICE_TOKEN_ERROR';
      final user = await _remoteDS.register(registerDto: registerDto, deviceToken: deviceToken);
      await _authDao.user.setValue(jsonEncode(user.toJson()));
      _saveToGetStorage(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> lateAuth() async {
    try {
      final user = await _remoteDS.lateAuth();
      await _authDao.user.setValue(jsonEncode(user.toJson()));
      _saveToGetStorage(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> editProfile({
    required String firstName,
    required String lastName,
    required String surName,
    required String phone,
    String? avatarPath,
    required String gender,
    required String birthday,
    required String country,
    required String city,
    required String street,
    required String home,
    required String porch,
    required String floor,
    required String room,
    required String email,
  }) async {
    try {
      final user = await _remoteDS.editProfile(
        firstName: firstName,
        lastName: lastName,
        surName: surName,
        phone: phone,
        avatarPath: avatarPath,
        gender: gender,
        birthday: birthday,
        country: country,
        city: city,
        street: street,
        home: home,
        porch: porch,
        floor: floor,
        room: room,
        email: email,
      );
      await _authDao.user.setValue(jsonEncode(user.toJson()));
      _saveToGetStorage(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editPush({required int pushStatus}) async {
    try {
      await _remoteDS.editPush(pushStatus: pushStatus);
      // TODO: Remove GetStorage after full migration to DAO
      _box.write('push', pushStatus.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCityCode({required String code}) async {
    try {
      await _remoteDS.updateCityCode(code: code);
      // TODO: Remove GetStorage after full migration to DAO
      _box.write('user_location_code', code.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _remoteDS.deleteAccount();
      await clearUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> forgotPasswordSmsSend({required String phone}) async {
    try {
      return await _remoteDS.forgotPasswordSmsSend(phone: phone);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> forgotPasswordSmsCheck({required String phone, required String code}) async {
    try {
      return await _remoteDS.forgotPasswordSmsCheck(phone: phone, code: code);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDTO> registerSmsCheck({required String phone, required String code}) async {
    try {
      final user = await _remoteDS.registerSmsCheck(phone: phone, code: code);

      await _authDao.user.setValue(jsonEncode(user.toJson()));
      _saveToGetStorage(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendRegisterCode({required String phone}) async {
    try {
      await _remoteDS.sendRegisterCode(phone: phone);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> passwordResetByPhone({required String phone, required String password}) async {
    try {
      await _remoteDS.passwordResetByPhone(phone: phone, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
