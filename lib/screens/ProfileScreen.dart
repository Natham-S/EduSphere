import 'package:edusphere/services/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/CustomColorScheme.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile" ,style:  TextStyle(color: customColorScheme.tertiaryFixed),),
        centerTitle: true,

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Text(
                "Rio",  // Replace with actual user data
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),

              // User Email
              const Text(
                "rio@gmail.com", // Replace with actual user data
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    authProvider.logout(context);
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text("Logout", style: TextStyle(fontSize: 18, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
