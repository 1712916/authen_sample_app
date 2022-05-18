import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubits.dart';

class RouteManager {

  static String get home => '/';

  static String get login => '/login';

  static getRoute(RouteSettings settings) {
    late Widget widget;
    try {
     widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Builder(
            builder: (context) {
              return Text(
                '404 Page Not Found',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              );
            }
          ),
        ),
      );
    }
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }

  static String getInitRoute({BuildContext? context}) {
    if (context?.read<HomeCubit>().state.profileModel != null) {
      return home;
    }
    return login;
  }
}
