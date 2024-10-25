import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/common/routing.dart';
import 'package:zineapp2023/models/task_instance.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/screens/tasks/view_models/task_vm.dart';

// import '/screens/tasks/problem_statement.dart';
import '../../theme/color.dart';
import '../../utilities/string_formatters.dart';

class TaskCard extends StatelessWidget {
  final UserTaskInstance curr;
  // final UserTask curr;
  final int index;

  const TaskCard({super.key, required this.curr, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskVm>(
      builder: (context, taskVm, _) {
        return GestureDetector(
          onTap: () => {
            taskVm.curr = index,
            Navigator.of(context).push(Routes.taskDesc())
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 5,
            ),
            child:

            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              // color: iconTile,
              elevation: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      curr.task.title.toString(),
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Problem Statement",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                            SizedBox(
                              height: 35,
                              width: 160,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: iconTile.withOpacity(0.4), // Use your background color
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  buildProgressBar(
                                      curr.completionPercentage ?? 10, // Replace with your dynamic value
                                    Colors.green.withOpacity(0.2),
                                    iconTile,
                                  ),
                                      Positioned.fill(
                                                    child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                    truncateStatus(curr.status.toString()),
                                                    style: TextStyle(
                                                    color: textColor.withOpacity(0.9),
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w700),
                                                    ),))

                                ],
                              ),
                            ),

                        Text(
                          "${DateFormat(DateFormat.MONTH_DAY).format(curr.task.dueDate!)}\n${DateFormat.y().format(curr.task.dueDate!)}",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            height: 1.3,
                            color: blurBlue,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
Widget buildProgressBar(int percentage, Color fillColor, Color backgroundColor) {
  return Stack(
    children: [
      // Background container (empty part)
      Container(
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      // Foreground container (filled part)
      FractionallySizedBox(
        widthFactor: percentage / 100, // Percentage fill
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: fillColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    ],
  );
}
