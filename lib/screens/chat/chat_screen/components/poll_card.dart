import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/theme/color.dart';

class PollCard extends StatefulWidget {
  const PollCard({super.key});

  @override
  State<PollCard> createState() => _PollCardState();
}

class _PollCardState extends State<PollCard> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController()
  ];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add listeners to initial controllers
    for (var controller in _controllers) {
      _addControllerListener(controller);
    }
  }

  void _addControllerListener(TextEditingController controller) {
    controller.addListener(() {
      // Use post-frame callback to safely modify controllers
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleControllerChange();
      });
    });
  }

  void _handleControllerChange() {
    if (!mounted) return;

    setState(() {
      // Create a list of controllers to remove
      final controllersToRemove = <int>[];

      // Check for empty controllers between filled ones
      for (int i = _controllers.length - 2; i >= 0; i--) {
        if (_controllers[i].text.isEmpty &&
            _controllers[i + 1].text.isNotEmpty &&
            _controllers.length > 2) {
          controllersToRemove.add(i);
        }
      }

      // Remove controllers safely
      for (var index in controllersToRemove.reversed) {
        _controllers[index].removeListener(_handleControllerChange);
        _controllers.removeAt(index);
      }

      // Add new controller if last one is filled
      if (_controllers.isNotEmpty && _controllers.last.text.isNotEmpty) {
        var newController = TextEditingController();
        _addControllerListener(newController);
        _controllers.add(newController);
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  String? validator(String? value) =>
      value!.trim().isEmpty ? 'This field cannot be empty' : null;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomViewModel>(
        builder: (context, chatVm, child) => Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Question",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: greyText, fontSize: 13),
                    ),
                    TextFormField(
                      controller: _titleController,
                      validator: (value) => validator(value),
                      decoration: const InputDecoration(
                        hintText: "Title",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Description",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: greyText, fontSize: 13),
                    ),
                    TextFormField(
                      controller: _descController,
                      validator: (value) => validator(value),
                      decoration: const InputDecoration(
                        hintText: "Description",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Options",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: greyText, fontSize: 13),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _controllers.length,
                        itemBuilder: (context, index) => PollOption(
                            controller: _controllers[index],
                            validator: validator),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              if (kDebugMode) {
                                print('inSendPoll');
                              }
                              // Filter out empty controllers when sending
                              final nonEmptyControllers = _controllers
                                  .where((controller) =>
                                      controller.text.trim().isNotEmpty)
                                  .map((controller) => controller.text)
                                  .toList();

                              chatVm.sendPoll(_titleController.text,
                                  nonEmptyControllers, _descController.text);

                              Navigator.of(context).pop();
                            },
                            child: const SizedBox(
                              height: 50,
                              child: Center(child: Text('Send Poll')),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            ));
  }
}

class PollOption extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) validator;
  const PollOption(
      {super.key, required this.controller, required this.validator});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) => validator(value),
              controller: controller,
              decoration: const InputDecoration(hintText: '+ Add'),
            ),
          ),
        ),
      ],
    );
  }
}
