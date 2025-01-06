// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/chat/chat_screen/chat_view.dart';
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

  void onDelete(TextEditingController controller) {
    if (_controllers.length == 2) {
      Fluttertoast.showToast(msg: 'Minumum 2 Options Required');
      return;
    }
    setState(() {
      _controllers.remove(controller);
    });
  }

  String? validator(String? value) =>
      value!.trim().isEmpty ? 'This field cannot be empty' : null;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomViewModel>(
      builder: (context, chatVm, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: backgroundGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add a Poll",
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: greyText, fontSize: 13),
                        ),
                        Container(
                          constraints:
                              BoxConstraints.tight(const Size.square(20)),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 20,
                            onPressed: () => chatVm.isPollBeingCreated = false,
                            icon: const Icon(Icons.cancel_outlined),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black38)),
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        width: double.infinity,
                        child: Column(children: [
                          TextFormField(
                            controller: _titleController,
                            validator: (value) => validator(value),
                            decoration: InputDecoration(
                              hintText: "Title",
                            ),
                          ),

                          ..._controllers.map(
                            (controller) => PollOption(
                              validator: validator,
                              controller: controller,
                              onDelete: onDelete,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  flex: 9,
                                  child: IconButton(
                                      onPressed: () => setState(() {
                                            _controllers
                                                .add(TextEditingController());
                                          }),
                                      icon: Icon(Icons.add))),
                              Flexible(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                    if (kDebugMode) {
                                      print('inSendPoll');
                                    }
                                    chatVm.sendPoll(
                                        _titleController.text,
                                        _controllers
                                            .map(
                                              (TextEditingController
                                                      controller) =>
                                                  controller.text,
                                            )
                                            .toList(),
                                        'Test Description');
                                    chatVm.isPollBeingCreated = false;
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(child: Text('Send Poll')),
                                  ),
                                ),
                              ),
                            ],
                          )
                          // FormField(builder: builder)
                        ]))
                  ],
                ),
              )),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

class PollOption extends StatelessWidget {
  final TextEditingController controller;
  final Function(TextEditingController) onDelete;
  final Function(String?) validator;
  const PollOption(
      {super.key,
      required this.controller,
      required this.onDelete,
      required this.validator});

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
              decoration: InputDecoration(hintText: 'Option'),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              onDelete(controller);
            },
            icon: Icon(
              Icons.cancel,
              color: greyText,
            ))
      ],
    );
  }
}
