import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubits.dart';
import '../utils/text_formatter/text_formatter.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final bool isHideText;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final Function? onEditingComplete;
  final Function(String)? onFieldSubmitted;

  const CustomTextField({Key? key, this.controller, this.label, this.isHideText = false, this.validator, this.focusNode, this.onEditingComplete, this.onFieldSubmitted,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context
        .read<ThemeCubit>()
        .getColors;
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isHideText,
      style: const TextStyle(color: Colors.white),
      // textInputAction: TextInputAction.next,
      cursorColor: colors.labelColor,
      validator: validator,
      onEditingComplete: () => onEditingComplete?.call(),
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: [
        FirstSpaceFormatter(),
      ],
      decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: colors.textFieldBackground,
          label: label != null ? Text(label ?? '') : null,
          labelStyle: TextStyle(color: colors.labelColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorMaxLines: 3,
          errorStyle: Theme
              .of(context)
              .textTheme
              .caption
              ?.copyWith(
            color: Colors.redAccent,
          )
      ),
    );
  }
}
