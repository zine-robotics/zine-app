import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/events/view_models/events_vm.dart';

import '/components/gradient.dart';
import '/screens/onboarding/splash/viewModel/splashVm.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var splashVm = Provider.of<SplashVM>(context, listen: false);
    Timer(const Duration(seconds: 4), () {
      splashVm.isLogged(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: mainGrad),
        child: const Center(
          child: CircleAvatar(
            radius: 75.0,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/splash.gif"),
          ),
        ),
      ),
    );
  }
}
