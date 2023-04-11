import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/timestamp_converter.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

@freezed
class User with _$User {
  const factory User({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String fullName,
    @Default('') String email,
    @Default('') String? uid,
    @Default('') String? photoUrl,
    @JsonKey(name: 'createdAt', fromJson: TimestampConverter.fromJsonNullable)
        required DateTime? createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFirestore(Map<String, dynamic> data) {
    return User.fromJson(data);
  }
}
