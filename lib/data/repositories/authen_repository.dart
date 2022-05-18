import 'package:authen_sample_app/data/data_provider/interface/authen.dart';
import 'package:authen_sample_app/data/data_provider/remote/authen_service.dart';
import 'package:authen_sample_app/data/models/profile_model.dart';
import 'package:authen_sample_app/data/response/custom_response.dart';

class AuthenReposity implements IAuthen{
  final IAuthen authen = AuthenService();

  @override
  Future<CustomResponse<ProfileModel>> login({required String email, required String password}) {
    return authen.login(email: email, password: password);
  }

  @override
  Future<CustomResponse<ProfileModel>> register({required String email, required String password, required String userName}) {
    return authen.register(email: email, password: password, userName: userName);
  }
}