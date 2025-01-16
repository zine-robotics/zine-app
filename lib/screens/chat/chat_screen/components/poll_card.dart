import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      _addControllerListener(controller);
    }
  }

  void _addControllerListener(TextEditingController controller) {
    controller.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleControllerChange();
      });
    });
  }

  void _handleControllerChange() {
    if (!mounted) return;

    setState(() {
      final controllersToRemove = <int>[];

      for (int i = _controllers.length - 2; i >= 0; i--) {
        if (_controllers[i].text.isEmpty &&
            _controllers[i + 1].text.isNotEmpty &&
            _controllers.length > 2) {
          controllersToRemove.add(i);
        }
      }

      for (var index in controllersToRemove.reversed) {
        _controllers[index].removeListener(_handleControllerChange);
        _controllers.removeAt(index);
      }

      if (_controllers.isNotEmpty && _controllers.last.text.isNotEmpty) {
        var newController = TextEditingController();
        _addControllerListener(newController);
        _controllers.add(newController);
      }
    });
  }

  bool _validatePoll() {
    if (_titleController.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter a title for the poll",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    final nonEmptyOptions = _controllers
        .where((controller) => controller.text.trim().isNotEmpty)
        .toList();

    if (nonEmptyOptions.length < 2) {
      Fluttertoast.showToast(
        msg: "Please add at least 2 options",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
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
        child: Form(
          key: _formKey,
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
                validator: validator,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Description",
                textAlign: TextAlign.left,
                style: TextStyle(color: greyText, fontSize: 13),
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
              const SizedBox(height: 15),
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
                    validator: validator,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if (_validatePoll()) {
                      final nonEmptyControllers = _controllers
                          .where(
                              (controller) => controller.text.trim().isNotEmpty)
                          .map((controller) => controller.text)
                          .toList();

                      chatVm.sendPoll(
                        _titleController.text,
                        nonEmptyControllers,
                        _descController.text,
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: blurBlue,
                    ),
                    child: const Icon(Icons.send),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PollOption extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) validator;

  const PollOption({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) => validator(value),
        controller: controller,
        decoration: const InputDecoration(hintText: '+ Add'),
      ),
    );
  }
}