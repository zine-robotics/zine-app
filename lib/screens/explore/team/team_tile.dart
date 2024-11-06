import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';

import '../../../theme/color.dart';

class TeamTile extends StatefulWidget {
  final String year;
  final String name;
  final String id;
  final String image;
  final String bio;
  final String linkedin;
  final String branch;

  const TeamTile(
      {super.key,
      required this.year,
      required this.image,
      required this.name,
      required this.id,
      required this.bio,
      required this.linkedin,
      required this.branch});

  @override
  State<TeamTile> createState() => _TeamTileState();
}

class _TeamTileState extends State<TeamTile> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    double availableHeight = MediaQuery.of(context).size.height -
        (kBottomNavigationBarHeight + kToolbarHeight);

    const duration = Duration(milliseconds: 500);
    return Consumer<DashboardVm>(builder: (context, dashboardVm, _) {
      return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedContainer(
                height: 100,
                duration: Duration(milliseconds: 500),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      // height: 700,
                      fit: BoxFit.cover,
                      'assets/images/${widget.year}/${widget.image}.webp',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 18.0,
                        color: textDarkBlue,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    widget.branch,
                    style: const TextStyle(
                        fontSize: 12,
                        color: textColor,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
            // Column()
          ],
        ),
      );
    });
  }
}
