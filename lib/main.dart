import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_uploader/core/cache_helper.dart';
import 'package:video_uploader/core/themes/dark_theme.dart';
import 'package:video_uploader/core/themes/light_theme.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';
import 'package:video_uploader/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  bool isDark = false;
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  const MyApp(
    this.isDark,
  );
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..changTheme(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: FlutterSplashScreen.gif(
              defaultNextScreen: LoginPage(),
              backgroundColor: Colors.white,
              // backgroundColor: Color.fromRGBO(248, 188, 187, 1),
              duration: const Duration(milliseconds: 3515),
              gifPath: 'assets/higif.gif',
              gifWidth: 269,
              gifHeight: 474,
            ),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
