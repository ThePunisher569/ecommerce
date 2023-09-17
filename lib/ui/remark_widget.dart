import 'package:flutter/material.dart';

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
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(labelText: 'Enter remark'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              String inputText = _textEditingController.text;
              print('Input Text: $inputText');
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}