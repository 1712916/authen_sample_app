
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/cubits.dart';
import '../../../data/data.dart';
import '../../../resources/resources.dart';
import '../../../widgets/widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailCtr = TextEditingController();

  final TextEditingController userNameCtr = TextEditingController();

  final TextEditingController passwordCtr = TextEditingController();

  final FocusNode emailFNode = FocusNode();

  final FocusNode passwordFNode = FocusNode();

  final FocusNode userNameFNode = FocusNode();

  @override
  void dispose() {
    emailCtr.dispose();
    userNameCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final theme = Theme.of(context);
    final colors = context.read<ThemeCubit>().getColors;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: emailCtr,
            focusNode: emailFNode,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFNode);
            },
            label: LocaleKeys.email.tr(),
            validator: cubit.emailRegisterValidator,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: passwordCtr,
            focusNode: passwordFNode,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(userNameFNode);
            },
            label: LocaleKeys.password.tr(),
            validator: cubit.passwordRegisterValidator,
            isHideText: true,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: userNameCtr,
            focusNode: userNameFNode,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(userNameFNode);
            },
            onFieldSubmitted: (_) => onRegister(),
            label: LocaleKeys.userName.tr(),
            validator: cubit.userNameRegisterValidator,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                LocaleKeys.forgetPassword,
                style: theme.textTheme.caption?.copyWith(
                  color: colors.labelColor,
                ),
              ).tr(),
            ),
          ),
          const SizedBox(height: 36),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state.registerMessage != null && state.registerMessage!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '* ${state.registerMessage}',
                    style: theme.textTheme.subtitle1?.copyWith(
                      color: Colors.redAccent,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          InkWell(
            onTap: () => onRegister(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFF637C),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                LocaleKeys.register,
                style: theme.textTheme.bodyText2?.copyWith(color: Colors.white),
              ).tr(),
            ),
          ),
          const SizedBox(height: 29),
          Align(
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.navToLogin,
              style: theme.textTheme.bodyText2?.copyWith(color: Colors.white),
            ).tr(),
          ),
        ],
      ),
    );
  }

  onRegister() async {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginCubit>().resetRegisterMessage();
    if (formKey.currentState!.validate()) {
      await LoadingDialog.doSomething(
        context,
        call: () {
          return context.read<LoginCubit>().onRegister(email: emailCtr.text, password: passwordCtr.text, userName: userNameCtr.text);
        },
        onDone: (response) {
          if (response is NavigateEvent) {
            context.read<HomeCubit>().setProfile(response.arguments as ProfileModel);
            Navigator.of(context).pushNamedAndRemoveUntil(response.routeName, (route) => false, arguments: response.arguments);
          }
        },
      );
    }
  }
}
