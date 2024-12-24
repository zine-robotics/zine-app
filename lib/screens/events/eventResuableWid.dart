import "package:flutter/material.dart";

class eventContainer extends StatelessWidget {
  final String text1, text2;
  eventContainer({required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.lightBlueAccent;
    if (text1 == "TASK") {
      textColor = const Color.fromARGB(255, 12, 113, 176);
    } else if (text1 == "WORKSHOP") {
      textColor = Colors.lightBlueAccent;
    } else {
      textColor = Colors.grey;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Stack(
        children: [
          Container(
            child: Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Text(
                  "  $text1",
                  style: const TextStyle(
                      height: 0.9,
                      letterSpacing: 0.3,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 12, 113, 176)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 60,
            decoration: const BoxDecoration(
                color: Colors.white //Color.fromARGB(255, 12, 113, 176)
                ,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15), right: Radius.circular(15))),
          ),
          Container(
              width: 40,
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 12, 113, 176)
                  //Color.fromARGB(255, 12, 113, 176)
                  color: textColor,
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(15)))),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  Text(
                    text2,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        height: 1,
                        letterSpacing: 0.3,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 12, 113, 176)),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
