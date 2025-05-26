class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String instructor;
  final double price;
  final double rating;
  final int totalStudents;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.instructor,
    required this.price,
    required this.rating,
    required this.totalStudents,
  });
}