// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Place _$$_PlaceFromJson(Map<String, dynamic> json) => _$_Place(
      title: json['title'] as String,
      email: json['email'] as String?,
      mobileNo: json['mobileNo'] as String?,
      phoneNo: json['phoneNo'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      category: json['category'] as String,
      postCode: json['postCode'] as int,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String?,
      website: json['website'] as String,
      keywords: json['keywords'] as String?,
      description: json['description'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      openingTime: TimestampConverter.fromJsonNullable(
          json['openingTime'] as Timestamp?),
      closingTime: TimestampConverter.fromJsonNullable(
          json['closingTime'] as Timestamp?),
      createdAt:
          TimestampConverter.fromJsonNullable(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$_PlaceToJson(_$_Place instance) => <String, dynamic>{
      'title': instance.title,
      'email': instance.email,
      'mobileNo': instance.mobileNo,
      'phoneNo': instance.phoneNo,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'category': instance.category,
      'postCode': instance.postCode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'website': instance.website,
      'keywords': instance.keywords,
      'description': instance.description,
      'images': instance.images,
      'openingTime': instance.openingTime?.toIso8601String(),
      'closingTime': instance.closingTime?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
