import 'package:econoapp/common/constants/app_colors.dart';
import 'package:econoapp/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? obscureText;
  final FormFieldValidator<String>? validator; 

  const CustomTextFormField({
    super.key,
    this.padding,
    this.hintText,
    this.labelText,
    this.textCapitalization, 
    this.controller, 
    this.keyboardType,
    this.suffixIcon, 
    this.obscureText,
     this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.greenTwo),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: TextFormField(
        validator: widget.validator,
        obscureText: widget.obscureText ?? false,
        textInputAction: TextInputAction.done,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        textCapitalization:
          widget.textCapitalization ?? TextCapitalization.none,
          decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText ?? "Digite seu texto aqui",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.labelText?.toUpperCase(),
          labelStyle: AppTextStyles.inputLabelText.copyWith(
            color: AppColors.grey,
          ),
          hintStyle: AppTextStyles.inputLabelText.copyWith(
            color: AppColors.grey, // Cor suave para hintText
          ),
          border: defaultBorder,
          focusedBorder: defaultBorder,
          errorBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(color: Colors.red),
          ),
          enabledBorder: defaultBorder,
          disabledBorder: defaultBorder,
        ),
      ),
    );
  }
}