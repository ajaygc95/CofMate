import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorMessageSection extends StatelessWidget {
  const ErrorMessageSection({
    Key? key,
    required String? errorMessage,
  })  : _errorMessage = errorMessage,
        super(key: key);

  final String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(5),
        color: Colors.red.withOpacity(0.1),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Center(
        child: Text(
          _errorMessage!,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
