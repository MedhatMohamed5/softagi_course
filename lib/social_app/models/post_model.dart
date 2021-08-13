class PostModel {
  String? uid;
  late String userId;
  late String dateTime;
  late String text;
  String? postImage;

  PostModel({
    this.uid,
    required this.userId,
    required this.text,
    required this.dateTime,
    this.postImage,
  });

  PostModel.fromJson(String uid, Map<String, dynamic> json) {
    this.uid = uid;
    this.userId = json['userId'] ?? '';
    this.text = json['text'] ?? '';
    this.dateTime = json['dateTime'] ?? '';
    this.postImage = json['postImage'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['dateTime'] = this.dateTime;
    data['postImage'] = this.postImage;
    return data;
  }
}

class PostViewModel {
  late String uid;
  late String userName;
  late String userImage;
  late String dateTime;
  late String text;
  late String postImage;
  late int postLikes;

  PostViewModel({
    required this.uid,
    required this.userName,
    required this.userImage,
    required this.text,
    required this.dateTime,
    required this.postImage,
    required this.postLikes,
  });

  PostViewModel.fromJson(String uid, Map<String, dynamic> json) {
    this.uid = uid;
    this.userName = json['userName'] ?? '';
    this.userImage = json['userImage'] ?? '';
    this.text = json['text'] ?? '';
    this.dateTime = json['dateTime'] ?? '';
    this.postImage = json['postImage'] ?? '';
    this.postLikes = json['postLikes'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['text'] = this.text;
    data['dateTime'] = this.dateTime;
    data['postImage'] = this.postImage;
    data['postLikes'] = this.postLikes;
    return data;
  }
}
