import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

class PollTile extends StatefulWidget {
  final ChatRoomViewModel chatVm;
  final int messageIndex;
  final Function(int optionId) onVote;
  final Widget? leading;
  final bool isUser;

  const PollTile({
    Key? key,
    required this.messageIndex,
    required this.isUser,
    required this.chatVm,
    required this.onVote,
    this.leading,
  }) : super(key: key);

  @override
  State<PollTile> createState() => _PollTileState();
}

class _PollTileState extends State<PollTile> {
  int? selectedOptionId;

  @override
  Widget build(BuildContext context) {
    // print(widget.message.poll!.pollOptions);

    // int? lastPollSelected = widget.message.poll!.lastVoted;
    print("PollTile Rebuilt State");
    return Consumer<ChatRoomViewModel>(
      builder: (context, chatVm, child) {
        List<MessageModel> messages = chatVm.messages;
        MessageModel message = messages[widget.messageIndex];
        if (message.poll!.lastVoted != null) {
          print("Last Volted is ${message.poll!.lastVoted}");
          selectedOptionId = message.poll!.lastVoted;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: widget.isUser
                  ? const Color(0xff68a5ca)
                  : const Color(0xff0C72B0),
              borderRadius: widget.isUser
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.leading != null) ...[
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: widget.leading),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message!.poll!.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      if (message.poll!.description.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          message.poll!.description,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      ...message.poll!.pollOptions.map((option) {
                        bool isSelected = (selectedOptionId == option.id);
                        int totalVotes = 1000;
                        final percentage = totalVotes > 0
                            ? (option.numVotes / totalVotes * 100)
                                .toStringAsFixed(1)
                            : '0.0';
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
                                      print("Ontap ");
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
                                      print("Ontap ");
                                      widget.onVote(option.id);

                                      setState(() {
                                        selectedOptionId = option.id;
                                      });
                                    },
                                    child: isSelected
                                        ? Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(option.value),
                                            ))
                                        : Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(option.value),
                                            )),
                                  ),
                                ),
                              ],
                            ),

                            // child: Stack(
                            //   children: [
                            //     if (selectedOptionId != null)
                            //       FractionallySizedBox(
                            //         // widthFactor: option.numVotes / totalVotes,
                            //         widthFactor: 3,
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(8),
                            //             color: textDarkBlue,
                            //           ),
                            //           height: 56,
                            //         ),
                            //       ),
                            //     Padding(
                            //       padding: const EdgeInsets.all(16.0),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Row(
                            //             children: [
                            //               Container(
                            //                 width: 24,
                            //                 height: 24,
                            //                 decoration: BoxDecoration(
                            //                   shape: BoxShape.circle,
                            //                   border: Border.all(
                            //                     color:
                            //                         selectedOptionId == option.id
                            //                             ? Colors.blue
                            //                             : Colors.grey,
                            //                   ),
                            //                 ),
                            //                 child: selectedOptionId == option.id
                            //                     ? const Center(
                            //                         child: Icon(
                            //                           Icons.check_circle,
                            //                           size: 22,
                            //                           color: Colors.blue,
                            //                         ),
                            //                       )
                            //                     : null,
                            //               ),
                            //               const SizedBox(width: 12),
                            //               Text(option.value),
                            //             ],
                            //           ),
                            //           if (selectedOptionId != null)
                            //             Text('$percentage%'),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
