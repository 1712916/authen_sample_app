import 'package:flutter/cupertino.dart';

class NavigateEvent {
  final String routeName;
  final Object? arguments;

  NavigateEvent({required this.routeName, this.arguments});
}