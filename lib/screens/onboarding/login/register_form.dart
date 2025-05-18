import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../screens/onboarding/login/view_models/register_auth_vm.dart';
import '../../../components/constants.dart';
import '../../../theme/color.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterAuthViewModel>(
      builder: (context, authVm, _) {
        _nameController.text = authVm.name;
        _emailController.text = authVm.email;
        _passwordController.text = authVm.password;
        _confirmController.text = authVm.confirmPass;

        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(color: greyText, fontSize: 15.0),
                  ),
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                    onChanged: (value) => authVm.setName(value),
                    onSaved: (value) => authVm.setName(value!),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    cursorColor: textColor,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      label: Text(
                        "Anakin Skywalker",
                        style: TextStyle(color: Color(0xffD9D9D9)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Email address",
                    style: TextStyle(color: greyText, fontSize: 15.0),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: _emailController,
                      style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                      onChanged: (value) => authVm.setEmail(value),
                      onSaved: (value) => authVm.setEmail(value!),
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
                    height: 15.0,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(color: greyText, fontSize: 15.0),
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                    controller: _passwordController,
                    obscureText: !authVm.passwordVisible,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => authVm.setPassword(value),
                    onSaved: (value) => authVm.setPassword(value!),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      } else if (value.length < 6) {
                        return "Password should be at least 6 characters in length";
                      } else if (value.length > 12) {
                        return "Password is too long";
                      } else if (!passwordReg.hasMatch(authVm.password)) {
                        return "Password should "
                            "\n  - be >6 & <12 characters in length"
                            "\n  - be a alphanumeric character";
                      }
                      return null;
                    },
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
                    height: 15.0,
                  ),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(color: greyText, fontSize: 15.0),
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                    textInputAction: TextInputAction.done,
                    controller: _confirmController,
                    obscureText: !authVm.passwordVisible,
                    onChanged: (value) => authVm.setConfirmPass(value),
                    onSaved: (value) => authVm.setConfirmPass(value!),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      } else if (value != authVm.password) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
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
                    height: 40.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await authVm.signUpApi(context);
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
                      "Sign-Up",
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
