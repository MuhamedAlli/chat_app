class UserModel {
  String? username;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? bio;
  String? cover;
  bool? isVerified;
  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.uid,
    required this.image,
    required this.bio,
    required this.cover,
    required this.isVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    email = json["email"];
    phone = json["phone"];
    uid = json["uid"];
    image = json["image"];
    bio = json["bio"];
    cover = json["cover"];
    isVerified = json["isVerified"];
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "email": email,
      "phone": phone,
      "uid": uid,
      "image": image,
      "bio": bio,
      "cover": cover,
      "isVerified": isVerified,
    };
  }
}
