import 'package:flutter/material.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/theme/color.dart';

class PollTile extends StatefulWidget {
  final MessageModel message;
  final Function(int optionId)? onVote;
  final Widget? leading;
  final bool isUser;

  const PollTile({
    Key? key,
    required this.isUser,
    required this.message,
    this.onVote,
    this.leading,
  }) : super(key: key);

  @override
  State<PollTile> createState() => _PollTileState();
}

class _PollTileState extends State<PollTile> {
  int? selectedOptionId;
  // int get totalVotes => widget.message.poll!.pollOptions.fold(
  //       0,
  //       (sum, option) => sum + option.numVotes,
  //     );

  int totalVotes = 1000;

  @override
  Widget build(BuildContext context) {
    print(widget.message.poll!.pollOptions);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:
            widget.isUser ? const Color(0xff68a5ca) : const Color(0xff0C72B0),
        borderRadius: BorderRadius.circular(12),
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
                  widget.message.poll!.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                if (widget.message.poll!.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    widget.message.poll!.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                ],
                const SizedBox(height: 16),
                ...widget.message.poll!.pollOptions.map((option) {
                  final percentage = totalVotes > 0
                      ? (option.numVotes / totalVotes * 100).toStringAsFixed(1)
                      : '0.0';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: InkWell(
                      onTap: () {
                        if (selectedOptionId == null) {
                          setState(() {
                            selectedOptionId = option.id;
                          });
                          widget.onVote?.call(option.id);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: widget.isUser
                              ? BorderRadius.only()
                              : BorderRadius.only(),
                          color: Colors.white.withOpacity(0.9),
                        ),
                        child: Stack(
                          children: [
                            if (selectedOptionId != null)
                              FractionallySizedBox(
                                // widthFactor: option.numVotes / totalVotes,
                                widthFactor: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: textDarkBlue,
                                  ),
                                  height: 56,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: selectedOptionId == option.id
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                        child: selectedOptionId == option.id
                                            ? const Center(
                                                child: Icon(
                                                  Icons.check_circle,
                                                  size: 22,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(option.value),
                                    ],
                                  ),
                                  if (selectedOptionId != null)
                                    Text('$percentage%'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
