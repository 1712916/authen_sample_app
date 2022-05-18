import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/data.dart';
import '../../resources/resources.dart';
import '../cubits.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(loadStatus: LoadStatus.init));

  void initData(Object? arguments) async {}

  void setProfile(ProfileModel profileModel) {
    emit(state.copyWith(
      profileModel: profileModel,
    ));
  }

  Future setUp() async {
    final shareRef = await SharedPreferences.getInstance();
    final String? profileModel = shareRef.getString(SharedPreferencesKey.profileModel);
    if (profileModel != null) {
      emit(state.copyWith(profileModel: ProfileModel.fromJson(jsonDecode(profileModel))));
    }
  }

  Future logout() async {
    final shareRef = await SharedPreferences.getInstance();
    shareRef.remove(SharedPreferencesKey.profileModel);
  }
}
