import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/onboarding/reset_password/view_model/pass_reset_view_model.dart';
import '../../../theme/color.dart';

class PasswordResetConfirm extends StatelessWidget {
  const PasswordResetConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordResetVm>(
      builder: (context,passVm,_) {
        return Scaffold(
          backgroundColor: backgroundGrey,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/images/email.png",
                      height: 100.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "We will send you an email at",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: greyText,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      passVm.email!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: textDarkBlue,
                      ),
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    const Text(
                      "You can change your password through the link provided in the mail",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: greyText,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    padding:
                    WidgetStateProperty.all(const EdgeInsets.all(20.0)),
                    backgroundColor: WidgetStateProperty.all(textColor),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
