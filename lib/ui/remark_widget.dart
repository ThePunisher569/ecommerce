import 'package:flutter/material.dart';

import '../product_api/local_api.dart';
import '../utils/constants.dart';

class RemarkWidget extends StatefulWidget {
  final int storeId;

  const RemarkWidget({super.key, required this.storeId});

  @override
  State<RemarkWidget> createState() => _RemarkWidgetState();
}

class _RemarkWidgetState extends State<RemarkWidget> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 24,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            autofocus: true,
            controller: _textEditingController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.feedback),
              border: OutlineInputBorder(),
              hintText: 'Enter Remark',
            ),
          ),
          const SizedBox(height: 16.0),
          FilledButton(
            onPressed: () async {
              String inputText = _textEditingController.text;

              if (inputText.isNotEmpty) {
                await LocalApi().saveRemark(inputText);

                if (!context.mounted) return;
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context)
                    .showSnackBar(Constants.getSnackBar('Remark Added!'));
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
