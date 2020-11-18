import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:testapp/tabs/splash_nuevo.dart';
import 'package:your_splash/your_splash.dart';
import 'package:testapp/tabs/home_tabs.dart';
//import 'package:testapp/tabs/nuevo_home.dart';

Future<void> main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());

  //OneSignal

//Remove this method to stop OneSignal Debugging 
OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

OneSignal.shared.init(
  "8b7167c6-5468-4a67-a94b-a3a411591a8b",
  iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  }
);
OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);


OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
    // will be called whenever a notification is received
});

OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  // will be called whenever a notification is opened/button pressed.
});

OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
});

OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // will be called whenever the subscription changes 
    //(ie. user gets registered with OneSignal and gets a user ID)
});

OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    // will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
});

// For each of the above functions, you can also pass in a 
// reference to a function as well:

//OneSignal
}



Future<void> loadFuture() {
  return Future.delayed(Duration(seconds: 3), () => {print("LOADED!")});
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen.futured(
        future: loadFuture,
        route: PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeTabs(),
          transitionDuration: Duration(seconds: 2),
          transitionsBuilder: (_, animation, secAnim, child) {
            var tween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: Curves.easeInOutBack),
            );
            return FadeTransition(
                opacity: animation.drive(tween), child: child);
          },
        ),
        body: SplashNuevo(),
      ),
    );
  }
  
}