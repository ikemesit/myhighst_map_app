// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return _Place.fromJson(json);
}

/// @nodoc
mixin _$Place {
  String get title => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get mobileNo => throw _privateConstructorUsedError;
  String get phoneNo => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  int get postCode => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String get website => throw _privateConstructorUsedError;
  String? get keywords => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'openingTime', fromJson: TimestampConverter.fromJsonNullable)
  DateTime? get openingTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'closingTime', fromJson: TimestampConverter.fromJsonNullable)
  DateTime? get closingTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt', fromJson: TimestampConverter.fromJsonNullable)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaceCopyWith<Place> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceCopyWith<$Res> {
  factory $PlaceCopyWith(Place value, $Res Function(Place) then) =
      _$PlaceCopyWithImpl<$Res, Place>;
  @useResult
  $Res call(
      {String title,
      String? email,
      String? mobileNo,
      String phoneNo,
      String address,
      double latitude,
      double longitude,
      String category,
      int postCode,
      String city,
      String state,
      String? country,
      String website,
      String? keywords,
      String description,
      List<String> images,
      @JsonKey(name: 'openingTime', fromJson: TimestampConverter.fromJsonNullable)
          DateTime? openingTime,
      @JsonKey(name: 'closingTime', fromJson: TimestampConverter.fromJsonNullable)
          DateTime? closingTime,
      @JsonKey(name: 'createdAt', fromJson: TimestampConverter.fromJsonNullable)
          DateTime? createdAt});
}

/// @nodoc
class _$PlaceCopyWithImpl<$Res, $Val extends Place>
    implements $PlaceCopyWith<$Res> {
  _$PlaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? email = freezed,
    Object? mobileNo = freezed,
    Object? phoneNo = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? category = null,
    Object? postCode = null,
    Object? city = null,
    Object? state = null,
    Object? country = freezed,
    Object? website = null,
    Object? keywords = freezed,
    Object? description = null,
    Object? images = null,
    Object? openingTime = freezed,
    Object? closingTime = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileNo: freezed == mobileNo
          ? _value.mobileNo
          : mobileNo // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      postCode: null == postCode
          ? _value.postCode
          : postCode // ignore: cast_nullable_to_non_nullable
              as int,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: freezed == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      openingTime: freezed == openingTime
          ? _value.openingTime
          : openingTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closingTime: freezed == closingTime
          ? _value.closingTime
          : closingTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlaceCopyWith<$Res> implements $PlaceCopyWith<$Res> {
  factory _$$_PlaceCopyWith(_$_Place value, $Res Function(_$_Place) then) =
      __$$_PlaceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String? email,
      String? mobileNo,
      String phoneNo,
      String address,
      double latitude,
      double longitude,
      String category,
      int postCode,
      String city,
      String state,
      String? country,
      String website,
      String? keywords,
      String description,
      List<String> images,
      @JsonKey(name: 'openingTime', fromJson: TimestampConverter.fromJsonNullable)
          DateTime? openingTime,
      @JsonKey(name: 'closingTime', fromJson: TimestampConverter.fromJsonNullable)
          DateTime? closingTime,
      @JsonKey(name: 'createdAt', fromJson: TimestampConverter.fromJsonNullable)
          DateTime? createdAt});
}

