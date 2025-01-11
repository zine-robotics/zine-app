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

  int _calculateTotalVotes(List<PollOption> options) {
    return options.fold(0, (sum, option) => sum + option.numVotes);
  }

  String _calculatePercentage(int optionVotes, int totalVotes) {
    if (totalVotes == 0) return '0.0';
    return ((optionVotes / totalVotes) * 100).toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomViewModel>(
      builder: (context, chatVm, child) {
        List<MessageModel> messages = chatVm.messages;
        MessageModel message = messages[widget.messageIndex];
        if (message.poll!.lastVoted != null) {
          selectedOptionId = message.poll!.lastVoted;
        }

        final totalVotes = _calculateTotalVotes(message.poll!.pollOptions);

        var isUser = widget.isUser;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.2),
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isUser ? const Color(0xff68a5ca) : const Color(0xff0C72B0),
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
                        message.poll!.title,
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
                                        // Background white container
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white30,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        // Percentage overlay
                                        if (selectedOptionId != null)
                                          FractionallySizedBox(
                                            widthFactor:
                                                double.parse(percentage) / 100,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white60,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                            ),
                                          ),
                                        // Content
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                        ),
                      ],
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
