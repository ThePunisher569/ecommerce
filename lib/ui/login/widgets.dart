import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// OTP TextField
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
      child: TextFormField(
        controller: otpCtrl,
        keyboardType: TextInputType.number,
        maxLength: 4,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.password),
          border: OutlineInputBorder(),
          counterText: '',
          hintText: 'Enter OTP : 1234',
        ),
      ),
    );
  }
}

/// Mobile number TextField
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
      child: TextFormField(
        controller: phoneCtrl,
        keyboardType: TextInputType.phone,
        autofocus: true,
        maxLength: 10,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.phone_android),
          border: OutlineInputBorder(),
          counterText: '',
          hintText: 'Enter mobile no : 0123456789',
        ),
        validator: (value) {
          if (value == null || value.isEmpty || value.length != 10) {
            return 'Enter a valid 10-digit mobile number';
          }
          return null;
        },
      ),
    );
  }
}

/// LOGO of the App
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
        Flexible(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 64,
            height: 80,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
          ),
        ),
        Flexible(
          flex: 4,
          child: RichText(
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
        ),
      ],
    );
  }
}
