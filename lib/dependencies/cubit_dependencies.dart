 import 'package:get_it/get_it.dart';

import '../cubits/cubits.dart';

class CubitDependencies {
  static Future<void> init(GetIt injector) async {
    injector.registerFactory<HomeCubit>(() => HomeCubit());
    injector.registerFactory<LoginCubit>(() => LoginCubit());
  }
}