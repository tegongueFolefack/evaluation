import 'package:flutter/material.dart';
import '../Utils/constantes.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    required String placeholder,
    required TextEditingController controller,
    EdgeInsets padding = const EdgeInsets.only(left: 40) ,
    super.key,
  })  : _hintText = placeholder,
        _padding = padding,
        _controller = controller;

  final String _hintText;
  final EdgeInsets _padding;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: const ShapeDecoration(
        color: AppColor.logoBg,
        shape: StadiumBorder(),
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _hintText,
          hintStyle: const TextStyle(
            color: AppColor.inputBg,
          ),
          contentPadding: _padding,
        ),
        style:  const TextStyle(
          color: AppColor.secondaryText,
        ),
      ),
    );
  }
}
