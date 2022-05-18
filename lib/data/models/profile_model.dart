class ProfileModel {
  final String? email;
  final String? userName;

  ProfileModel({this.email, this.userName});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['email'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userName': userName,
    };
  }
}