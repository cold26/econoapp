import 'dart:developer';

import 'package:econoapp/common/constants/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;  
  final String? hintText;
  final String? labelText;
  final FormFieldValidator<String>? validator;  



      const PasswordFormField({
        super.key,
         required this.controller,
          this.padding, 
          this.hintText, 
          this.labelText,
          this.validator
          });


  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: widget.validator,
      obscureText: isHidden,
  controller: widget.controller,
  padding: widget.padding ,
  hintText: widget.hintText,
  labelText: widget.labelText,
  suffixIcon: InkWell(
    borderRadius:  BorderRadius.circular(23.0),
    onTap: () {
      log("pressed");
      setState(() {
        isHidden = !isHidden;
      });
    },
    child:  Icon(isHidden ? Icons.visibility : Icons.visibility_off,),
  ),
    );
  }
}