import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade800,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareCourse(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseImage(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstructorRow(),
                  const SizedBox(height: 16),
                  _buildPriceCard(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('About This Course'),
                  const SizedBox(height: 8),
                  Text(
                    course.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('What You\'ll Learn'),
                  const SizedBox(height: 8),
                  ..._buildLearningPoints(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Course Content'),
                  const SizedBox(height: 8),
                  ..._buildCourseSections(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _enrollInCourse(context),
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Enroll Now'),
        backgroundColor: Colors.orange.shade400,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildCourseImage() {
    return Hero(
      tag: 'course-image-${course.id}',
      child: Image.network(
        course.imageUrl,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) => Container(
              height: 220,
              color: Colors.grey.shade200,
              child: Center(
                child: Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 220,
            color: Colors.grey.shade200,
            child: Center(
              child: CircularProgressIndicator(
                value:
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInstructorRow() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            course.instructor.substring(0, 1),
            style: TextStyle(color: Colors.blue.shade800),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.instructor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                course.username,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Chip(
          backgroundColor: Colors.amber.shade50,
          label: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text(
                course.rating.toStringAsFixed(1),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Course Price',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${course.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () => (),
              icon: const Icon(Icons.shopping_cart, size: 18),
              label: const Text('Enroll Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade400,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  List<Widget> _buildLearningPoints() {
    return course.learningPoints
            ?.map((point) => _buildLearningPoint(point))
            .toList() ??
        [
          _buildLearningPoint('Master core concepts and techniques'),
          _buildLearningPoint('Gain practical hands-on experience'),
          _buildLearningPoint('Build real-world projects'),
          _buildLearningPoint('Get lifetime access to course materials'),
        ];
  }

  Widget _buildLearningPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  List<Widget> _buildCourseSections() {
    return course.sections
            ?.map((section) => _buildContentSection(section))
            .toList() ??
        [
          _buildContentSection(
            CourseSection(
              title: 'Introduction',
              subtitle: '3 lectures • 45 min',
              lectures: [
                Lecture(title: 'Welcome to the Course', duration: '10:00'),
                Lecture(title: 'Course Overview', duration: '15:00'),
                Lecture(title: 'Setting Up Environment', duration: '20:00'),
              ],
            ),
          ),
        ];
  }

  Widget _buildContentSection(CourseSection section) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          section.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          section.subtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        children:
            section.lectures
                .map((lecture) => _buildLectureTile(lecture))
                .toList(),
      ),
    );
  }

  Widget _buildLectureTile(Lecture lecture) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.play_circle_filled,
            color: Colors.blue.shade400,
            size: 20,
          ),
        ),
        title: Text(lecture.title, style: const TextStyle(fontSize: 14)),
        trailing: Text(
          lecture.duration,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        onTap: () {
          // Handle lecture playback
        },
      ),
    );
  }

  void _enrollInCourse(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Enrolled in ${course.title}!'),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'View',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to course content
          },
        ),
      ),
    );
  }

  void _shareCourse(BuildContext context) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share link copied to clipboard')),
    );
  }
}
