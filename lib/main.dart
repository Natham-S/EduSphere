import 'package:edusphere/screens/NavBarScreen.dart';
import 'package:edusphere/screens/onboarding/OnBoardingScreen.dart';
import 'package:edusphere/services/AuthProvider.dart';
import 'package:edusphere/ui/CustomTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/auth/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Check if user is logged in

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(hasSeenOnboarding: hasSeenOnboarding, isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool hasSeenOnboarding;
  final bool isLoggedIn;

  const MyApp({super.key, required this.hasSeenOnboarding, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduSphere',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: widget.hasSeenOnboarding
          ? (widget.isLoggedIn ? const NavBarScreen() : const LoginScreen()) // Show Dashboard if logged in
          : const OnboardingScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const NavBarScreen(),
      },
    );
  }
}
