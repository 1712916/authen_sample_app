import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../routers/route.dart';
import '../views/pages/pages.dart';

class PageDependencies {
  static Future<void> init(GetIt injector) async {
    injector.registerFactory<Widget>(() => HomePage(cubit: injector()), instanceName: RouteManager.home);
    injector.registerFactory<Widget>(() => LoginPage(cubit: injector()), instanceName: RouteManager.login);
  }
}