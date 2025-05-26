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
    _courses = List.generate(
      10,
          (index) => Course(
        id: index.toString(),
        title: 'Web Development ${index + 1}',
        description: 'Learn essential skills for modern web development',
        imageUrl:
        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-7JjUlQgL1j6HPcmpHp7ditlTcHzOQ8.png',
        instructor: 'Dr. Sarah Johnson',
        price: 49.99 + (index * 10),
        rating: 4.5,
        totalStudents: 1200 + (index * 100),
      ),
    );
    notifyListeners();
  }
}