class Course {
  final int id;
  final String title;
  final String description;
  final String instructor;
  final String category;
  final double price; // Ensure this is double
  final int numLessons;
  final String startDate;
  final String endDate;
  final int durationWeeks;
  final String difficultyLevel;
  final int totalEnrolled;
  final String createdAt;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.category,
    required this.price,
    required this.numLessons,
    required this.startDate,
    required this.endDate,
    required this.durationWeeks,
    required this.difficultyLevel,
    required this.totalEnrolled,
    required this.createdAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      instructor: json['instructor'] ?? '',
      category: json['category'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0, // Convert price safely
      numLessons: json['num_lessons'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      durationWeeks: json['duration_weeks'] ?? 0,
      difficultyLevel: json['difficulty_level'] ?? '',
      totalEnrolled: json['total_enrolled'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }
}
