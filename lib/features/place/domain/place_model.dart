import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/timestamp_converter.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@freezed
class Place with _$Place {
  factory Place({
    required String title,
    String? email,
    String? mobileNo,
    required String phoneNo,
    required String address,
    required double latitude,
    required double longitude,
    required String category,
    required int postCode,
    required String city,
    required String state,
    String? country,
    required String website,
    String? keywords,
    required String description,
    required List<String> images,
    @JsonKey(name: 'openingTime', fromJson: TimestampConverter.fromJsonNullable)
        DateTime? openingTime,
    @JsonKey(name: 'closingTime', fromJson: TimestampConverter.fromJsonNullable)
        DateTime? closingTime,
    @JsonKey(name: 'createdAt', fromJson: TimestampConverter.fromJsonNullable)
        DateTime? createdAt,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  factory Place.fromFirestore(DocumentSnapshot doc) {
    return Place.fromJson(doc.data() as Map<String, dynamic>);
  }
}
