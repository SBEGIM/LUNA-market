import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:haji_market/src/feature/auth/data/models/common_dto.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDTO with _$UserDTO {
  const factory UserDTO({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(defaultValue: -1) required int id,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? phone,
    String? role,
    @JsonKey(name: 'class') CommonDTO? classNumber,
    String? avatar,
    @JsonKey(name: 'device_token') String? deviceToken,
    @JsonKey(name: 'device_type') String? deviceType,
    @JsonKey(name: 'has_notification') int? hasNotification,
    @JsonKey(name: 'has_package') int? hasPackage,
    @JsonKey(name: 'package_id') int? packageId,
    @JsonKey(name: 'active_package_id') int? activePackageId,
    String? lang,
    @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
    CommonDTO? city,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
}
