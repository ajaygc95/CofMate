import 'package:coffeemate/bloc/profile/profile_bloc.dart';
import 'package:coffeemate/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProfileInputField extends StatefulWidget {
  final String name;
  final GlobalKey<FormState> formKey;
  final TextInputType? keyboardType;
  final String? initialValue;

  const ProfileInputField({
    Key? key,
    required this.name,
    required this.formKey,
    this.keyboardType,
    this.initialValue,
  }) : super(key: key);

  @override
  _ProfileInputFieldState createState() => _ProfileInputFieldState();
}

class _ProfileInputFieldState extends State<ProfileInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.name,
        labelStyle: TextStyle(fontSize: 14),
        hintText: "Enter your ${widget.name}",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: widget.keyboardType == TextInputType.datetime
            ? IconButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    _controller.text =
                        DateFormat('MM/dd/yyyy').format(selectedDate);
                  }
                },
                icon: Icon(Icons.calendar_today),
              )
            : null,
      ),
      onChanged: (value) {
        if (widget.keyboardType == TextInputType.datetime) {
          BlocProvider.of<ProfileBloc>(context)
              .add(UpdateProfileEvent(label: "${widget.name}", value: value));
        } else {
          BlocProvider.of<ProfileBloc>(context)
              .add(UpdateProfileEvent(label: "${widget.name}", value: value));
        }
      },
      inputFormatters: widget.keyboardType == TextInputType.datetime
          ? [_DateInputFormatter(_controller)]
          : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.name} is required';
        }

        if (widget.keyboardType == TextInputType.datetime &&
            !isValidDate(value)) {
          return 'Please enter a valid date (MM/DD/YYYY)';
        }

        return null;
      },
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  final TextEditingController _controller;

  _DateInputFormatter(this._controller);

  static const int _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    String truncatedText =
        newText.substring(0, newText.length.clamp(0, _maxChars));
    String formattedText = _formatDate(truncatedText);

    _controller.value = _controller.value.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatDate(String date) {
    if (date.length < 3) {
      return date;
    } else if (date.length < 5) {
      return '${date.substring(0, 2)}/${date.substring(2)}';
    } else {
      return '${date.substring(0, 2)}/${date.substring(2, 4)}/${date.substring(4)}';
    }
  }
}

bool isValidDate(String date) {
  try {
    DateFormat('MM/dd/yyyy').parseStrict(date);
    return true;
  } catch (e) {
    return false;
  }
}
