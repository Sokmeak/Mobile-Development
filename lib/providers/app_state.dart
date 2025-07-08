import 'package:flutter/material.dart';
import '../models/course.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  List<Course> _courses = [];
  List<Course> _enrolledCourses = [];
  int _currentNavIndex = 2; // Default to home/online course tab
  bool _isLoading = false;
  String? _error;

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  List<Course> get courses => List.unmodifiable(_courses);
  List<Course> get enrolledCourses => List.unmodifiable(_enrolledCourses);
  int get currentNavIndex => _currentNavIndex;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Authentication methods
  void login() {
    _isLoggedIn = true;
    _error = null;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _enrolledCourses.clear();
    _error = null;
    notifyListeners();
  }

  // Navigation methods
  void setNavIndex(int index) {
    if (index >= 0 && index < 5) {
      // Assuming 5 navigation tabs
      _currentNavIndex = index;
      notifyListeners();
    }
  }

  // Course management methods
  void enrollInCourse(String courseId) {
    final course = _courses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => throw Exception('Course not found'),
    );

    if (!_enrolledCourses.any((c) => c.id == courseId)) {
      _enrolledCourses.add(course);
      notifyListeners();
    }
  }

  void unenrollFromCourse(String courseId) {
    _enrolledCourses.removeWhere((c) => c.id == courseId);
    notifyListeners();
  }

  bool isEnrolledInCourse(String courseId) {
    return _enrolledCourses.any((c) => c.id == courseId);
  }

  // Filter methods
  List<Course> getCoursesByCategory(String category) {
    return _courses.where((course) => course.category == category).toList();
  }

  List<Course> searchCourses(String query) {
    if (query.isEmpty) return _courses;

    return _courses.where((course) {
      return course.title.toLowerCase().contains(query.toLowerCase()) ||
          course.description.toLowerCase().contains(query.toLowerCase()) ||
          course.instructor.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<Course> getCoursesByLevel(String level) {
    return _courses.where((course) => course.level == level).toList();
  }

  // Data fetching methods
  Future<void> fetchCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      _courses = [
        // Category: Business - Microsoft Word courses
        Course(
          id: 'course_1',
          title: 'Microsoft Word Essentials',
          description:
              'Master Microsoft Word for professional document creation. Learn formatting, templates, and advanced features.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Mr. Bunthorn LIV',
          username: '@ITC',
          level: 'មូលដ្ឋានគ្រឹះ',
          school: 'ITC',
          price: 39.99,
          rating: 4.5,
          totalStudents: 100,
          category: 'Business',
          learningPoints: [
            'Create professional documents',
            'Master formatting and styles',
            'Use templates effectively',
            'Collaborate with others',
          ],
          sections: [
            CourseSection(
              title: 'Getting Started with Word',
              subtitle: '4 lectures • 1h 15min',
              lectures: [
                Lecture(
                  title: 'Introduction to Microsoft Word',
                  duration: '15:30',
                ),
                Lecture(title: 'Interface Overview', duration: '20:45'),
                Lecture(
                  title: 'Creating Your First Document',
                  duration: '18:20',
                ),
                Lecture(title: 'Saving and File Management', duration: '20:40'),
              ],
            ),
            CourseSection(
              title: 'Text Formatting',
              subtitle: '5 lectures • 1h 45min',
              lectures: [
                Lecture(
                  title: 'Font and Paragraph Formatting',
                  duration: '22:15',
                ),
                Lecture(title: 'Styles and Themes', duration: '25:30'),
                Lecture(title: 'Headers and Footers', duration: '18:45'),
                Lecture(title: 'Page Layout', duration: '20:30'),
                Lecture(title: 'Advanced Formatting', duration: '18:00'),
              ],
            ),
          ],
        ),

        Course(
          id: 'course_2',
          title: 'Advanced Microsoft Word',
          description:
              'Use Microsoft Word to create AI training manuals and technical documentation.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Ms. Sopheak KIM',
          username: '@TechAcademy',
          level: 'មធ្យម',
          school: 'Tech Academy',
          price: 49.99,
          rating: 4.7,
          totalStudents: 120,
          category: 'Business',
          learningPoints: [
            'Create technical documentation',
            'Use advanced features',
            'Automate repetitive tasks',
            'Integrate with other tools',
          ],
          sections: [
            CourseSection(
              title: 'Advanced Features',
              subtitle: '6 lectures • 2h 30min',
              lectures: [
                Lecture(title: 'Mail Merge', duration: '25:00'),
                Lecture(title: 'Table of Contents', duration: '20:15'),
                Lecture(title: 'References and Citations', duration: '22:30'),
                Lecture(title: 'Macros and Automation', duration: '28:45'),
                Lecture(title: 'Forms and Controls', duration: '18:20'),
                Lecture(title: 'Collaboration Tools', duration: '16:10'),
              ],
            ),
          ],
        ),

        // Category: Development - Machine Learning courses
        Course(
          id: 'course_3',
          title: 'Machine Learning Fundamentals',
          description:
              'Introduction to Machine Learning concepts, algorithms, and practical applications.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Dr. Rithy CHAN',
          username: '@MLLab',
          level: 'កម្រិតខ្ពស់',
          school: 'ML Lab',
          price: 89.99,
          rating: 4.8,
          totalStudents: 200,
          category: 'Development',
          learningPoints: [
            'Understand ML algorithms',
            'Build predictive models',
            'Work with real datasets',
            'Deploy ML solutions',
          ],
          sections: [
            CourseSection(
              title: 'Introduction to ML',
              subtitle: '5 lectures • 2h 15min',
              lectures: [
                Lecture(title: 'What is Machine Learning?', duration: '25:00'),
                Lecture(title: 'Types of ML', duration: '30:15'),
                Lecture(title: 'ML Workflow', duration: '28:30'),
                Lecture(title: 'Data Preprocessing', duration: '22:45'),
                Lecture(title: 'Model Evaluation', duration: '28:15'),
              ],
            ),
            CourseSection(
              title: 'Supervised Learning',
              subtitle: '8 lectures • 3h 45min',
              lectures: [
                Lecture(title: 'Linear Regression', duration: '32:00'),
                Lecture(title: 'Logistic Regression', duration: '28:15'),
                Lecture(title: 'Decision Trees', duration: '25:30'),
                Lecture(title: 'Random Forest', duration: '30:45'),
                Lecture(title: 'Support Vector Machines', duration: '26:20'),
                Lecture(title: 'Neural Networks', duration: '35:10'),
                Lecture(title: 'Model Selection', duration: '22:05'),
                Lecture(title: 'Cross Validation', duration: '25:00'),
              ],
            ),
          ],
        ),

        Course(
          id: 'course_4',
          title: 'Deep Learning with Python',
          description:
              'Master deep learning using Python and popular frameworks like TensorFlow and PyTorch.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Ms. Chenda HENG',
          username: '@AILearn',
          level: 'កម្រិតខ្ពស់',
          school: 'AI Learn',
          price: 94.99,
          rating: 4.8,
          totalStudents: 170,
          category: 'Development',
          learningPoints: [
            'Build neural networks',
            'Use TensorFlow and PyTorch',
            'Create computer vision models',
            'Work with NLP applications',
          ],
          sections: [
            CourseSection(
              title: 'Deep Learning Basics',
              subtitle: '6 lectures • 2h 50min',
              lectures: [
                Lecture(
                  title: 'Introduction to Deep Learning',
                  duration: '30:00',
                ),
                Lecture(
                  title: 'Neural Network Architecture',
                  duration: '25:15',
                ),
                Lecture(title: 'Backpropagation', duration: '28:30'),
                Lecture(title: 'Activation Functions', duration: '22:45'),
                Lecture(title: 'Optimization', duration: '26:15'),
                Lecture(title: 'Regularization', duration: '18:15'),
              ],
            ),
          ],
        ),

        // Category: Personal Development courses
        Course(
          id: 'course_5',
          title: 'Personal Growth Mastery',
          description:
              'Unlock your potential with proven self-development techniques and strategies.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Mr. Samnang LY',
          username: '@GrowEasy',
          level: 'មូលដ្ឋានគ្រឹះ',
          school: 'Grow Easy',
          price: 59.99,
          rating: 4.4,
          totalStudents: 85,
          category: 'Personal Development',
          learningPoints: [
            'Set and achieve goals',
            'Build positive habits',
            'Overcome limiting beliefs',
            'Develop emotional intelligence',
          ],
          sections: [
            CourseSection(
              title: 'Foundation of Growth',
              subtitle: '4 lectures • 1h 30min',
              lectures: [
                Lecture(
                  title: 'Understanding Personal Growth',
                  duration: '20:00',
                ),
                Lecture(title: 'Self-Awareness Assessment', duration: '25:15'),
                Lecture(title: 'Goal Setting Framework', duration: '22:30'),
                Lecture(title: 'Creating Action Plans', duration: '22:15'),
              ],
            ),
          ],
        ),

        Course(
          id: 'course_6',
          title: 'Leadership Excellence',
          description:
              'Develop essential leadership skills and emotional intelligence for career success.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Ms. Sreynith SAM',
          username: '@InspireCo',
          level: 'មធ្យម',
          school: 'Inspire Co',
          price: 64.99,
          rating: 4.5,
          totalStudents: 95,
          category: 'Personal Development',
          learningPoints: [
            'Lead effective teams',
            'Communicate with influence',
            'Make strategic decisions',
            'Build organizational culture',
          ],
          sections: [
            CourseSection(
              title: 'Leadership Fundamentals',
              subtitle: '5 lectures • 2h 10min',
              lectures: [
                Lecture(title: 'What Makes a Great Leader', duration: '28:00'),
                Lecture(title: 'Leadership Styles', duration: '22:15'),
                Lecture(title: 'Building Trust', duration: '25:30'),
                Lecture(title: 'Motivating Others', duration: '26:45'),
                Lecture(title: 'Conflict Resolution', duration: '27:30'),
              ],
            ),
          ],
        ),

        // Add these to your _courses list in the fetchCourses() method

        // Category: Business - Excel courses
        Course(
          id: 'course_7',
          title: 'Excel for Business Analysis',
          description:
              'Master Excel for business analytics, financial modeling, and data visualization.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Mr. Vannak KONG',
          username: '@BizAnalytics',
          level: 'មធ្យម',
          school: 'Business Analytics',
          price: 44.99,
          rating: 4.6,
          totalStudents: 150,
          category: 'Business',
          learningPoints: [
            'Advanced formulas and functions',
            'PivotTables and data analysis',
            'Financial modeling techniques',
            'Interactive dashboards',
          ],
          sections: [
            CourseSection(
              title: 'Excel Fundamentals',
              subtitle: '5 lectures • 2h',
              lectures: [
                Lecture(title: 'Excel Interface Review', duration: '15:00'),
                Lecture(title: 'Essential Formulas', duration: '25:00'),
                Lecture(title: 'Data Formatting', duration: '20:00'),
                Lecture(title: 'Conditional Formatting', duration: '25:00'),
                Lecture(title: 'Charts Basics', duration: '15:00'),
              ],
            ),
          ],
        ),

        // Category: Development - Web Development
        Course(
          id: 'course_8',
          title: 'Full-Stack Web Development',
          description:
              'Learn to build modern web applications with React, Node.js, and MongoDB.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Mr. Dara CHHOUK',
          username: '@WebMaster',
          level: 'កម្រិតខ្ពស់',
          school: 'Code Academy',
          price: 79.99,
          rating: 4.7,
          totalStudents: 210,
          category: 'Development',
          learningPoints: [
            'Build responsive frontends with React',
            'Create RESTful APIs with Node.js',
            'Database design with MongoDB',
            'Authentication and security',
          ],
          sections: [
            CourseSection(
              title: 'Frontend Development',
              subtitle: '7 lectures • 3h 15min',
              lectures: [
                Lecture(title: 'HTML5 & CSS3', duration: '30:00'),
                Lecture(title: 'JavaScript ES6+', duration: '35:00'),
                Lecture(title: 'React Fundamentals', duration: '40:00'),
                Lecture(title: 'State Management', duration: '30:00'),
                Lecture(title: 'React Hooks', duration: '25:00'),
                Lecture(title: 'Styling Components', duration: '20:00'),
                Lecture(title: 'API Integration', duration: '15:00'),
              ],
            ),
          ],
        ),

        // Category: Design - Graphic Design
        Course(
          id: 'course_9',
          title: 'Graphic Design Masterclass',
          description:
              'Learn professional design principles, tools, and techniques for print and digital media.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Ms. Sopheak SOK',
          username: '@DesignPro',
          level: 'មធ្យម',
          school: 'Creative Arts',
          price: 54.99,
          rating: 4.5,
          totalStudents: 120,
          category: 'Design',
          learningPoints: [
            'Adobe Photoshop mastery',
            'Logo and branding design',
            'Typography principles',
            'Layout and composition',
          ],
          sections: [
            CourseSection(
              title: 'Design Fundamentals',
              subtitle: '6 lectures • 2h 30min',
              lectures: [
                Lecture(title: 'Color Theory', duration: '25:00'),
                Lecture(title: 'Typography Basics', duration: '20:00'),
                Lecture(title: 'Layout Principles', duration: '30:00'),
                Lecture(title: 'Design Psychology', duration: '20:00'),
                Lecture(title: 'Brand Identity', duration: '25:00'),
                Lecture(title: 'Design Tools Overview', duration: '10:00'),
              ],
            ),
          ],
        ),

        // Category: Business - PowerPoint
        Course(
          id: 'course_10',
          title: 'PowerPoint for Business Presentations',
          description:
              'Create stunning, professional presentations that captivate your audience.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Mr. Rithy KIM',
          username: '@PresentWell',
          level: 'មូលដ្ឋានគ្រឹះ',
          school: 'Business Skills',
          price: 34.99,
          rating: 4.3,
          totalStudents: 90,
          category: 'Business',
          learningPoints: [
            'Design professional slides',
            'Use animations effectively',
            'Present data visually',
            'Master presentation delivery',
          ],
          sections: [
            CourseSection(
              title: 'Presentation Essentials',
              subtitle: '4 lectures • 1h 30min',
              lectures: [
                Lecture(title: 'PowerPoint Interface', duration: '15:00'),
                Lecture(title: 'Slide Design Principles', duration: '25:00'),
                Lecture(title: 'Working with Templates', duration: '20:00'),
                Lecture(title: 'Adding Multimedia', duration: '30:00'),
              ],
            ),
          ],
        ),

        // Category: Development - Mobile Apps
        Course(
          id: 'course_11',
          title: 'Flutter Mobile Development',
          description:
              'Build beautiful, natively compiled applications for mobile with Flutter.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Mr. Sovannara NGUON',
          username: '@MobileDev',
          level: 'កម្រិតខ្ពស់',
          school: 'App Factory',
          price: 69.99,
          rating: 4.8,
          totalStudents: 180,
          category: 'Development',
          learningPoints: [
            'Flutter framework fundamentals',
            'Dart programming language',
            'State management solutions',
            'Publishing to app stores',
          ],
          sections: [
            CourseSection(
              title: 'Flutter Basics',
              subtitle: '5 lectures • 2h',
              lectures: [
                Lecture(title: 'Introduction to Flutter', duration: '20:00'),
                Lecture(title: 'Dart Crash Course', duration: '30:00'),
                Lecture(title: 'Widgets and Layouts', duration: '25:00'),
                Lecture(title: 'Navigation', duration: '20:00'),
                Lecture(title: 'State Management', duration: '25:00'),
              ],
            ),
          ],
        ),

        // Category: Personal Development - Productivity
        Course(
          id: 'course_12',
          title: 'Ultimate Productivity System',
          description:
              'Develop a productivity system that helps you achieve more with less stress.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Ms. Sreypich HENG',
          username: '@ProductiveLife',
          level: 'មូលដ្ឋានគ្រឹះ',
          school: 'Life Skills',
          price: 49.99,
          rating: 4.6,
          totalStudents: 110,
          category: 'Personal Development',
          learningPoints: [
            'Time management techniques',
            'Task prioritization methods',
            'Overcoming procrastination',
            'Building productive habits',
          ],
          sections: [
            CourseSection(
              title: 'Productivity Foundations',
              subtitle: '4 lectures • 1h 45min',
              lectures: [
                Lecture(title: 'The Productivity Mindset', duration: '25:00'),
                Lecture(title: 'Time Management Systems', duration: '30:00'),
                Lecture(title: 'Task Management Tools', duration: '25:00'),
                Lecture(title: 'Energy Management', duration: '25:00'),
              ],
            ),
          ],
        ),

        // Category: Design - UI/UX
        Course(
          id: 'course_13',
          title: 'UI/UX Design Fundamentals',
          description:
              'Learn user interface and user experience design principles for digital products.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Ms. Dara LEE',
          username: '@DigitalDesign',
          level: 'មធ្យម',
          school: 'Digital Arts',
          price: 59.99,
          rating: 4.7,
          totalStudents: 130,
          category: 'Design',
          learningPoints: [
            'User research methods',
            'Wireframing and prototyping',
            'Usability principles',
            'Design tools (Figma, Sketch)',
          ],
          sections: [
            CourseSection(
              title: 'UX Design Process',
              subtitle: '5 lectures • 2h 15min',
              lectures: [
                Lecture(title: 'Understanding Users', duration: '30:00'),
                Lecture(title: 'Information Architecture', duration: '25:00'),
                Lecture(title: 'Wireframing', duration: '30:00'),
                Lecture(title: 'Prototyping', duration: '25:00'),
                Lecture(title: 'Usability Testing', duration: '25:00'),
              ],
            ),
          ],
        ),

        // Category: Business - Data Analysis
        Course(
          id: 'course_14',
          title: 'Data Analysis with Python',
          description:
              'Learn to analyze and visualize data using Python and its powerful libraries.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Mr. Virak SOK',
          username: '@DataScience',
          level: 'កម្រិតខ្ពស់',
          school: 'Data Academy',
          price: 74.99,
          rating: 4.8,
          totalStudents: 190,
          category: 'Business',
          learningPoints: [
            'Pandas for data manipulation',
            'NumPy for numerical computing',
            'Data visualization with Matplotlib',
            'Real-world data analysis projects',
          ],
          sections: [
            CourseSection(
              title: 'Python for Data Analysis',
              subtitle: '6 lectures • 2h 30min',
              lectures: [
                Lecture(title: 'Python Basics Review', duration: '20:00'),
                Lecture(title: 'Pandas Introduction', duration: '30:00'),
                Lecture(title: 'Data Cleaning', duration: '25:00'),
                Lecture(title: 'Data Transformation', duration: '25:00'),
                Lecture(title: 'Data Visualization', duration: '30:00'),
                Lecture(title: 'Case Study', duration: '20:00'),
              ],
            ),
          ],
        ),

        // Category: Personal Development - Communication
        Course(
          id: 'course_15',
          title: 'Effective Communication Skills',
          description:
              'Master verbal and non-verbal communication to improve relationships and career success.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Ms. Sotheary YIM',
          username: '@CommunicateWell',
          level: 'មូលដ្ឋានគ្រឹះ',
          school: 'Professional Skills',
          price: 39.99,
          rating: 4.4,
          totalStudents: 95,
          category: 'Personal Development',
          learningPoints: [
            'Active listening techniques',
            'Public speaking skills',
            'Non-verbal communication',
            'Difficult conversations',
          ],
          sections: [
            CourseSection(
              title: 'Communication Basics',
              subtitle: '4 lectures • 1h 30min',
              lectures: [
                Lecture(title: 'The Communication Process', duration: '20:00'),
                Lecture(title: 'Listening Skills', duration: '25:00'),
                Lecture(title: 'Verbal Communication', duration: '25:00'),
                Lecture(title: 'Body Language', duration: '20:00'),
              ],
            ),
          ],
        ),

        // Category: Development - Cybersecurity
        Course(
          id: 'course_16',
          title: 'Cybersecurity Fundamentals',
          description:
              'Learn essential cybersecurity concepts to protect systems and data from digital attacks.',
          imageUrl: 'assets/images/word.jpeg',
          instructor: 'Mr. Piseth HOR',
          username: '@SecureIT',
          level: 'កម្រិតខ្ពស់',
          school: 'Security Institute',
          price: 84.99,
          rating: 4.9,
          totalStudents: 160,
          category: 'Development',
          learningPoints: [
            'Network security principles',
            'Encryption techniques',
            'Threat detection',
            'Security best practices',
          ],
          sections: [
            CourseSection(
              title: 'Security Foundations',
              subtitle: '5 lectures • 2h 15min',
              lectures: [
                Lecture(
                  title: 'Introduction to Cybersecurity',
                  duration: '25:00',
                ),
                Lecture(title: 'Types of Threats', duration: '30:00'),
                Lecture(title: 'Network Security', duration: '25:00'),
                Lecture(title: 'Cryptography Basics', duration: '30:00'),
                Lecture(title: 'Security Policies', duration: '25:00'),
              ],
            ),
          ],
        ),
      ];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load courses: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Error handling
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Course statistics
  Map<String, int> getCourseStatistics() {
    final stats = <String, int>{};
    for (var course in _courses) {
      stats[course.category] = (stats[course.category] ?? 0) + 1;
    }
    return stats;
  }

  double getAverageRating() {
    if (_courses.isEmpty) return 0.0;
    final totalRating = _courses.fold(
      0.0,
      (sum, course) => sum + course.rating,
    );
    return totalRating / _courses.length;
  }

  int getTotalStudents() {
    return _courses.fold(0, (sum, course) => sum + course.totalStudents);
  }
}

// Supporting classes for the Course model
// class CourseSection {
//   final String title;
//   final String subtitle;
//   final List<Lecture> lectures;

//   CourseSection({
//     required this.title,
//     required this.subtitle,
//     required this.lectures,
//   });
// }

// class Lecture {
//   final String title;
//   final String duration;

//   Lecture({required this.title, required this.duration});
// }
