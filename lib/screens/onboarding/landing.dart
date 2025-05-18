import 'package:flutter/material.dart';

import '/components/gradient.dart';
import '../../common/routing.dart';
import 'login/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(gradient: mainGrad),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),

                  const Row(



                    children: [
                      //White Circle Size
                      CircleAvatar(
                        radius: 42.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          //Zine Logo Size
                          radius: 34.0,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/images/zine_logo.png'),
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Robotics\nand\nResearch\nGroup",
                        style: TextStyle(
                            fontFamily: 'Poppins-ExtraBold',
                            height: 0.9,
                            letterSpacing: 0.3,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      )
                    ],
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  const Text(
                    'DESIGN.\nCREATE.\nINNOVATE.\n',
                    style: TextStyle(
                      fontFamily: 'Poppins-Black',
                      height: 0.9,
                      letterSpacing: 0.3,
                      fontSize: 60.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.all(20.0)),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Color(0xff0c72b0),
                              fontFamily: "Poppins",
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).push(Routes.exploreScreen()),
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.all(20.0)),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Explore",
                          style: TextStyle(
                              color: Color(0xff0c72b0),
                              fontFamily: "Poppins",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
