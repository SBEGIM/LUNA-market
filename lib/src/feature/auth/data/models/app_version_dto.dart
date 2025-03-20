import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version_dto.freezed.dart';
part 'app_version_dto.g.dart';

@freezed
class AppVersionDTO with _$AppVersionDTO {
  const factory AppVersionDTO({
    @JsonKey(name: 'force_update_version') String? forceUpdateVersion,
    @JsonKey(name: 'store_review_version') String? storeReviewVersion,
  }) = _AppVersionDTO;

  factory AppVersionDTO.fromJson(Map<String, dynamic> json) => _$AppVersionDTOFromJson(json);
}
