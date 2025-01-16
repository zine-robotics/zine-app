import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

import '../../../../providers/user_info.dart';

// User Messages (Right side)
const Color userColor =
    Color.fromARGB(255, 104, 181, 228); // Medium-light blue background
const Color userSelectedColor =
    Color.fromARGB(255, 10, 107, 167); // Your brand blue
const Color userUnselectedColor =
    Color.fromARGB(100, 10, 107, 167); // Medium-bright blue
const Color userBaseProgressBarColor = Color.fromRGBO(12, 114, 176, 0.2);
const Color userSelectedTextColor =
    Color.fromARGB(255, 0, 0, 0); // White text for selected
const Color userUnselectedTextColor =
    Color.fromARGB(119, 10, 107, 167); // Dark blue text for unselected

// Other Messages (Left side)
const Color otherColor = Color(0xff0c72b0); // Your brand blue
const Color otherSelectedColor = Color(0xffE8F2FC); // Very light blue
const Color otherUnselectedColor =
    Color.fromARGB(155, 130, 183, 218); // Light-medium blue
const Color otherBaseProgressBarColor = Color.fromRGBO(0, 61, 99, 0.2);
const Color otherSelectedTextColor = Color(0xffE8F2FC); // Dark blue text
const Color otherUnselectedTextColor =
    Color.fromARGB(155, 130, 183, 218); // White text

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
    return ((optionVotes / totalVotes) * 100).toStringAsFixed(1);
  }

  Color getColor(bool isUser, bool isSelected) {
    if (isUser) {
      if (isSelected) {
        return userSelectedColor;
      } else {
        return userUnselectedColor;
      }
    } else {
      if (isSelected) {
        return otherSelectedColor;
      } else {
        return otherUnselectedColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MessageModel message = widget.message;
    if (message.poll!.pollOptions.isNotEmpty) {
      selectedOptionId = message.poll!.pollOptions
          .where((element) =>
              element.voterIds!.contains(widget.chatVm.userProv.getUserInfo.id))
          .firstOrNull
          ?.id;
    }
    final totalVotes = _calculateTotalVotes(message.poll!.pollOptions);

    return Padding(
      padding: widget.isUser
          ? const EdgeInsets.only(top: 10, left: 50)
          : const EdgeInsets.only(top: 10, right: 50), // Added padding
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: widget.isUser ? userColor : otherColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.poll!.title,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.0,
                  color: widget.isUser
                      ? const Color.fromARGB(255, 5, 76, 120)
                      : otherSelectedTextColor),
            ),
            const SizedBox(height: 8),
            if (message.poll!.description.isNotEmpty)
              Text(
                message.poll!.description,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: widget.isUser
                      ? userSelectedColor
                      : const Color.fromARGB(209, 232, 242, 252),
                ),
              ),
            const SizedBox(height: 16),
            Column(
              children: message.poll!.pollOptions.map((option) {
                final percentage =
                    _calculatePercentage(option.numVotes, totalVotes);
                bool isSelected = (selectedOptionId == option.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: InkWell(
                    onTap: () {
                      widget.onVote(option.id);
                      setState(() {
                        selectedOptionId = option.id;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: getColor(widget.isUser, isSelected),
                            width: 8, // Thicker left border
                          ),
                          top: BorderSide(
                            color: getColor(widget.isUser, isSelected),
                            width: isSelected ? 3 : 1,
                          ),
                          right: BorderSide(
                            color: getColor(widget.isUser, isSelected),
                            width: isSelected ? 3 : 1,
                          ),
                          bottom: BorderSide(
                            color: getColor(widget.isUser, isSelected),
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Poll Option Value
                          Text(
                            option.value,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: widget.isUser
                                    ? (isSelected
                                        ? userSelectedTextColor
                                        : userUnselectedTextColor)
                                    : (isSelected
                                        ? otherSelectedTextColor
                                        : otherUnselectedTextColor),
                                fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          // Progress Bar
                          Stack(
                            children: [
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: widget.isUser
                                      ? userBaseProgressBarColor
                                      : otherBaseProgressBarColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: double.parse(percentage) / 100,
                                child: Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: getColor(widget.isUser, isSelected),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          // Votes & Percentage
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${option.numVotes} votes',
                                  style: TextStyle(
                                    color: getColor(widget.isUser, isSelected),
                                    fontSize: 10,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            // Total Votes
            Text(
              'Total votes: $totalVotes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
