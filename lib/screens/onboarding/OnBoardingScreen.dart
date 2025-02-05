import 'package:edusphere/widgets/OnboardingPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ui/CustomColorScheme.dart';
import '../auth/LoginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Check if user has seen the onboarding screen before
  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    if (hasSeenOnboarding) {
      // If the user has already seen onboarding, navigate directly to LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _nextPage() async {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Mark onboarding as completed
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenOnboarding', true);

      // Navigate to the LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        children: const [
          OnboardingPage(
            image: 'assets/skill.png',
            title: 'Welcome to EduSphere',
            description: 'Your gateway to seamless learning experiences.',
          ),
          OnboardingPage(
            image: 'assets/skill.png',
            title: 'About EduSphere',
            description: 'A platform designed to manage digital rights and courses securely.',
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 60,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => _nextPage(),
              child: Text(
                _currentPage == 1 ? 'Get Started' : 'Next',
                style: TextStyle(color: customColorScheme.primary, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
