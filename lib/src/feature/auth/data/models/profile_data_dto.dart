import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:haji_market/src/feature/auth/data/models/user_dto.dart';

part 'profile_data_dto.freezed.dart';
part 'profile_data_dto.g.dart';

@freezed
class ProfileDataDTO with _$ProfileDataDTO {
  const factory ProfileDataDTO({
    required UserDTO user,
    required AchievementsDTO achievements,
  }) = _ProfileDataDTO;

  factory ProfileDataDTO.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataDTOFromJson(json);
}

@freezed
class AchievementsDTO with _$AchievementsDTO {
  const factory AchievementsDTO({
    required List<AchievementDTO> notSeen,
    required List<AchievementDTO> items,
  }) = _AchievementsDTO;

  factory AchievementsDTO.fromJson(Map<String, dynamic> json) =>
      _$AchievementsDTOFromJson(json);
}

@freezed
class AchievementDTO with _$AchievementDTO {
  const factory AchievementDTO({
    required int id,
    String? type,
    String? name,
    String? description,
    String? image,
    @JsonKey(name: 'background_color') String? backgroundColor,
    @JsonKey(name: 'background_color2') String? backgroundColor2,
    @JsonKey(name: 'is_achieved', defaultValue: 0) int? isAchieved,
    @JsonKey(name: 'is_shown') int? isShown,
  }) = _AchievementDTO;

  factory AchievementDTO.fromJson(Map<String, dynamic> json) =>
      _$AchievementDTOFromJson(json);
}
