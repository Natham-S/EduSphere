import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Course.dart';

class CourseService {



  Future<List<Course>> fetchCourses(String token) async {
    final url = Uri.parse('http://172.26.44.202:8000/api/courses/');
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    print('Using token: $token'); // Debugging

    try {
      final response = await http.get(url, headers: headers);


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> && data.containsKey('courses')) {
          final List<dynamic> coursesJson = data['courses'];
          return coursesJson.map((course) => Course.fromJson(course)).toList();
        } else {
          throw Exception('Unexpected response format: Missing "courses" key');
        }
      } else {
        throw Exception('Failed to fetch courses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching courses: $e');
    }
  }

}