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

  final GlobalKey<FormState> _formKey = GlobalKey();

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (phoneCtrl.text.toLowerCase() == '0123456789' &&
          otpCtrl.text.toLowerCase() == '1234') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Home(),
        ));

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(Constants.getSnackBar('Logged In Successfully!'));
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(Constants.getSnackBar(
            'Type phone number = 0123456789 and OTP = 1234'));
      }
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
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: MediaQuery.sizeOf(context).height * 0.14,
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Form(
          key: _formKey,
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
    );
  }
}
