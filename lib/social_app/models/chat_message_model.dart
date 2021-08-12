class ChatMessageModel {
  String senderId;
  String recieverId;
  String dateTime;
  String message;
  String uid;

  ChatMessageModel({
    this.dateTime,
    this.message,
    this.recieverId,
    this.senderId,
    this.uid,
  });

  ChatMessageModel.fromJson(String uid, Map<String, dynamic> json) {
    this.uid = uid;
    this.dateTime = json['dateTime'] ?? '';
    this.message = json['message'] ?? '';
    this.recieverId = json['recieverId'] ?? '';
    this.senderId = json['senderId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['message'] = this.message;
    data['recieverId'] = this.recieverId;
    data['senderId'] = this.senderId;
    return data;
  }
}
