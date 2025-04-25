import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:college_app/providers/auth_provider.dart';
import 'package:college_app/models/user_model.dart';
import 'package:college_app/constants/app_colors.dart';
import 'package:college_app/constants/app_styles.dart';
import 'package:college_app/screens/dashboard/attendance_section.dart';
import 'package:college_app/screens/dashboard/class_timetable_section.dart';
import 'package:college_app/screens/dashboard/exam_timetable_section.dart';
import 'package:college_app/screens/dashboard/fee_payment_section.dart';
import 'package:college_app/screens/dashboard/hostel_menu_section.dart';
import 'package:college_app/screens/dashboard/study_materials_section.dart';
import 'package:college_app/screens/auth/login_screen.dart';
import 'package:college_app/utils/date_formatter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.getCurrentUser();
  }

  final List<Widget> _pages = [
    const _DashboardHome(),
    const ClassTimetableSection(),
    const StudyMaterialsSection(),
    const AttendanceSection(),
    const ExamTimetableSection(),
    const FeePaymentSection(),
    const HostelMenuSection(),
  ];

  final List<String> _pageTitles = [
    'Dashboard',
    'Class Timetable',
    'Study Materials',
    'Attendance',
    'Exam Schedule',
    'Fee Payment',
    'Hostel Menu',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        _user = authProvider.user!;

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(_pageTitles[_selectedIndex]),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Show notifications
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notifications feature coming soon!'),
                    ),
                  );
                },
              ),
            ],
          ),
          drawer: _buildDrawer(authProvider),
          body: _pages[_selectedIndex],
          bottomNavigationBar: _buildBottomNavigationBar(),
        );
      },
    );
  }

  Widget _buildDrawer(AuthProvider authProvider) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
      DrawerHeader(
      decoration: const BoxDecoration(
      color: AppColors.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Text(
              _user.name.isNotEmpty ? _user.name[0].toUpperCase() : 'S',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _user.email,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
    ListTile(
    leading: const Icon(Icons.home),
    title: const Text('Dashboard'),
    selected: _selectedIndex == 0,
    onTap: () {
    _onItemTapped(0);
    Navigator.pop(context);
    },
    ),
    ListTile(
    leading: const Icon(Icons.schedule),
    title: const Text('Class Timetable'),
    selected: _selectedIndex == 1,
    onTap: () {
    _onItemTapped(1);
    Navigator.pop(context);
    },
    ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Study Materials'),
            selected: _selectedIndex == 2,
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Attendance'),
            selected: _selectedIndex == 3,
            onTap: () {
              _onItemTapped(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.event_note),
            title: const Text('Exam Schedule'),
            selected: _selectedIndex == 4,
            onTap: () {
              _onItemTapped(4);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Fee Payment'),
            selected: _selectedIndex == 5,
            onTap: () {
              _onItemTapped(5);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Hostel Menu'),
            selected: _selectedIndex == 6,
            onTap: () {
              _onItemTapped(6);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex > 4 ? 4 : _selectedIndex,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textSecondaryColor,
      onTap: (index) {
        if (index <= 4) {
          _onItemTapped(index);
        } else {
          _scaffoldKey.currentState!.openDrawer();
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Timetable',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Materials',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle),
          label: 'Attendance',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
    );
  }
}

class _DashboardHome extends StatelessWidget {
  const _DashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primaryColor,
                        child: Text(
                          user.name.isNotEmpty ? user.name[0].toUpperCase() : 'S',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${user.name}!',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${user.department} - ${user.studentId}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Today\'s Date:',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormatter.formatFullDate(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Upcoming Classes
          const Text(
            'Upcoming Classes',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 8),
          _buildUpcomingClasses(),
          const SizedBox(height: 20),

          // Quick Access
          const Text(
            'Quick Access',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 8),
          _buildQuickAccessGrid(),
          const SizedBox(height: 20),

          // Upcoming Exams
          const Text(
            'Upcoming Exams',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 8),
          _buildUpcomingExams(),
          const SizedBox(height: 20),

          // Announcements
          const Text(
            'Announcements',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 8),
          _buildAnnouncements(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildUpcomingClasses() {
    // Dummy data for upcoming classes
    final List<Map<String, dynamic>> upcomingClasses = [
      {
        'subject': 'Database Systems',
        'time': '10:00 AM - 11:30 AM',
        'room': 'Room 301',
        'professor': 'Dr. Smith'
      },
      {
        'subject': 'Software Engineering',
        'time': '1:00 PM - 2:30 PM',
        'room': 'Room 405',
        'professor': 'Prof. Johnson'
      },
      {
        'subject': 'Computer Networks',
        'time': '3:00 PM - 4:30 PM',
        'room': 'Lab 202',
        'professor': 'Dr. Williams'
      },
    ];

    return Column(
      children: upcomingClasses.map((classInfo) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColorLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.class_,
                color: AppColors.primaryColor,
                size: 30,
              ),
            ),
            title: Text(
              classInfo['subject'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      classInfo['time'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.room,
                      size: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      classInfo['room'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      classInfo['professor'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              // Navigate to class details
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickAccessGrid() {
    final List<Map<String, dynamic>> quickAccessItems = [
      {'title': 'Attendance', 'icon': Icons.check_circle, 'index': 3},
      {'title': 'Timetable', 'icon': Icons.schedule, 'index': 1},
      {'title': 'Exams', 'icon': Icons.event_note, 'index': 4},
      {'title': 'Fee Payment', 'icon': Icons.payment, 'index': 5},
      {'title': 'Study Materials', 'icon': Icons.book, 'index': 2},
      {'title': 'Hostel Menu', 'icon': Icons.restaurant_menu, 'index': 6},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: quickAccessItems.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // Navigate to the respective section
            final int navIndex = quickAccessItems[index]['index'];
            Provider.of<DashboardScreen>(context, listen: false)._onItemTapped(navIndex);
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  quickAccessItems[index]['icon'],
                  size: 32,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 8),
                Text(
                  quickAccessItems[index]['title'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUpcomingExams() {
    // Dummy data for upcoming exams
    final List<Map<String, dynamic>> upcomingExams = [
      {
        'subject': 'Database Systems',
        'date': 'May 10, 2025',
        'time': '10:00 AM - 1:00 PM',
        'venue': 'Exam Hall 3'
      },
      {
        'subject': 'Software Engineering',
        'date': 'May 15, 2025',
        'time': '2:00 PM - 5:00 PM',
        'venue': 'Exam Hall 1'
      },
    ];

    return Column(
      children: upcomingExams.map((examInfo) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.warningColorLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.assignment,
                color: AppColors.warningColor,
                size: 30,
              ),
            ),
            title: Text(
              examInfo['subject'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      examInfo['date'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      examInfo['time'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.room,
                      size: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      examInfo['venue'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              // Navigate to exam details
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnnouncements() {
    // Dummy data for announcements
    final List<Map<String, dynamic>> announcements = [
      {
        'title': 'Campus Maintenance Notice',
        'body': 'The main library will be closed this weekend due to maintenance work.',
        'date': 'April 23, 2025',
        'sender': 'Campus Administration'
      },
      {
        'title': 'Technical Symposium 2025',
        'body': 'Register for the annual technical symposium before April 30th to avail early bird discounts.',
        'date': 'April 20, 2025',
        'sender': 'Student Council'
      },
    ];

    return Column(
      children: announcements.map((announcement) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.announcement,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        announcement['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  announcement['body'],
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      announcement['sender'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      announcement['date'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}