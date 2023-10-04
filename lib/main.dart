import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nexus/firebase_options.dart';
import 'package:nexus/key.dart';
import 'package:nexus/responsive/mobile_screen_layout.dart';
import 'package:nexus/responsive/responsive_layout_screen.dart';
import 'package:nexus/responsive/web_screen_layout.dart';
import 'package:nexus/screens/login_screen.dart';
import 'package:nexus/utils/colors.dart';
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: apiKey,
  //       appId: "1:299810638258:web:c7a7eb681e1f63448f3cab",
  //       messagingSenderId: "299810638258",
  //       projectId: "instagram-clone-fk",
  //       storageBucket: "instagram-clone-fk.appspot.com",
  //     ),
  //   );
  //   runApp(const MyApp());
  // } else {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("tp");
  runApp(const MyApp());
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      // home: Text("fuck my ass")
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
