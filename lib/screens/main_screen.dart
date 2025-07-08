import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../widgets/course_search_delegate.dart';
import 'explore_page.dart';
import 'my_courses_page.dart';
import 'home_page.dart';
import 'categories_page.dart';
import 'profile_page.dart';
import '../components/worktency_logo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<AppState>(context, listen: false).fetchCourses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final List<Widget> pages = [
      const ExplorePage(),
      const MyCoursesPage(),
      const WorktencyHomePage(), // Online Course
      const CategoriesPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  const LogoWidget(),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue.shade800,
                      size: 26,
                    ),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CourseSearchDelegate(appState.courses),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue.shade800,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(child: pages[appState.currentNavIndex]),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(context, Icons.search, 'Explore', 0),
                  _buildNavItem(context, Icons.assignment, 'My courses', 1),
                  _buildNavItem(
                    context,
                    Icons.play_circle_outline,
                    'Online course',
                    2,
                  ),
                  _buildNavItem(context, Icons.layers, 'Category', 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final appState = Provider.of<AppState>(context);
    final bool isActive = index == appState.currentNavIndex;

    return GestureDetector(
      onTap: () {
        appState.setNavIndex(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.orange.shade400 : Colors.grey.shade700,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.orange.shade400 : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
