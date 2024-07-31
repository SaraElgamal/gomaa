import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gomaa/core/constant/const/const.dart';
import 'package:gomaa/features/HomePage/HomePageAdmin/home_screen_admin.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/repo.dart';
import 'package:gomaa/features/login/employee/login/login.dart';
import 'package:gomaa/features/login/logic/states.dart';

import 'core/data_base/cache_helper/cache_helper.dart';
import 'core/injection/injection.dart';
import 'core/themes/themes.dart';
import 'features/HomePage/HomePageEmployee/home_employee.dart';
import 'features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'features/Splash_Screen/Splash_screen.dart';
import 'features/login/logic/cubit.dart';
import 'generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // Print the FCM token
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  getInit();
  runApp( MyApp());
  await CacheHelper.init();

  accessToken =  CacheHelper.getData(key: 'token');
  accessTokenAdmin =  CacheHelper.getData(key: 'tokenAdmin');
  print(accessToken);

}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
 // FirebaseAnalytics _analytics = FirebaseAnalytics();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // App is in the foreground
     // _sendNotificationToAdmin();
      print('app opened');
    }
  }

  // Future<void> _sendNotificationToAdmin() async {
  //   // Implement sending notification logic to admin using Firebase Cloud Messaging (FCM)
  //   // Example: Send a message to a topic subscribed by admin devices
  //   // Example: Send a notification directly to admin's device token
  //
  //   // Example of sending a message to a topic subscribed by admins
  //   await FirebaseMessaging.instance.subscribeToTopic('admin_notifications');
  //
  //   // Example of sending a notification directly to admin's device token
  //   String adminDeviceToken = 'admin_device_token_here';
  //   await FirebaseMessaging.instance.send(
  //     {
  //       'notification': {
  //         'title': 'User Opened App',
  //         'body': 'A user has opened the app.',
  //       },
  //       'token': adminDeviceToken,
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(
        390,
        844
    ),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: ( context) => getIt<AppCubit>(),
            ),
            BlocProvider(
              create: ( context) => getIt<TasksCubit>(),
            ),


          ],
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context , state) {

          },
          builder: ( context , state) =>  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            locale:

            const Locale('ar'),

            //: const Locale('en'),
            localizationsDelegates: const [

              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,

            home: SplashScreen(),
          ),
        ),
      );
    },
    );
  }
}

