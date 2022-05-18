import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/cubits.dart';
import 'dependencies/app_dependencies.dart';
import 'resources/theme/theme_data.dart';

import '../routers/route.dart';
HomeCubit _homeCubit = HomeCubit();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await _homeCubit.setUp();
  BlocOverrides.runZoned(
    () async {
      await AppDependencies.init();
      runApp(
        EasyLocalization(
          child: const MyApp(),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('vi', 'VN'),
          ],
          path: 'assets/locales',
        ),
      );
    },
    blocObserver: AppBlocObserver(),
  );
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('${bloc.runtimeType} $change');
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()..setUp()),
        BlocProvider(create: (_) => _homeCubit),
      ],
      child: const _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          themeMode: state,
          theme: ThemeResource.getTheme(themeMode: ThemeMode.light, theme: Theme.of(context)),
          darkTheme: ThemeResource.getTheme(themeMode: ThemeMode.dark, theme: Theme.of(context)),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: RouteManager.getInitRoute(context: context),
          onGenerateRoute: (settings) => RouteManager.getRoute(settings),
        );
      },
    );
  }
}

