import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../store/home.dart';
import 'widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneCtrl = TextEditingController();

  TextEditingController otpCtrl = TextEditingController();

  void _login() {
    if (phoneCtrl.text.toLowerCase() == '0123456789' &&
        otpCtrl.text.toLowerCase() == '1234') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Home(),
      ));
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                PhoneInputField(phoneCtrl: phoneCtrl),
                Constants.gap16V,
                OTPInputField(otpCtrl: otpCtrl),
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
