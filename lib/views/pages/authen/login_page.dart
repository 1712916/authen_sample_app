import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/cubits.dart';
import '../../../resources/resources.dart';
import '../../../widgets/widgets.dart';
import '../../views.dart';
import '../base_page/base_page.dart';
import 'login_view.dart';
import 'register_view.dart';

class LoginPage extends StatefulWidget {
  final LoginCubit cubit;

  const LoginPage({Key? key, required this.cubit}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends CustomState<LoginPage, LoginCubit> {
  int index = 0;

  @override
  Widget buildContent(BuildContext context) {
    final colors = context.read<ThemeCubit>().getColors;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return Container(
      // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: colors.backgroundColor,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RotationTransition(
            turns: const AlwaysStoppedAnimation(0 / 360),
            child: CustomPaint(
              painter: LinesPainter(),
              child: Container(),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: CustomSwitch(
                      children: [
                        LocaleKeys.login.tr(),
                        LocaleKeys.register.tr(),
                      ],
                      onChange: (value) {
                        index = value;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  IndexedStack(
                    sizing: StackFit.loose,
                    index: index,
                    children: const [
                      LoginView(),
                      RegisterView(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  LoginCubit get cubit => widget.cubit;
}