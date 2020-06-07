import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'page_navigator.dart';
import 'Auth/logsignin_page.dart';
import 'Auth/auth.dart';
import 'wrapper.dart';
import 'Model/user.dart';
import 'Auth/login.dart';
import 'Auth/register.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final PageController pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    _handleCameraAndMic();
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Video Chat',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          backgroundColor: Color(0xffF1FAEE),
        ),
        home: Wrapper(
          homePage: PageNavigator(),
        ),
        routes: {
          LogsignIn.id: (context) => LogsignIn(),
          Login.id: (context) => Login(),
          Register.id: (context) => Register(),
        },
        debugShowCheckedModeBanner: false,

        //i18n stuff
        // Updated deprecated code
        localizationsDelegates: [
          FlutterI18nDelegate(
            translationLoader: FileTranslationLoader(
              fallbackFile: 'en',
              basePath: 'assets/i18n',
              useCountryCode: false,
            ),
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }

  _handleCameraAndMic() async {
    await [Permission.camera,Permission.microphone].request();

    // The following code is deprecated. Can't use in future versions.
    //    await PermissionHandler().requestPermissions(
    //        [PermissionGroup.camera, PermissionGroup.microphone]);
  }
}
