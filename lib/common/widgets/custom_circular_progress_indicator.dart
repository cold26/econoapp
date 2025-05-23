// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:econoapp/common/constants/app_colors.dart';
import 'package:flutter/material.dart';


class CustomCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomCircularProgressIndicator({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.iceWhite,
      ),
    );
  }
}