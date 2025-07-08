class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String instructor;
  final String username;
  final String level;
  final String school;
  final double price;
  final double rating;
  final int totalStudents;
  final String category;
  final List<String> learningPoints;
  final List<CourseSection> sections;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.instructor,
    required this.username,
    required this.level,
    required this.school,
    required this.price,
    required this.rating,
    required this.totalStudents,
    required this.category,
    required this.learningPoints,
    required this.sections,
  });
}

class CourseSection {
  final String title;
  final String subtitle;
  final List<Lecture> lectures;

  CourseSection({
    required this.title,
    required this.subtitle,
    required this.lectures,
  });
}

class Lecture {
  final String title;
  final String duration;

  Lecture({
    required this.title,
    required this.duration,
  });
}