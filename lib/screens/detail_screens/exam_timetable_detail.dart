import 'package:flutter/material.dart';

class ExamTimetableDetail extends StatefulWidget {
  const ExamTimetableDetail({Key? key}) : super(key: key);

  @override
  State<ExamTimetableDetail> createState() => _ExamTimetableDetailState();
}

class _ExamTimetableDetailState extends State<ExamTimetableDetail> {
  final List<Map<String, dynamic>> _exams = [
    {
      'subject': 'Database Management',
      'date': 'May 15, 2025',
      'time': '10:00 AM - 12:00 PM',
      'venue': 'Hall A',
      'syllabus': [
        'Relational Database Design',
        'SQL Queries',
        'Normalization Forms',
        'Transaction Management',
        'Concurrency Control'
      ],
      'isNext': true,
      'color': Colors.red.shade100,
    },
    {
      'subject': 'Data Structures',
      'date': 'May 20, 2025',
      'time': '02:00 PM - 04:00 PM',
      'venue': 'Hall B',
      'syllabus': [
        'Arrays and Linked Lists',
        'Stacks and Queues',
        'Trees and Graphs',
        'Sorting Algorithms',
        'Searching Algorithms'
      ],
      'isNext': false,
      'color': Colors.orange.shade100,
    },
    {
      'subject': 'Operating Systems',
      'date': 'May 25, 2025',
      'time': '10:00 AM - 12:00 PM',
      'venue': 'Hall C',
      'syllabus': [
        'Process Management',
        'Memory Management',
        'File Systems',
        'I/O Systems',
        'Protection and Security'
      ],
      'isNext': false,
      'color': Colors.yellow.shade100,
    },
    {
      'subject': 'Computer Networks',
      'date': 'May 30, 2025',
      'time': '10:00 AM - 12:00 PM',
      'venue': 'Hall A',
      'syllabus': [
        'OSI Model',
        'TCP/IP Protocol Suite',
        'Routing Algorithms',
        'Network Security',
        'Wireless Networks'
      ],
      'isNext': false,
      'color': Colors.green.shade100,
    },
    {
      'subject': 'Software Engineering',
      'date': 'June 5, 2025',
      'time': '02:00 PM - 04:00 PM',
      'venue': 'Hall B',
      'syllabus': [
        'Software Development Life Cycle',
        'Requirements Engineering',
        'Software Design',
        'Testing Strategies',
        'Project Management'
      ],
      'isNext': false,
      'color': Colors.blue.shade100,
    },
    {
      'subject': 'Artificial Intelligence',
      'date': 'June 10, 2025',
      'time': '10:00 AM - 12:00 PM',
      'venue': 'Hall C',
      'syllabus': [
        'Search Algorithms',
        'Knowledge Representation',
        'Machine Learning',
        'Neural Networks',
        'Natural Language Processing'
      ],
      'isNext': false,
      'color': Colors.purple.shade100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Timetable'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'End Semester Exams',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your exams start on May 15, 2025',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _exams.length,
              itemBuilder: (context, index) {
                final exam = _exams[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: exam['isNext']
                        ? const BorderSide(
                      color: Colors.red,
                      width: 2,
                    )
                        : BorderSide.none,
                  ),
                  child: ExpansionTile(
                    backgroundColor: exam['color'] as Color,
                    collapsedBackgroundColor: exam['color'] as Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            exam['subject'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (exam['isNext'] as bool)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Next Exam',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              exam['date'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              exam['time'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              exam['venue'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Syllabus',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...List.generate(
                              (exam['syllabus'] as List).length,
                                  (i) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• '),
                                    Expanded(
                                      child: Text(
                                        (exam['syllabus'] as List)[i] as String,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.event_note),
                                  label: const Text('Notes'),
                                  onPressed: () {
                                    // Navigate to study materials
                                  },
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.alarm),
                                  label: const Text('Set Reminder'),
                                  onPressed: () {
                                    // Set reminder
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          // Show search
          showSearch(
            context: context,
            delegate: _ExamSearchDelegate(_exams),
          );
        },
      ),
    );
  }
}

class _ExamSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> exams;

  _ExamSearchDelegate(this.exams);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredExams = exams.where((exam) {
      return exam['subject'].toString().toLowerCase().contains(query.toLowerCase()) ||
          exam['date'].toString().toLowerCase().contains(query.toLowerCase()) ||
          exam['venue'].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildExamList(filteredExams);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Search for subjects, dates or venues',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    final filteredExams = exams.where((exam) {
      return exam['subject'].toString().toLowerCase().contains(query.toLowerCase()) ||
          exam['date'].toString().toLowerCase().contains(query.toLowerCase()) ||
          exam['venue'].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildExamList(filteredExams);
  }

  Widget _buildExamList(List<Map<String, dynamic>> exams) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        final exam = exams[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            tileColor: exam['color'] as Color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              exam['subject'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      exam['date'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      exam['time'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      exam['venue'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              // Show exam details
              close(context, exam['subject'] as String);
            },
          ),
        );
      },
    );
  }
}