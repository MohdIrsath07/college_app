import 'package:flutter/material.dart';

class ClassTimetableDetail extends StatefulWidget {
  const ClassTimetableDetail({Key? key}) : super(key: key);

  @override
  State<ClassTimetableDetail> createState() => _ClassTimetableDetailState();
}

class _ClassTimetableDetailState extends State<ClassTimetableDetail> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _days.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Timetable'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _days.map((day) => Tab(text: day)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _days.map((day) => _buildDaySchedule(day)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.calendar_today),
        onPressed: () {
          // Show calendar picker
          _showCalendarPicker();
        },
      ),
    );
  }

  Widget _buildDaySchedule(String day) {
    // Sample data - in a real app, this would come from your database or API
    final classes = _getClassesForDay(day);

    return classes.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No classes scheduled for $day',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    )
        : ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classInfo = classes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: classInfo['color'] as Color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        classInfo['subject'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${classInfo['startTime']} - ${classInfo['endTime']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 16,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      classInfo['professor'] as String,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      classInfo['location'] as String,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                if (classInfo.containsKey('notes'))
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.note,
                            size: 16,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              classInfo['notes'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
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
        );
      },
    );
  }

  List<Map<String, dynamic>> _getClassesForDay(String day) {
    // Sample data - in a real app, this would come from your database
    switch (day) {
      case 'Monday':
        return [
          {
            'subject': 'Data Structures',
            'professor': 'Prof. Johnson',
            'startTime': '10:00 AM',
            'endTime': '11:30 AM',
            'location': 'Room 203',
            'color': Colors.blue.shade100,
          },
          {
            'subject': 'Database Management',
            'professor': 'Prof. Smith',
            'startTime': '12:00 PM',
            'endTime': '01:30 PM',
            'location': 'Lab 302',
            'color': Colors.green.shade100,
            'notes': 'Bring your laptops. Assignment submission deadline today.',
          },
          {
            'subject': 'Software Engineering',
            'professor': 'Prof. Davis',
            'startTime': '02:00 PM',
            'endTime': '03:30 PM',
            'location': 'Room 205',
            'color': Colors.orange.shade100,
          },
        ];
      case 'Tuesday':
        return [
          {
            'subject': 'Computer Networks',
            'professor': 'Prof. Wilson',
            'startTime': '09:00 AM',
            'endTime': '10:30 AM',
            'location': 'Lab 104',
            'color': Colors.purple.shade100,
          },
          {
            'subject': 'Artificial Intelligence',
            'professor': 'Prof. Thompson',
            'startTime': '11:00 AM',
            'endTime': '12:30 PM',
            'location': 'Room 302',
            'color': Colors.red.shade100,
          },
        ];
      case 'Wednesday':
        return [
          {
            'subject': 'Data Structures',
            'professor': 'Prof. Johnson',
            'startTime': '10:00 AM',
            'endTime': '11:30 AM',
            'location': 'Room 203',
            'color': Colors.blue.shade100,
          },
          {
            'subject': 'Operating Systems',
            'professor': 'Prof. Garcia',
            'startTime': '01:00 PM',
            'endTime': '02:30 PM',
            'location': 'Lab 201',
            'color': Colors.teal.shade100,
            'notes': 'Lab session on process management',
          },
        ];
      case 'Thursday':
        return [
          {
            'subject': 'Computer Networks',
            'professor': 'Prof. Wilson',
            'startTime': '09:00 AM',
            'endTime': '10:30 AM',
            'location': 'Lab 104',
            'color': Colors.purple.shade100,
          },
          {
            'subject': 'Software Engineering',
            'professor': 'Prof. Davis',
            'startTime': '02:00 PM',
            'endTime': '03:30 PM',
            'location': 'Room 205',
            'color': Colors.orange.shade100,
          },
        ];
      case 'Friday':
        return [
          {
            'subject': 'Database Management',
            'professor': 'Prof. Smith',
            'startTime': '12:00 PM',
            'endTime': '01:30 PM',
            'location': 'Lab 302',
            'color': Colors.green.shade100,
          },
          {
            'subject': 'Operating Systems',
            'professor': 'Prof. Garcia',
            'startTime': '01:00 PM',
            'endTime': '02:30 PM',
            'location': 'Lab 201',
            'color': Colors.teal.shade100,
          },
        ];
      case 'Saturday':
        return [
          {
            'subject': 'Project Work',
            'professor': 'Prof. Thompson',
            'startTime': '10:00 AM',
            'endTime': '12:00 PM',
            'location': 'Lab 305',
            'color': Colors.amber.shade100,
            'notes': 'Group project discussion and progress review',
          },
        ];
      default:
        return [];
    }
  }

  void _showCalendarPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        // Handle date selection - in a real app, you might load the timetable for this date
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Timetable for ${selectedDate.toLocal().toString().split(' ')[0]}'),
          ),
        );
      }
    });
  }
}