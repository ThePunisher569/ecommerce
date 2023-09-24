import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OTPInputField extends StatelessWidget {
  const OTPInputField({
    super.key,
    required this.otpCtrl,
  });

  final TextEditingController otpCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: otpCtrl,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.password),
          border: OutlineInputBorder(),
          hintText: 'Enter OTP : 1234',
        ),
      ),
    );
  }
}

class PhoneInputField extends StatelessWidget {
  const PhoneInputField({
    super.key,
    required this.phoneCtrl,
  });

  final TextEditingController phoneCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: phoneCtrl,
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone_android),
          suffixIcon: TextButton(
              onPressed: () {
                if (phoneCtrl.text.isEmpty) return;
                ScaffoldMessenger.of(context).showSnackBar(
                    Constants.getSnackBar('OTP sent successfully!'));
              },
              child: const Text('Get OTP')),
          border: const OutlineInputBorder(),
          hintText: 'Enter phone : 0123456789',
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          width: 64,
          height: 80,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '\t-\t',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: Colors.indigo),
              ),
              TextSpan(
                text: 'Commerce',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: Colors.indigo),
              )
            ],
          ),
        ),
      ],
    );
  }
}
