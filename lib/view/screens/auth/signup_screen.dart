import 'package:miniproject/models/account.dart';
import 'package:miniproject/view/constant/constant.dart';
import 'package:miniproject/viewmodels/auth_provider.dart';
import 'package:miniproject/view/home.dart';
import 'package:miniproject/view/widgets/button.dart';
import 'package:miniproject/view/widgets/custom_snackbar.dart';
import 'package:miniproject/view/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  height: 50,
                ),
                Text(
                  "Create a new account",
                  style: titleStyleHeader.copyWith(color: primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Create an account so you tracking your favorite crypto assets",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextfield(
                  readOnly: state.isLoading,
                  controller: _name,
                  hint: "Name",
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
                ),
                const SizedBox(
                  height: 50,
                ),
                Button(
                  isLoading: state.isLoading,
                  onTap: () async {
                    if (_name.text.isEmpty) {
                      customSnackbar(context, message: "Input name");
                    } else if (_email.text.isEmpty) {
                      customSnackbar(context, message: "Input email");
                    } else if (_password.text.isEmpty) {
                      customSnackbar(context, message: "Input password");
                    } else {
                      await state.createAccount(Account(
                          name: _name.text,
                          email: _email.text,
                          password: _password.text));
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    }
                  },
                  text: "Create Account",
                ),
              ],
            );
          }),
        ),
      )),
    );
  }
}
