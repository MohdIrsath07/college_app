import 'package:flutter/material.dart';
import 'package:college_app/constants/app_colors.dart';
import 'package:college_app/constants/app_styles.dart';
import 'package:college_app/models/class_timetable_model.dart';

class TimetableCard extends StatelessWidget {
  final ClassSession session;
  final bool isCurrentClass;
  final VoidCallback? onTap;

  const TimetableCard({
    Key? key,
    required this.session,
    this.isCurrentClass = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isCurrentClass
              ? Border.all(color: AppColors.primaryColor, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 56,
                decoration: BoxDecoration(
                  color: isCurrentClass
                      ? AppColors.primaryColor
                      : _getSubjectColor(session.subjectCode),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            session.subjectName,
                            style: AppStyles.heading3,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isCurrentClass
                                ? AppColors.primaryColor.withOpacity(0.1)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            session.subjectCode,
                            style: AppStyles.caption.copyWith(
                              color: isCurrentClass
                                  ? AppColors.primaryColor
                                  : AppColors.textSecondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Prof. ${session.teacherName}',
                            style: AppStyles.bodyText2,
                          ),
                        ),
                        Text(
                          '${session.startTime} - ${session.endTime}',
                          style: AppStyles.bodyText2.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isCurrentClass
                                ? AppColors.primaryColor
                                : AppColors.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Room ${session.roomNumber}',
                      style: AppStyles.caption.copyWith(
                        color: AppColors.textSecondaryColor,
                      ),
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

  Color _getSubjectColor(String subjectCode) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];

    // Generate a consistent color based on the subject code
    final index = subjectCode.hashCode % colors.length;
    return colors[index.abs()];
  }
}