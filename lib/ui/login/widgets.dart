import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    super.key,
    required this.passCtrl,
  });

  final TextEditingController passCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: passCtrl,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.password),
          border: OutlineInputBorder(),
          hintText: 'Enter password : admin',
        ),
      ),
    );
  }
}

class NameInputField extends StatelessWidget {
  const NameInputField({
    super.key,
    required this.nameCtrl,
  });

  final TextEditingController nameCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: nameCtrl,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.supervised_user_circle),
          border: OutlineInputBorder(),
          hintText: 'Enter username : admin',
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
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.indigo,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
