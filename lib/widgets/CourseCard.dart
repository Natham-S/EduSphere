import 'package:flutter/material.dart';

import '../screens/CourseDetailScreen.dart';
import '../models/Course.dart';
import '../ui/CustomColorScheme.dart';

class CourseCard extends StatelessWidget{
  const CourseCard({super.key, required this.course});

  final Course course;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      color: customColorScheme.surface,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(course: course),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: customColorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 5),

              Text(
                course.instructor,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category: ${course.category}"),
                  Text("Price: \$${course.price}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800),),
                ],
              ),
              const SizedBox(height: 5),

              Text("Lessons: ${course.numLessons} | Duration: ${course.durationWeeks} weeks"),
              const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}