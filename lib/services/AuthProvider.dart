import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/NavBarScreen.dart';
import '../screens/auth/LoginScreen.dart';

class AuthProvider with ChangeNotifier {
  // Constants
  static const String _loginUrl = 'http://172.26.44.202:8000/api/login/';
  static const String _registerUrl = 'http://172.26.44.202:8000/api/register/';
  static const String _tokenKey = 'jwt_token';
  static const String _isLoggedInKey = 'isLoggedIn';

  // State
  bool _isLoading = false;
  String _token = "";

  // Getters
  bool get isLoading => _isLoading;
  String get token => _token;

  // Login Method
  Future<void> login(BuildContext context, String username, String email, String password) async {
    // Input validation
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "Please fill in all fields.");
      return;
    }

    _isLoading = true;
    notifyListeners();

    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "username": username,
      "email": email,
      "password": password,
    });

    try {
      final response = await http.post(Uri.parse(_loginUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['access'] != null && data['access'] is String) {
          _token = data['access'];
          notifyListeners();

          await _saveToken(_token); // Save token
          await _setLoggedInStatus(true); // Mark user as logged in



          // Navigate to Dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavBarScreen()),
          );
        } else {
          _showErrorDialog(context, "Access token missing or invalid format.");
        }
      } else if (response.statusCode == 401) {
        _showErrorDialog(context, "Invalid username or password.");
      } else {
        _showErrorDialog(context, "Something went wrong. Please try again.");
      }
    } catch (e) {
      print("Error during login: $e");
      _showErrorDialog(context, "Something went wrong. Check your internet connection.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  // Register Method
  Future<void> register(BuildContext context, String username, String email, String password) async {
    // Input validation
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "Please fill in all fields.");
      return;
    }

    _isLoading = true;
    notifyListeners();

    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "username": username,
      "email": email,
      "password": password,
      "role": 'student',
    });

    try {
      final response = await http.post(Uri.parse(_registerUrl), headers: headers, body: body);

      if (response.statusCode == 201) {
        _showSuccessDialog(context, "Registration successful! Please log in.");
      } else if (response.statusCode == 400) {
        _showErrorDialog(context, "Username or email already exists.");
      } else {
        _showErrorDialog(context, "Registration failed. Please try again.");
      }
    } catch (e) {
      _showErrorDialog(context, "Something went wrong. Check your internet connection.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout Method
  Future<void> logout(BuildContext context) async {
    _token = "";
    notifyListeners();

    await _clearUserData(); // Clear all user-related data

    // Navigate to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Save Token to SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);

  }

  // Retrieve Token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    return token;
  }


  // Set Logged-In Status
  Future<void> _setLoggedInStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  // Clear User Data (Token and Login Status)
  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_isLoggedInKey);
  }

  // Show Error Dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Show Success Dialog
  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}