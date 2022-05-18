import '../../data.dart';

abstract class IAuthen {
  Future<CustomResponse<ProfileModel>> login({required String email, required String password});
  Future<CustomResponse<ProfileModel>> register({required String email, required String password, required String userName});
}