import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class  ProfileModel{
  String name;
  // String username;
  String profession;
  String DOB;
  String titleline;
  String about;
  String image;
  ProfileModel(
      {this.DOB,
      this.about,
      this.name,
      this.profession,
      this.titleline,
      // this.username,
      this.image});

  factory ProfileModel.fromJson(Map<String, dynamic> json ) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
  // factory ProfileModel.fromJson(Map<String, dynamic> json) =>
  //     _$ProfileModelFromJson(json);
  // Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
