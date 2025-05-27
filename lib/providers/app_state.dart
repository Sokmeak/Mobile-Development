import 'package:flutter/material.dart';
import '../models/course.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  List<Course> _courses = [];
  int _currentNavIndex = 2; // Default to home/online course tab

  bool get isLoggedIn => _isLoggedIn;
  List<Course> get courses => _courses;
  int get currentNavIndex => _currentNavIndex;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }

  void fetchCourses() {
    // Function to generate 12 courses (4 per category)
    _courses = [
      // Category 0: Microsoft Word or AI-related courses
      Course(
        id: 'course_1',
        title: 'Microsoft Word',
        description:
            'Master Microsoft Word for professional document creation.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Mr. Bunthorn LIV',
        username: '@ITC',
        level: 'មូលដ្ឋានគ្រឹះ', // Basic in Khmer
        school: 'ITC',
        price: 39.99,
        rating: 4.5,
        totalStudents: 100,
      ),
      Course(
        id: 'course_2',
        title: 'Microsoft Word',
        description: 'Use Microsoft Word to create AI training manuals.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Ms. Sopheak KIM',
        username: '@TechAcademy',
        level: 'មធ្យម', // Intermediate in Khmer
        school: 'Tech Academy',
        price: 49.99,
        rating: 4.7,
        totalStudents: 120,
      ),
      Course(
        id: 'course_3',
        title: 'AI Documentation',
        description: 'Learn to document AI projects using Microsoft Word.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Mr. Sokha VANN',
        username: '@AIInstitute',
        level: 'មូលដ្ឋានគ្រឹះ',
        school: 'AI Institute',
        price: 44.99,
        rating: 4.4,
        totalStudents: 90,
      ),
      Course(
        id: 'course_4',
        title: 'Office Productivity',
        description:
            'Boost AI project efficiency with Microsoft Word skills.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Ms. Leakena SOK',
        username: '@GlobalTech',
        level: 'មធ្យម',
        school: 'Global Tech',
        price: 42.99,
        rating: 4.6,
        totalStudents: 110,
      ),
      // Category 1: Machine Learning-related courses
      Course(
        id: 'course_5',
        title: 'Machine Learning Basics',
        description: 'Introduction to Machine Learning concepts and tools.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Dr. Rithy CHAN',
        username: '@MLLab',
        level: 'កម្រិតខ្ពស់', // Advanced in Khmer
        school: 'ML Lab',
        price: 89.99,
        rating: 4.8,
        totalStudents: 200,
      ),
      Course(
        id: 'course_6',
        title: 'Applied Machine Learning',
        description:
            'Build Machine Learning models for real-world applications.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Ms. Sreypov LY',
        username: '@DataScienceHub',
        level: 'កម្រិតខ្ពស់',
        school: 'Data Science Hub',
        price: 99.99,
        rating: 4.9,
        totalStudents: 180,
      ),
      Course(
        id: 'course_7',
        title: 'Machine Learning with Python',
        description: 'Learn Machine Learning using Python libraries.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Mr. Vuthy SENG',
        username: '@TechInstitute',
        level: 'មធ្យម',
        school: 'Tech Institute',
        price: 79.99,
        rating: 4.7,
        totalStudents: 160,
      ),
      Course(
        id: 'course_8',
        title: 'Deep Learning Fundamentals',
        description: 'Explore Machine Learning with deep neural networks.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Ms. Chenda HENG',
        username: '@AILearn',
        level: 'កម្រិតខ្ពស់',
        school: 'AI Learn',
        price: 94.99,
        rating: 4.8,
        totalStudents: 170,
      ),
      // Category 2: Self Development-related courses
      Course(
        id: 'course_9',
        title: 'Personal Growth Mastery',
        description:
            'Unlock your potential with Self Development techniques.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Mr. Samnang LY',
        username: '@GrowEasy',
        level: 'មូលដ្ឋានគ្រឹះ',
        school: 'Grow Easy',
        price: 59.99,
        rating: 4.4,
        totalStudents: 85,
      ),
      Course(
        id: 'course_10',
        title: 'Leadership Skills',
        description: 'Develop leadership through Self Development practices.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Ms. Sreynith SAM',
        username: '@InspireCo',
        level: 'មធ្យម',
        school: 'Inspire Co',
        price: 64.99,
        rating: 4.5,
        totalStudents: 95,
      ),
      Course(
        id: 'course_11',
        title: 'Mindset Transformation',
        description: 'Master Self Development for a positive mindset.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Mr. Dara KONG',
        username: '@SelfGrow',
        level: 'មូលដ្ឋានគ្រឹះ',
        school: 'Self Grow',
        price: 54.99,
        rating: 4.3,
        totalStudents: 80,
      ),
      Course(
        id: 'course_12',
        title: 'Career Success',
        description: 'Achieve goals with Self Development strategies.',
        imageUrl: 'assets/images/word.jpeg',
        instructor: 'Ms. Socheata PHAN',
        username: '@CareerPath',
        level: 'មធ្យម',
        school: 'Career Path',
        price: 62.99,
        rating: 4.6,
        totalStudents: 90,
      ),
    ];

    notifyListeners();
  }
}