/// @nodoc
class __$$_PlaceCopyWithImpl<$Res> extends _$PlaceCopyWithImpl<$Res, _$_Place>
    implements _$$_PlaceCopyWith<$Res> {
  __$$_PlaceCopyWithImpl(_$_Place _value, $Res Function(_$_Place) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? email = freezed,
    Object? mobileNo = freezed,
    Object? phoneNo = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? category = null,
    Object? postCode = null,
    Object? city = null,
    Object? state = null,
    Object? country = freezed,
    Object? website = null,
    Object? keywords = freezed,
    Object? description = null,
    Object? images = null,
    Object? openingTime = freezed,
    Object? closingTime = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_Place(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileNo: freezed == mobileNo
          ? _value.mobileNo
          : mobileNo // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      postCode: null == postCode
          ? _value.postCode
          : postCode // ignore: cast_nullable_to_non_nullable
              as int,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: freezed == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      openingTime: freezed == openingTime
          ? _value.openingTime
          : openingTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closingTime: freezed == closingTime
          ? _value.closingTime
          : closingTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Place implements _Place {
  _$_Place(
      {required this.title,
      this.email,
      this.mobileNo,
      required this.phoneNo,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.category,
      required this.postCode,
      required this.city,
      required this.state,
      this.country,
      required this.website,
      this.keywords,
      required this.description,
      required final List<String> images,
      @JsonKey(name: 'openingTime', fromJson: TimestampConverter.fromJsonNullable)
          this.openingTime,
      @JsonKey(name: 'closingTime', fromJson: TimestampConverter.fromJsonNullable)
          this.closingTime,
      @JsonKey(name: 'createdAt', fromJson: TimestampConverter.fromJsonNullable)
          this.createdAt})
      : _images = images;

  factory _$_Place.fromJson(Map<String, dynamic> json) =>
      _$$_PlaceFromJson(json);

  @override
  final String title;
  @override
  final String? email;
  @override
  final String? mobileNo;
  @override
  final String phoneNo;
  @override
  final String address;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String category;
  @override
  final int postCode;
  @override
  final String city;
  @override
  final String state;
  @override
  final String? country;
  @override
  final String website;
  @override
  final String? keywords;
  @override
  final String description;
  final List<String> _images;
  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey(name: 'openingTime', fromJson: TimestampConverter.fromJsonNullable)
  final DateTime? openingTime;
  @override
  @JsonKey(name: 'closingTime', fromJson: TimestampConverter.fromJsonNullable)
  final DateTime? closingTime;
  @override
  @JsonKey(name: 'createdAt', fromJson: TimestampConverter.fromJsonNullable)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Place(title: $title, email: $email, mobileNo: $mobileNo, phoneNo: $phoneNo, address: $address, latitude: $latitude, longitude: $longitude, category: $category, postCode: $postCode, city: $city, state: $state, country: $country, website: $website, keywords: $keywords, description: $description, images: $images, openingTime: $openingTime, closingTime: $closingTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Place &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.mobileNo, mobileNo) ||
                other.mobileNo == mobileNo) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.postCode, postCode) ||
                other.postCode == postCode) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.keywords, keywords) ||
                other.keywords == keywords) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.openingTime, openingTime) ||
                other.openingTime == openingTime) &&
            (identical(other.closingTime, closingTime) ||
                other.closingTime == closingTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        title,
        email,
        mobileNo,
        phoneNo,
        address,
        latitude,
        longitude,
        category,
        postCode,
        city,
        state,
        country,
        website,
        keywords,
        description,
        const DeepCollectionEquality().hash(_images),
        openingTime,
        closingTime,
        createdAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlaceCopyWith<_$_Place> get copyWith =>
      __$$_PlaceCopyWithImpl<_$_Place>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlaceToJson(
      this,
    );
  }
}

abstract class _Place implements Place {
  factory _Place(
      {required final String title,
      final String? email,
      final String? mobileNo,
      required final String phoneNo,
      required final String address,
      required final double latitude,
      required final double longitude,
      required final String category,
      required final int postCode,
      required final String city,
      required final String state,
      final String? country,
      required final String website,
      final String? keywords,
      required final String description,
      required final List<String> images,
      @JsonKey(name: 'openingTime', fromJson: TimestampConverter.fromJsonNullable)
          final DateTime? openingTime,
      @JsonKey(name: 'closingTime', fromJson: TimestampConverter.fromJsonNullable)
          final DateTime? closingTime,
      @JsonKey(name: 'createdAt', fromJson: TimestampConverter.fromJsonNullable)
          final DateTime? createdAt}) = _$_Place;

  factory _Place.fromJson(Map<String, dynamic> json) = _$_Place.fromJson;

  @override
  String get title;
  @override
  String? get email;
  @override
  String? get mobileNo;
  @override
  String get phoneNo;
  @override
  String get address;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get category;
  @override
  int get postCode;
  @override
  String get city;
  @override
  String get state;
  @override
  String? get country;
  @override
  String get website;
  @override
  String? get keywords;
  @override
  String get description;
  @override
  List<String> get images;
  @override
  @JsonKey(name: 'openingTime', fromJson: TimestampConverter.fromJsonNullable)
  DateTime? get openingTime;
  @override
  @JsonKey(name: 'closingTime', fromJson: TimestampConverter.fromJsonNullable)
  DateTime? get closingTime;
  @override
  @JsonKey(name: 'createdAt', fromJson: TimestampConverter.fromJsonNullable)
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_PlaceCopyWith<_$_Place> get copyWith =>
      throw _privateConstructorUsedError;
}
