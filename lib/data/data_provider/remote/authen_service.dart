import 'package:authen_sample_app/data/models/profile_model.dart';

import 'package:authen_sample_app/data/response/custom_response.dart';

import '../interface/interfaces.dart';

class AuthenService extends IAuthen {
  @override
  Future<CustomResponse<ProfileModel>> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    final response = MockUserCenter.login(email, password);
    if (response != null) {
      return CustomResponse(statusCode: 200, data: ProfileModel.fromJson(response));
    }
     return CustomResponse(statusCode: 401, message: 'Tài khoản hoặc mật khẩu không đúng');
  }

  @override
  Future<CustomResponse<ProfileModel>> register({required String email, required String password, required String userName}) async {
    await Future.delayed(const Duration(seconds: 2));
    final response = MockUserCenter.addUser(email, password, userName);
    if (response != null) {
      return CustomResponse(statusCode: 200, data: ProfileModel.fromJson(response));
    }
    return CustomResponse(statusCode: 401, message: 'Không thể đăng ký với email này');
  }
}

class MockUserCenter {
  static List<Map<String, dynamic>?> _users = [
    {
      'email': 'kieuphong2840@gmail.com',
      'password': '123123qweqwe',
      'userName': 'kieuphong',
    }
  ];

  static Map<String, dynamic>? login(String email, String password) {
    final user = _users.firstWhere((element) => element?['email'] == email, orElse: () => null);
    if (user != null && user['password'] == password) {
      return user;
    }
    return null;
  }

  static Map<String, dynamic>? addUser(String email, String password, String userName) {
    final user = _users.firstWhere((element) => element?['email'] == email, orElse: () => null);
    if ( user != null) {
      return null;
    } else {
      _users.add({
        'email': email,
        'password': password,
        'userName': userName,
      });
      return _users.last;
    }
  }
}
