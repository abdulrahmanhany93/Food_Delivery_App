import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.grey[200],
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
    );
  }
}
