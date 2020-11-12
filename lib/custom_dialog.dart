import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDialog({@required this.title, @required this.callback, @required this.content, this.actionText});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          FlatButton(
            color: Colors.white,
            onPressed: callback,
            child: Text(actionText),
          ),
        ],
      ),
    );
  }
}
