class UserModel {
  String name;
  String phone;
  String email;
  String uId;
  String profileImage;
  String password;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.password,
    this.uId
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    uId = json['uId'];
    profileImage = json['profileImage'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'uId': uId,
      'profileImage': profileImage,

    };
  }
}
