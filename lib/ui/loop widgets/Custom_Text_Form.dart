import 'package:flutter/material.dart';

import '../../uitels/AppColors.dart';

class CustomTextForm extends StatelessWidget {
  Color colorBorderSide;
  Color? cursorColor;
  TextStyle? textStyle;
 Color colorHintStyle;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  int? maxlin;
  TextEditingController? controller;
 FormFieldValidator ? validator;
  bool obscureText;
   CustomTextForm({
     super.key,
     this.prefixIcon,
     this.suffixIcon,
     this.colorHintStyle=AppColors.greyColor,
     this.hintText,
     this.textStyle,
     this.cursorColor,
     this.colorBorderSide= AppColors.greyColor ,
     this.maxlin,
     this.controller,
     this.validator,
     this.obscureText = false
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller:  controller,
      style: textStyle,
       maxLines: maxlin ,
       decoration: InputDecoration(
         suffixIcon: suffixIcon,
         prefixIcon:prefixIcon ,
         hintText:hintText ,
         hintStyle: TextStyle(
           color: colorHintStyle
         ),
         enabledBorder: builtOutLineInputBorder(colorBorderSide: colorBorderSide ),
         focusedBorder:builtOutLineInputBorder(colorBorderSide: colorBorderSide ) ,
         errorBorder: builtOutLineInputBorder(colorBorderSide: Colors.red),
         focusedErrorBorder: builtOutLineInputBorder(colorBorderSide: Colors.red)
       ),
      cursorColor:cursorColor ,
    );
  }
  OutlineInputBorder builtOutLineInputBorder({required Color colorBorderSide}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: colorBorderSide,
        width: 2
      )
    );
  }
}
