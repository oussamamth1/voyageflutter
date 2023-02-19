// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    name: json['name'] as String,
    profession: json['profession'] as String,
    titleline: json['titleline'] as String,
    email: json['email'] as String,
    DOB: json['DOB'] as String,
    about: json['about'] as String,
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
       'email': instance.email,
      'profession': instance.profession,
      'DOB': instance.DOB,
      'titleline': instance.titleline,
      'about': instance.about,
    };
