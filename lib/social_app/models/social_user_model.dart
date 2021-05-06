class SocialUserModel {
  String name;
  String uid;
  String email;
  String phone;

  SocialUserModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
  });

  SocialUserModel.fromJson(String uid, Map<String, dynamic> json) {
    uid = uid;
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
