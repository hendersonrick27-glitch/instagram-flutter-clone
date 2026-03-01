import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_flutter/responsive/responsive_layout.dart';
import 'package:instagram_clone_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';
// import 'package:instagram_clone_flutter/utils/colors.dart'; // Uncomment if other files need original colours, then update that file with kBlack/kForestGreen

// Define your colour palette
const Color kBlack = Color(0xFF000000);
const Color kForestGreen = Color(0xFF1B4D3E); // Modern forest green
const Color kDarkGrey = Color(0xFF121212); // For cards/background variations
const Color kLightText = Color(0xFFE0E0E0); // For text on dark bg

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with your config
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBhDsu2ZE9tNVZqNC3CrOgfNIwakDmr0hU",
      authDomain: "koinos-backend-8b66f.firebaseapp.com",
      projectId: "koinos-backend-8b66f",
      storageBucket: "koinos-backend-8b66f.firebasestorage.app",
      messagingSenderId: "367729356553",
      appId: "1:367729356553:web:af071dba9043104040add8",
    ),
  );

  runApp(const KoinosApp());
}

class KoinosApp extends StatelessWidget {
  const KoinosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Koinos',
        theme: ThemeData.dark().copyWith(
          // Black + Forest Green theme
          scaffoldBackgroundColor: kBlack,
          primaryColor: kForestGreen,
          colorScheme: const ColorScheme.dark(
            primary: kForestGreen,
            secondary: kForestGreen,
            surface: kDarkGrey,
            background: kBlack,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: kBlack,
            elevation: 0,
            iconTheme: IconThemeData(color: kLightText),
            titleTextStyle: TextStyle(
              color: kLightText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: kLightText),
            bodyMedium: TextStyle(color: kLightText),
            titleLarge: TextStyle(color: kLightText, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: kForestGreen),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kForestGreen,
              foregroundColor: Colors.white,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: kForestGreen,
          ),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                // Logged in → show main app layout
                return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: kForestGreen));
            }

            // Not logged in → login screen
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
