import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/cubits.dart';
import '../../../resources/resources.dart';
import '../../../routers/route.dart';
import '../base_page/base_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.cubit}) : super(key: key);

  final HomeCubit cubit;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends CustomState<HomePage, HomeCubit> {
  @override
  void getArguments(Object? arguments) {
    cubit.initData(arguments);
  }

  Widget _buildTitleText(String title, String? content) {
    return RichText(
      text: TextSpan(
        text: '$title: ',
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
          fontStyle: FontStyle.normal,
        ),
        children: [
          TextSpan(
            text: content,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Hello :3'),
            const SizedBox(height: 16),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.profileModel != null) {
                  final profileModel = state.profileModel;
                  return Column(
                    children: [
                      _buildTitleText(LocaleKeys.email.tr(), profileModel!.email),
                      const SizedBox(height: 10),
                      _buildTitleText(LocaleKeys.userName.tr(), profileModel.userName),
                      const SizedBox(height: 10),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  await context.read<HomeCubit>().logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.login, (route) => false);
                },
                child: Text(LocaleKeys.logout).tr()),
          ],
        ),
      ),
    );
  }

  @override
  HomeCubit get cubit => widget.cubit;
}
