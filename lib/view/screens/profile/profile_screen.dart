import 'package:miniproject/view/constant/constant.dart';
import 'package:miniproject/viewmodels/auth_provider.dart';
import 'package:miniproject/view/screens/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: titleStyleHeader,
        ),
    ),
    body: Builder(builder: (context) {
        return Consumer<AuthProvider>(builder: (context, state, _) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 110,
                  child: Image.asset("assets/avatar.png"),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  state.account.name ?? "",
                  style: titleStyleText,
                ),
                Text(state.account.email ?? ""),
                const SizedBox(
                  height: 12,
                ),
//create button for logout and change password
                
                ElevatedButton(
                  //make the button full width 
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 0, 112, 240),
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                  ),
                  onPressed: () async {
                    await state.logout(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text("Logout"),
                ),
              ],
            ),
          );
        });
      }),
    );
  }
}
