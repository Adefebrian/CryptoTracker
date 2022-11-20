import 'package:miniproject/view/constant/constant.dart';
import 'package:miniproject/viewmodels/auth_provider.dart';
import 'package:miniproject/view/home.dart';
import 'package:miniproject/view/screens/auth/signup_screen.dart';
import 'package:miniproject/view/widgets/button.dart';
import 'package:miniproject/view/widgets/custom_snackbar.dart';
import 'package:miniproject/view/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: Consumer<AuthProvider>(builder: (context, state, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Sultan Tracker",
                    style: titleStyleHeader.copyWith(color: primaryColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Stay up-to-date with daily live crypto prices, coin stats and market trends with Airdrop Sultan Tracker.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextfield(
                    readOnly: state.isLoading,
                    controller: _email,
                    hint: "Email",
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextfield(
                    readOnly: state.isLoading,
                    controller: _password,
                    hint: "Password",
                    //make the password field secure 
                
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Button(
                    isLoading: state.isLoading,
                    onTap: () async {
                      if (_email.text.isEmpty) {
                        customSnackbar(context, message: "Input your email");
                      } else if (_password.text.isEmpty) {
                        customSnackbar(context, message: "Input your password");
                      } else {
                        final response =
                            await state.login(_email.text, _password.text);
                        String message = response['message'];
                        if (response['success']) {
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const HomePage(),
                              ));
                        } else {
                          customSnackbar(context,
                              message: message, backgroundColor: Colors.red);
                        }
                      }
                    },
                    text: "Login",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SignupScreen(),
                            )),
                        child: const Text("Sign Up",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              );
            })),
      )),
    );
  }
}
