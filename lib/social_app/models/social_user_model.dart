class SocialUserModel {
  String name;
  String uid;
  String email;
  String phone;
  bool isEmailVerified;

  SocialUserModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(String uid, Map<String, dynamic> json) {
    this.uid = uid;
    this.name = json['name'] ?? '';
    this.email = json['email'] ?? '';
    this.phone = json['phone'] ?? '';
    this.isEmailVerified = json['isEmailVerified'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['isEmailVerified'] = this.isEmailVerified;
    return data;
  }
}
