import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/newTask.dart';
import 'package:zineapp2023/models/task_instance.dart';

import 'package:zineapp2023/models/userTask.dart';

import 'package:zineapp2023/screens/tasks/view_models/task_vm.dart';
import 'package:zineapp2023/utilities/date_time.dart';

import '../../utilities/string_formatters.dart';

class RecentTask extends StatelessWidget {
  RecentTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskVm>(builder: (context, taskVm, _) {
      UserTaskInstance? latest = taskVm.findLatest();
      if (kDebugMode) {
        if (latest == null) {
          print('Latest is null');
        } else {
          print('Latest task is ${latest.title}');
        }
      }

      return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        color: const Color(0xFF268CCB),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),

              Text(
                latest != null ? latest.task.title.toString() : "Testtt",
                style: const TextStyle(
                  fontFamily: "Poppins-ExtraBold",
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const InkWell(
                // onTap: () => const ProblemStantement(
                //   blogName: Text("Mechanical Engineering"),
                // ),
                child: Text("Problem Statement",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400)),
              ),

              Spacer(
                flex: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    color: Colors.white,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 38.0, vertical: 12.0),
                      child: Text(
                        latest != null
                            //FIXME: GET STATUS
                            ? truncateStatus(latest.status.toString())
                            : "Status Pending",
                        // 'In progress',
                        style: const TextStyle(
                          color: Color(0xFF268CCB),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    latest != null
                        ? "${DateFormat(DateFormat.MONTH_DAY).format(latest.task.dueDate!)}\n${DateFormat.y().format(latest.task.dueDate!)}"
                        : "",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Spacer(),
              //Text(latest !=null ? latest!.checkpoints.toString() :" ")
            ],
          ),
        ),
      );
    });
  }
}
