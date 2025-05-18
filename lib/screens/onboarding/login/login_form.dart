import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../screens/onboarding/login/view_models/login_auth_vm.dart';
import '../../../theme/color.dart';
import '../../../common/routing.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAuthViewModel>(
      builder: (context, authVm, _) {
        _emailController.text = authVm.email;
        _passwordController.text = authVm.password;

        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Email address",
                    style: TextStyle(color: greyText, fontSize: 18.0),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                      controller: _emailController,
                      onSaved: (value) {
                        authVm.setEmail(value!);
                      },
                      onChanged: (value) {
                        authVm.setEmail(value);
                      },
                      validator: authVm.validateEmail,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: textColor,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        label: Text(
                          "abc@iiitk/mnit.ac.in",
                          style: TextStyle(color: Color(0xffD9D9D9)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(color: greyText, fontSize: 18.0),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                    onChanged: (value) => authVm.setPassword(value),
                    onSaved: (value) => authVm.setPassword(value!),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      } else if (value.length < 6) {
                        return "Password is too short";
                      } else if (value.length > 12) {
                        return "Password is too long";
                      }
                      return null;
                    },
                    obscureText: !authVm.passwordVisible,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      label: const Text(
                        "•••••",
                        style: TextStyle(color: Color(0xffD9D9D9)),
                      ),
                      suffixIcon: IconButton(
                        icon: ImageIcon(
                          const AssetImage('assets/icons/eye.png'),
                          color:
                              !authVm.passwordVisible ? greyText : Colors.black,
                        ),
                        onPressed: authVm.toggleVisible,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(Routes.emailScreen());
                    },
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(
                    height: 45.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await authVm.loginApi(context);
                      }
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
                      "Login",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
