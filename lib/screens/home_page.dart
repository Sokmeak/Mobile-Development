import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/teacher.dart';
import '../models/testimonial.dart';
import '../components/course_card.dart';
import '../components/teacher_card.dart';
import '../components/testimonial_card.dart';
import '../components/worktency_logo.dart';
import '../models/course.dart';
import '../providers/app_state.dart';

class WorktencyHomePage extends StatelessWidget {
  const WorktencyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Sample data for courses
    final courses = appState.courses;

    // Sample data for teachers
    final teachers = [
      Teacher(
        name: 'Dr. Valy Dona',
        title: 'Researcher, AI Specialist',
        imageUrl: 'assets/images/vali.jpg',
      ),
      Teacher(
        name: 'Hok Tin',
        title: 'Web Developer',
        imageUrl: 'assets/images/hoktin.jpg',
      ),
      Teacher(
        name: 'Heng Rathpisey',
        title: 'Lecturer at ITC',
        imageUrl: 'assets/images/rathpisey.jpg',
      ),
    ];

    // Sample data for testimonials
    final testimonials = [
      Testimonial(
        quote:
            'Machine learning and AI are the engines driving the technological revolution of our time, transforming the way we work, live, and innovate.',
        author: 'Dr. Valy Dona',
        authorTitle: 'Professor at ITC, Co-founder at Worktency',
        imageUrl: 'assets/images/machine-learning.jpg',
        category: 'Artificial Intelligence',
      ),
      Testimonial(
        quote:
            'Machine learning and AI are the engines driving the technological revolution of our time, transforming the way we work, live, and innovate.',
        author: 'Dr. Valy Dona',
        authorTitle: 'Professor at ITC, Co-founder at Worktency',
        imageUrl: 'assets/images/machine-learning.jpg',
        category: 'Artificial Intelligence',
      ),
      Testimonial(
        quote:
            'Machine learning and AI are the engines driving the technological revolution of our time, transforming the way we work, live, and innovate.',
        author: 'Dr. Valy Dona',
        authorTitle: 'Professor at ITC, Co-founder at Worktency',
        imageUrl: 'assets/images/machine-learning.jpg',
        category: 'Artificial Intelligence',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ), // Updated background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
            ), // Responsive padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Hero Section
                Center(
                  child: Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth * 0.9,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize:
                                  screenWidth * 0.07, // Responsive font size
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 1.3,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Unlock Your Potential\nwith ',
                              ),
                              TextSpan(
                                text: 'Worktency',
                                style: TextStyle(color: Colors.orange.shade600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth * 0.9,
                        ),
                        child: Text(
                          'Discover industry-leading courses designed to equip you with real-world skills. Join our community and start your journey to success today.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 250,
                          maxWidth: screenWidth * 0.8,
                        ),
                        child: Image.asset(
                          'assets/images/Developeractivity.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Buttons with proper constraints
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: screenWidth * 0.8,
                        ),
                        child: OutlinedButton.icon(
                          onPressed: () {
                            appState.setNavIndex(0);
                          },
                          icon: const Icon(Icons.menu_book),
                          label: const Text('Explore Courses'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue.shade800,
                            side: BorderSide(color: Colors.blue.shade800),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: screenWidth * 0.8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.orange.shade400,
                            width: 2,
                          ),
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/educator-signup');
                          },
                          icon: const Icon(Icons.person_add),
                          label: const Text('Join as an educator'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade400,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Featured Courses Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Featured Courses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCategoryTabsAndGrid(context, courses, screenWidth),
                    const SizedBox(height: 40),
                  ],
                ),
                const SizedBox(height: 40),
                // Teachers Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Meet Our Teachers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(right: 16),
                        itemCount: teachers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: screenWidth * 0.6, // Responsive width
                            margin: const EdgeInsets.only(right: 16),
                            child: TeacherCard(teacher: teachers[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Testimonials Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.orange.shade600,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'To teach is our only goal, learn what we share with you today',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Testimonials with proper constraints
                    ...testimonials.map(
                      (testimonial) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: TestimonialCard(testimonial: testimonial),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Footer Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 255, 255, 255),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LogoWidget(),
                      const SizedBox(height: 20),

                      // Footer links with responsive layout
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFooterLink('About Us'),
                                _buildFooterLink('Contact Us'),
                                _buildFooterLink('FAQs'),
                                _buildFooterLink('Community Forum'),
                                _buildFooterLink('Term of Service'),
                                _buildFooterLink('Careers'),
                                _buildFooterLink('Leadership'),
                                _buildFooterLink('Blog'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFooterLink('Social Impact'),
                                _buildFooterLink('Cookies Setting'),
                                _buildFooterLink('Accessibility Statement'),
                                _buildFooterLink('Investors'),
                                _buildFooterLink('Go Pro Course'),
                                _buildFooterLink('Affiliate'),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 150),
                          child: Image.asset(
                            'assets/images/itc.jpeg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.facebook),
                              onPressed: () {},
                              color: Colors.grey,
                            ),
                            IconButton(
                              icon: const Icon(Icons.alternate_email),
                              onPressed: () {},
                              color: Colors.grey,
                            ),
                            IconButton(
                              icon: const Icon(Icons.play_circle_filled),
                              onPressed: () {},
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          '© 2025 Worktency, Inc. All rights reserved.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLink(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildCategoryTabsAndGrid(
    BuildContext context,
    List<Course> courses,
    double screenWidth,
  ) {
    int selectedTabIndex = 0;

    final List<String> categories = [
      'Artificial Intelligent',
      'Machine Learning',
      'Self Development',
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        final filteredCourses =
            courses.where((course) {
              switch (selectedTabIndex) {
                case 0:
                  return course.title == 'Microsoft Word' ||
                      course.description.contains('AI');
                case 1:
                  return course.description.contains('Machine Learning');
                case 2:
                  return course.description.contains('Self Development');
                default:
                  return true;
              }
            }).toList();

        // Determine grid cross axis count based on screen width
        int crossAxisCount = screenWidth > 600 ? 3 : 2;
        if (screenWidth < 400) crossAxisCount = 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category tabs with horizontal scroll
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedTabIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 32),
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color:
                                isSelected
                                    ? Colors.orange.shade600
                                    : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                isSelected
                                    ? const Color(0xFF2D3748)
                                    : const Color(0xFF718096),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Responsive grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredCourses.length.clamp(0, crossAxisCount * 2),
              itemBuilder: (context, index) {
                return CourseCard(course: filteredCourses[index]);
              },
            ),
          ],
        );
      },
    );
  }
}
