import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/history_screen/data/data_sources/data_source.dart';
import '../../features/history_screen/presentation/manager/history_cubit.dart';
import '../../features/history_screen/presentation/pages/history.dart';
import '../../features/hom_screen/presentation/manager/home_cubit.dart';
import '../../features/hom_screen/presentation/pages/home_screen.dart';
import '../../features/language_to_sign_screen/data/data_sources/data_source.dart';
import '../../features/language_to_sign_screen/presentation/manager/language_to_sign_cubit.dart';
import '../../features/language_to_sign_screen/presentation/pages/language_to_sign.dart';
import '../../features/login_screen/data/data_sources/data_source.dart';
import '../../features/login_screen/presentation/manager/login_cubit.dart';
import '../../features/login_screen/presentation/pages/loginScreen.dart';
import '../../features/on_boarding/on_boarding_screen.dart';
import '../../features/on_boarding/splash_screen.dart';
import '../../features/register_screen/data/data_sources/data_source.dart';
import '../../features/register_screen/presentation/manager/register_cubit.dart';
import '../../features/register_screen/presentation/pages/register_screen.dart';
import '../../features/sign_to_language_screen/data/data_sources/data_source.dart';
import '../../features/sign_to_language_screen/presentation/manager/sign_to_language_cubit.dart';
import '../../features/sign_to_language_screen/presentation/pages/camera_page/camera_page.dart';
import '../../features/sign_to_language_screen/presentation/pages/sign_to_language.dart';

class Routes {
  static const String splashScreen = "/";
  static const String onBoardingScreen = "onBoardingScreen";
  static const String loginScreen = "loginScreen";
  static const String registerScreen = "registerScreen";
  static const String homeScreen = "homeScreen";
  static const String cameraScreen = "cameraScreen";
  static const String signToLanguageScreen = "signToLanguageScreen";
  static const String languageToSignScreen = "languageToSignScreen";
  static const String historyScreen = "historyScreen";
}

class AppRoutes {
  static Route? onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        });

      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (context) {
          return OnBoardingScreen();
        });

      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
              create: (BuildContext context) =>
                  LoginCubit(loginDataSource: RemoteLoginDataSource()),
              child: const LoginScreen());
        });

      case Routes.registerScreen:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
              create: (BuildContext context) =>
                  RegisterCubit(RemoteRegisterDataSource()),
              child: const RegisterScreen());
        });

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
              create: (BuildContext context) => HomeCubit(),
              child: HomeScreen());
        });
      case Routes.signToLanguageScreen:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
              create: (BuildContext context) => SignToLanguageCubit(
                  signToLanguageDataSource: RemoteSignToLanguageDataSource()),
              child: SignToLanguageScreen());
        });
      case Routes.languageToSignScreen:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => LanguageToSignCubit(
                languageToSignDataSource: RemoteLanguageToSignDataSource()),
            child: LanguageToSignScreen(),
          );
        });

      case Routes.cameraScreen:
        return MaterialPageRoute(builder: (context) {
          return CameraPage();
        });

      case Routes.historyScreen:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
              create: (BuildContext context) {
                return HistoryCubit(
                    remoteHistoryDataSource: RemoteHistoryDataSource())
                  ..getUserHistory();
              },
              child: const HistoryScreen());
        });

      default:
        return MaterialPageRoute(builder: (context) {
          return unDefindScreen();
        });
    }
  }

  static Widget unDefindScreen() {
    return const Scaffold(
      body: Center(child: Text("Undefind screen")),
    );
  }
}
