import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

class PollTile extends StatefulWidget {
  final ChatRoomViewModel chatVm;
  final MessageModel message;
  final Widget? leading;
  final bool isUser;
  final bool group;
  final Function(int optionId) onVote;

  const PollTile({
    required this.chatVm,
    required this.isUser,
    required this.onVote,
    required this.group,
    Key? key,
    required this.message,
    this.leading,
  }) : super(key: key);

  @override
  State<PollTile> createState() => _PollTileState();
}

class _PollTileState extends State<PollTile> {
  int? selectedOptionId;

  int _calculateTotalVotes(List<PollOption> options) {
    return options.fold(0, (sum, option) => sum + option.numVotes);
  }

  String _calculatePercentage(int optionVotes, int totalVotes) {
    if (totalVotes == 0) return '0.0';

    return ((optionVotes / totalVotes) * 100).abs().toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    MessageModel message = widget.message;
    if (message.poll!.pollOptions.isNotEmpty) {
      selectedOptionId =  message.poll!.pollOptions.where((element) => element.voterIds!.isNotEmpty).firstOrNull?.id; // ? message.poll!.lastVoted;
    }
    final width = MediaQuery.of(context).size.width;
    final totalVotes = _calculateTotalVotes(message.poll!.pollOptions);
    var isUser = widget.isUser;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width*0.12),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      color:
                          isUser ? const Color(0xff68a5ca) : const Color(0xff0C72B0),
                      borderRadius: isUser
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.poll!.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        if (message.poll!.description.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            message.poll!.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        ...message.poll!.pollOptions.map((option) {
                          bool isSelected = (selectedOptionId == option.id);
                          final percentage =
                              _calculatePercentage(option.numVotes, totalVotes);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 60,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        widget.onVote(option.id);
                                        setState(() {
                                          selectedOptionId = option.id;
                                        });
                                      },
                                      icon: Icon(
                                        isSelected
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: Colors.white,
                                      )),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        widget.onVote(option.id);
                                        setState(() {
                                          selectedOptionId = option.id;
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white30,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          if (selectedOptionId != null)
                                            FractionallySizedBox(
                                              widthFactor:
                                                  double.parse(percentage) / 100,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white60,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10))),
                                              ),
                                            ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(option.value),
                                                if (selectedOptionId != null)
                                                  Text(
                                                    '$percentage% (${option.numVotes})',
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                              ],
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
                        }).toList(),
                        if (selectedOptionId != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Total votes: $totalVotes',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8.0,
                  left: 0.0,
                  child: isUser || widget.group
                      ? CircleAvatar(
                    backgroundColor: const Color.fromARGB(15, 255, 255, 255),
                    radius: 25,
                    child: Padding(
                        padding: const EdgeInsets.all(20.0), child: Container()),
                  )
                      : File(message.sender!.dp.toString()).existsSync()
                      ? widget.chatVm.showProfileImage(
                      message.sender!.dp.toString(),
                      radius: 50.0)
                      : widget.chatVm
                      .customUserName(message.sender!.name.toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
