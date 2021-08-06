class PostModel {
  String uid;
  String userId;
  String dateTime;
  String text;
  String postImage;

  PostModel({
    this.uid,
    this.userId,
    this.text,
    this.dateTime,
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
  String uid;
  String userName;
  String userImage;
  String dateTime;
  String text;
  String postImage;

  PostViewModel({
    this.uid,
    this.userName,
    this.userImage,
    this.text,
    this.dateTime,
    this.postImage,
  });

  PostViewModel.fromJson(String uid, Map<String, dynamic> json) {
    this.uid = uid;
    this.userName = json['userName'] ?? '';
    this.userImage = json['userImage'] ?? '';
    this.text = json['text'] ?? '';
    this.dateTime = json['dateTime'] ?? '';
    this.postImage = json['postImage'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['text'] = this.text;
    data['dateTime'] = this.dateTime;
    data['postImage'] = this.postImage;
    return data;
  }
}
