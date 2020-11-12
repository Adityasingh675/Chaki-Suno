import 'package:flutter/material.dart';

class GameButton{
  final id;
  String Text;
  Color bg;
  bool enabled;

  GameButton({this.id, this.Text = "",this.bg = Colors.grey,this.enabled = true});
}