import 'package:edusphere/models/Course.dart';
import 'package:flutter/material.dart';

import '../utils/DummyLessonData.dart';
import 'VideoPlayerScreen.dart';



class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Title
              Text(
                course.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Course Description
              Text(
                course.description,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              // Instructor and Category
              Text(
                'Instructor: ${course.instructor}',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Category: ${course.category}',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Price and Duration
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price: \$${course.price}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Duration: ${course.durationWeeks} weeks',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Lessons and Enrolled Students
              Text(
                'Lessons: ${course.numLessons}',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Enrolled: ${course.totalEnrolled} students',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Difficulty Level
              Text(
                'Difficulty Level: ${course.difficultyLevel}',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // List of lessons or videos (can be added here)
              Text(
                'Related Lessons:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Example of related lessons/videos
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: course.numLessons,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.play_arrow),
                    title: Text('Lesson ${index + 1}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
                        ),
                      );



                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
