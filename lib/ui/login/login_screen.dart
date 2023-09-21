import 'package:ecommerce/ui/store/home.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameCtrl = TextEditingController();

  TextEditingController passCtrl = TextEditingController();

  void _login() {
    if (nameCtrl.text == 'admin' && passCtrl.text == 'admin') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Home(),
      ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(Constants.getSnackBar('Invalid Username or Password'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.04,
          vertical: MediaQuery.sizeOf(context).height * 0.04,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Logo(),
                Constants.gap32V,
                NameInputField(nameCtrl: nameCtrl),
                Constants.gap16V,
                PasswordInputField(passCtrl: passCtrl),
                Constants.gap32V,
                FilledButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                  ),
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
