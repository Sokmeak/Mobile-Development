class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String instructor;
  final String username; // Add for username (e.g., @ITC)
  final String level; // Add for level (e.g., Beginner)
  final String school; // Add for school (e.g., ITC)
  final double price;
  final double rating;
  final int totalStudents;

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
  });
}

// Title: "Microsoft Word"
// Level: "Beginner" (inferred from "មូលដ្ឋានគ្រឹះ", meaning "Basic" in Khmer)
// Number of Students: 99
// Instructor: "Mr. Bunthorn LIV"
// Username: "@ITC"
// School: "ITC"
// Price: $39.99
// Image: Microsoft Word logo (we’ll use 'assets/images/microsoft_word_logo.png')