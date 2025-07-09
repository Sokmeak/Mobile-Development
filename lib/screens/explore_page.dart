import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/footer.dart';
import 'package:my_flutter_app/models/course.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'course_detail_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  String selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Course> _searchResults = [];
  late TabController _searchTabController;

  // Search result categories
  final List<String> searchTabs = [
    'All Results',
    'Courses',
    'Projects',
    'Instructors',
  ];

  final List<String> categories = [
    'All',
    'Business',
    'Development',
    'Personal Development',
    'Design',
  ];

  @override
  void initState() {
    super.initState();
    _searchTabController = TabController(
      length: searchTabs.length,
      vsync: this,
    );
  }

  List<Course> getFilteredCourses(List<Course> courses) {
    if (selectedCategory == 'All') {
      return courses;
    }
    return courses
        .where((course) => course.category == selectedCategory)
        .toList();
  }

  void _searchCourses(String query, List<Course> allCourses) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchResults =
          allCourses.where((course) {
            return course.title.toLowerCase().contains(query.toLowerCase()) ||
                course.description.toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                course.instructor.toLowerCase().contains(query.toLowerCase()) ||
                course.category.toLowerCase().contains(query.toLowerCase());
          }).toList();
    });
  }

  void _handleSearchSubmit(String query) {
    if (query.isNotEmpty) {
      _searchCourses(
        query,
        getFilteredCourses(
          Provider.of<AppState>(context, listen: false).courses,
        ),
      );
    }
  }

  // Filter search results based on selected tab
  List<Course> getTabFilteredResults(int tabIndex) {
    switch (tabIndex) {
      case 0: // All Results
        return _searchResults;
      case 1: // Courses
        return _searchResults; // For now, all results are courses
      case 2: // Projects
        return _searchResults
            .where(
              (course) =>
                  course.category == 'Development' ||
                  course.category == 'Design',
            )
            .toList();
      case 3: // Instructors
        return _searchResults; // You might want to group by instructor here
      default:
        return _searchResults;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final filteredCourses = getFilteredCourses(appState.courses);
    final displayCourses = _isSearching ? _searchResults : filteredCourses;

    return Scaffold(
      appBar: AppBar(
        title:
            _isSearching
                ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Find interested course...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _isSearching = false;
                        });
                      },
                    ),
                  ),
                  onSubmitted: _handleSearchSubmit,
                )
                : const Text('worktency'),
        actions: [
          _isSearching
              ? Container()
              : IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
              ),
        ],
        bottom:
            _isSearching
                ? TabBar(
                  controller: _searchTabController,
                  tabs: searchTabs.map((tab) => Tab(text: tab)).toList(),
                  isScrollable: true,
                  indicatorColor: Colors.blue,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                )
                : null,
      ),
      body:
          _isSearching
              ? TabBarView(
                controller: _searchTabController,
                children: List.generate(searchTabs.length, (index) {
                  final tabResults = getTabFilteredResults(index);
                  return _buildSearchResultsView(tabResults, index);
                }),
              )
              : _buildMainContent(appState, filteredCourses, displayCourses),
    );
  }

  Widget _buildMainContent(
    AppState appState,
    List<Course> filteredCourses,
    List<Course> displayCourses,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explore your favorite subjects!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Build your competency with us!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    categories.map((category) {
                      return _buildCategoryChip(
                        category,
                        isSelected: selectedCategory == category,
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                            _searchController.clear();
                            _isSearching = false;
                          });
                        },
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Best recommended for you!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 260, // Increased height to prevent overflow
              child: _buildHorizontalCourseList(
                filteredCourses.take(5).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'All Courses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            appState.courses.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : displayCourses.isEmpty
                ? _buildEmptyState()
                : _buildGroupedCourseList(displayCourses),

            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultsView(List<Course> results, int tabIndex) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${results.length} results for "${_searchController.text}"',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            results.isEmpty
                ? _buildEmptySearchState()
                : tabIndex == 0 || tabIndex == 1
                ? _buildVerticalCourseList(results)
                : tabIndex == 2
                ? _buildProjectsView(results)
                : _buildInstructorsView(results),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsView(List<Course> courses) {
    return SizedBox(
      height: 260, // Fixed height to prevent overflow
      child: _buildHorizontalCourseList(courses),
    );
  }

  Widget _buildInstructorsView(List<Course> courses) {
    // Group courses by instructor
    Map<String, List<Course>> instructorGroups = {};
    for (var course in courses) {
      instructorGroups[course.instructor] =
          instructorGroups[course.instructor] ?? [];
      instructorGroups[course.instructor]!.add(course);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: instructorGroups.length,
      itemBuilder: (context, index) {
        String instructor = instructorGroups.keys.elementAt(index);
        List<Course> instructorCourses = instructorGroups[instructor]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              instructor,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 260, // Fixed height to prevent overflow
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: instructorCourses.length,
                itemBuilder: (context, courseIndex) {
                  return _buildFeaturedCourseCard(
                    instructorCourses[courseIndex],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No courses found in "$selectedCategory"',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No results found for "${_searchController.text}"',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _isSearching = false;
              });
            },
            child: const Text('Clear search'),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalCourseList(List<Course> courses) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _buildCourseCard(courses[index]);
      },
    );
  }

  Widget _buildHorizontalCourseList(List<Course> courses) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _buildFeaturedCourseCard(courses[index]);
      },
    );
  }

  Widget _buildCategoryChip(
    String label, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          backgroundColor:
              isSelected ? Colors.blue.shade800 : Colors.grey.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
      ),
    );
  }

  Widget _buildFeaturedCourseCard(Course course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(course: course),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fixed image container
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Image.asset(
                    course.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.error, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
              // Fixed content area with proper spacing
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12), // Reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title - fixed height with reduced space
                      SizedBox(
                        height: 35, // Reduced from 36
                        child: Text(
                          course.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4), // Reduced spacing
                      // Description - flexible but with constraints
                      Expanded(
                        child: Text(
                          course.description,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4), // Reduced spacing
                      // Instructor - fixed height
                      SizedBox(
                        height: 14, // Reduced from 16
                        child: Text(
                          'Instructor: ${course.instructor}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11, // Reduced font size
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8), // Reduced spacing
                      // Button - fixed at bottom with reduced height
                      SizedBox(
                        width: double.infinity,
                        height: 28, // Reduced from 32
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        CourseDetailPage(course: course),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                            ), // Reduced padding
                          ),
                          child: const Text(
                            'See more',
                            style: TextStyle(fontSize: 11), // Reduced font size
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(course: course),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  course.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.error, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      course.description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Instructor: ${course.instructor}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          '\$${course.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        CourseDetailPage(course: course),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('See more'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupedCourseList(List<Course> courses) {
    final Map<String, List<Course>> groupedCourses = {};
    for (var course in courses) {
      groupedCourses[course.category] = groupedCourses[course.category] ?? [];
      groupedCourses[course.category]!.add(course);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupedCourses.length,
      itemBuilder: (context, index) {
        String category = groupedCourses.keys.elementAt(index);
        List<Course> categoryCourses = groupedCourses[category]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 260, // Fixed height to prevent overflow
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryCourses.length,
                itemBuilder: (context, courseIndex) {
                  return _buildFeaturedCourseCard(categoryCourses[courseIndex]);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
