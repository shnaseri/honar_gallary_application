import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../state_managment/otp/otp_cubit.dart';
import 'otp_code_component.dart';

class TextFieldEachCode extends StatefulWidget {
  TextEditingController controller;
  int index;
  Function completeFunction;

  TextFieldEachCode(
      {Key? key,
      required this.controller,
      required this.index,
      required this.completeFunction})
      : super(key: key);

  @override
  State<TextFieldEachCode> createState() => _TextFieldEachCodeState();
}

class _TextFieldEachCodeState extends State<TextFieldEachCode> {
  int lastIndexOfTextField = 3;
  int startIndexOfTextField = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextFormField(
        controller: widget.controller,
        autofocus: widget.index == 0,
        enabled: otpState is! OtpLoadingCodeState,
        validator: (value) {
          if (otpState is OtpBadCode) {
            return "";
          }
          return null;
        },
        onChanged: (String value) {
          onChangeCodeAndChangeFocus(value, context);
        },
        textAlign: TextAlign.center,
        cursorColor: Colors.black,
        maxLength: 1,
        style: TextStyle(color: Colors.black),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          counterText: "",
          errorStyle: const TextStyle(height: 0),
          // errorText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xff828282), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xff828282), width: 1)),
        ),
      ),
    );
  }

  void onChangeCodeAndChangeFocus(String value, BuildContext context) {
    if (value.isNotEmpty) {
      if (widget.index != lastIndexOfTextField) {
        FocusScope.of(context).nextFocus();
      }
    } else {
      if (widget.index != startIndexOfTextField) {
        FocusScope.of(context).previousFocus();
      }
    }

    widget.completeFunction();
  }
}
