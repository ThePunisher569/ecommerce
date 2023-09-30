import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../store/home.dart';
import 'widgets.dart';

/// Login screen
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
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.sizeOf(context).height * 0.14),
        child: const Padding(
          padding: EdgeInsets.only(top: 32.0),
          child: Logo(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 48,
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32,bottom: 32),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Login with Mobile Number',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Constants.gap32V,
                PhoneInputField(phoneCtrl: phoneCtrl),
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
