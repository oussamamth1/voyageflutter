class ProfileM {
  String name;
  // String username;
  String profession;
  String DOB;
  String titleline;
  String about;
  String image;
  ProfileM(
      {this.DOB,
      this.about,
      this.name,
      this.profession,
      this.titleline,
      // this.username,
      this.image});
  ProfileM.fromJson(Map<String, dynamic> map) {
    this.DOB = map['DOB'];
    this.about = map['about'];
    this.name = map['name'];
    this.profession = map['profession'];
    this.titleline = map['titleline'];
    // this.username,
    this.image = map['titleline'];
  }
}
