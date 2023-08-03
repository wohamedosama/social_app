import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/bloc_observer.dart';
import 'package:social_app1/cubits/social_cubit/social_cubit.dart';
import 'package:social_app1/cubits/social_login_cubit/social_login_cubit.dart';
import 'package:social_app1/cubits/social_register_cubit/social_register_cubit.dart';
import 'package:social_app1/firebase_options.dart';
import 'package:social_app1/layout/social_layout/social_layout.dart';
import 'package:social_app1/modules/social_login/socail_login_screen.dart';
import 'package:social_app1/modules/social_register/social_register_screen.dart';
import 'package:social_app1/shared/components/flutter_toast.dart';
import 'package:social_app1/shared/network/local/shared_preferances.dart';
import 'package:social_app1/shared/styles/theme/dark_theme.dart';
import 'package:social_app1/shared/styles/theme/light_theme.dart';

import 'constants.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('on background message');
  print(message.data.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var token = await FirebaseMessaging.instance.getToken();
  print(token.toString());

  FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((event) {
    print('on Message');
    print(event.data.toString());
    showToast(text: 'on Message', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on Message Opened App');

    print(event.data.toString());
    showToast(text: 'on Message Opened App', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Widget? widget;
  Bloc.observer = MyBlocObserver();
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(SocialApp(
    startWidget: widget,
  ));
}

class SocialApp extends StatelessWidget {
  const SocialApp({
    super.key,
    this.startWidget,
  });

  final Widget? startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SocialLoginCubit()),
          BlocProvider(create: (context) => SocialRegisterCubit()),
          BlocProvider(
            create: (context) => SocialCubit()
              ..getUserDate()
              ..getPosts(),
          ),
        ],
        child: BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: SocialCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme,
              routes: {
                SocialLoginScreen.id: (context) => SocialLoginScreen(),
                SocialRegisterScreen.id: (context) => SocialRegisterScreen(),
              },
              home: startWidget!,
            );
          },
        ));
  }
}
