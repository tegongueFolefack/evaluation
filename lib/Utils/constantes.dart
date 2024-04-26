import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColor {
  static const inputBg = Color(0x8c0c6022);
  static const primaryColor = Color(0xff1144fc);
  static const secondaryColor = Color(0xff67fc11);
  static const primaryText = Color(0xff020202);
  static const secondaryText = Color(0xf010f1d7);
  static const logoBg = Color(0xb0ebacfb);


}

class Methode {

  static late Animation<double> _animation;
  static late Animation<double> _animation2;

  static Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail, TextEditingController controller, BuildContext context, TextInputType keyboardType) {
    double width = MediaQuery.of(context).size.width;
    bool isStrongPassword = false;
    
    return Container(
      height: width / 8,
      width: width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: width / 30),
      decoration: BoxDecoration(
        color: const Color(0xff212428),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white.withOpacity(.9)),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : keyboardType,
        inputFormatters: [
          isEmail ? FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]+')) :
              FilteringTextInputFormatter.singleLineFormatter
        ],
        decoration: InputDecoration(
          // errorText: isPassword ? (_isStrongPassword ? null : 'Le mot de passe doit contenir au moins 8 caractères avec des lettres, des chiffres et des caractères spéciaux.') : null,
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
        // onChanged: (value) {
        //   setState(() {
        //     _isStrongPassword = _isPasswordStrong(value);
        //   });
        // },
      ),
    );
  }

  static Widget blurTheStatusBar(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Container(
          height: w / 18,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
