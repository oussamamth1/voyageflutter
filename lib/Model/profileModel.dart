import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String name;
  // String username;
  String profession;
  String DOB;
  String titleline;
  String about;
  String img;
  String email;
  ProfileModel(
      {this.DOB,
      this.about,
      this.name,
      this.profession,
      this.titleline,
      this.email,
      this.img});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
  // factory ProfileModel.fromJson(Map<String, dynamic> json) =>
  //     _$ProfileModelFromJson(json);
  // Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
