import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_payload.freezed.dart';
part 'user_payload.g.dart';

@freezed
class UserPayload with _$UserPayload {
  const factory UserPayload({
    @JsonKey(name: 'first_name', includeIfNull: false) String? firstName,
    @JsonKey(name: 'last_name', includeIfNull: false) String? lastName,
    String? role,
    @JsonKey(name: 'class', includeIfNull: false) int? classNumber,
    @JsonKey(name: 'city_id', includeIfNull: false) int? cityId,
    String? phone,
    String? password,
    @JsonKey(name: 'password_confirmation') String? passwordConfirmation,
  }) = _UserPayload;

  factory UserPayload.fromJson(Map<String, dynamic> json) => _$UserPayloadFromJson(json);
}
