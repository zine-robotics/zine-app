import 'package:flutter/material.dart';

import '../../components/gradient.dart';
import '../../theme/color.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundGrey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          title: const Text(
            "Recruitment",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: mainGrad //need to replace with made component
                ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/explore/workshops.png",
              height: 120,),
              const Text(
                "Coming Soon . . . .",
                style: TextStyle(
                    fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: greyText
                ),
              )
            ],
          ),
        ));
  }
}
