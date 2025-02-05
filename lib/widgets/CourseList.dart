import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/AuthProvider.dart';
import '../services/CourseService.dart'; // Import the AuthProvider
import '../models/Course.dart'; // Import the Course model
import '../widgets/CourseCard.dart'; // Import the CourseCard widget

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  Future<List<Course>>? coursesFuture; // Remove 'late' and make it nullable

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchCourses(); // Call the method to load token and fetch courses
  }

  Future<void> _loadTokenAndFetchCourses() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = await authProvider.getToken(); // Retrieve token

      if (token == null) {
        throw Exception('Token not found. Please log in again.');
      }

      print('Retrieved Token: $token'); // Debugging

      setState(() {
        coursesFuture = CourseService().fetchCourses(token); // Pass token to fetch courses
      });
    } catch (e) {
      setState(() {
        coursesFuture = Future.error(e); // Handle errors
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FutureBuilder<List<Course>>(
        future: coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No courses available"));
          }

          final courses = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CourseCard(course: courses[index]),
                  if (index != courses.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        thickness: 0.8,
                        color: Colors.grey[400],
                        height: 10,
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}