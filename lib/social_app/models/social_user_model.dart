class SocialUserModel {
  String name;
  String uid;
  String email;
  String phone;
  String bio;
  String coverImage;
  String image;
  bool isEmailVerified;

  SocialUserModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.coverImage,
    this.bio,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(String uid, Map<String, dynamic> json) {
    this.uid = uid;
    this.name = json['name'] ?? '';
    this.email = json['email'] ?? '';
    this.phone = json['phone'] ?? '';
    this.image = json['image'] ?? '';
    this.bio = json['bio'] ?? '';
    this.coverImage = json['coverImage'] ?? '';
    this.isEmailVerified = json['isEmailVerified'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['isEmailVerified'] = this.isEmailVerified;
    data['image'] = this.image;
    data['bio'] = this.bio;
    data['coverImage'] = this.coverImage;
    return data;
  }
}
