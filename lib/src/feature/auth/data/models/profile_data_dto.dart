import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:haji_market/src/feature/auth/data/models/user_dto.dart';

part 'profile_data_dto.freezed.dart';
part 'profile_data_dto.g.dart';

@freezed
sealed class ProfileDataDTO with _$ProfileDataDTO {
  const factory ProfileDataDTO({
    required UserDTO user,
  }) = _ProfileDataDTO;

  factory ProfileDataDTO.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataDTOFromJson(json);
}

