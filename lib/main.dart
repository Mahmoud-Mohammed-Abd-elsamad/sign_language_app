import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sign_language_app/core/utils/flutter_tts.dart';

import 'config/routes/routes.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/cach_helper.dart';
import 'core/utils/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  await CacheHelper.init();
  FlutterTtsMe.configureTts(setSpeechRate: .2, setVolume: 1);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  String initialRoute = Routes.splashScreen;
  @override
  void initState() {
    if( CacheHelper.getToken() == null){
      initialRoute = Routes.splashScreen;
    }else{
      initialRoute = Routes.homeScreen;
    }

    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([

      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          theme: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColors.primaryColor,
              selectionHandleColor: AppColors.primaryColor,
              selectionColor: Colors.grey.withOpacity(.3),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          onGenerateRoute: (settings) => AppRoutes.onGenerate(settings),
        );
      },
    );


  }
}