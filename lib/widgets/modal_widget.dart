import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModalTextFieldWithLabel extends Row {
  ModalTextFieldWithLabel({
    super.key,
    required String label,
    double textFieldWidth = 225,
    String? initialValue,
    String? hintText,
    void Function(String)? onChanged,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
  }) : super(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyles.bodyMedium.copyWith(
                color: ColorStyles.onSurfaceBlackVariant,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: textFieldWidth,
              child: ModalTextField(
                initialValue: initialValue,
                onChanged: onChanged,
                onSaved: onSaved,
                validator: validator,
                hintText: hintText,
              ),
            ),
          ],
        );
}

class ModalTextField extends TextFormField {
  ModalTextField({
    super.key,
    void Function(String)? onChanged,
    void Function(String?)? onSaved,
    TextAlign textAlign = TextAlign.start,
    String? Function(String?)? validator,
    String? initialValue,
    String? hintText,
  }) : super(
          maxLines: 1,
          onChanged: onChanged,
          onSaved: onSaved,
          onFieldSubmitted: onSaved,
          validator: validator,
          initialValue: initialValue,
          style: TextStyles.bodyMedium.copyWith(
            letterSpacing: 0.25,
          ),
          textAlign: textAlign,
          autovalidateMode: AutovalidateMode.always,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(5),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorStyles.primary, width: 1),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC2C2C3), width: 1),
            ),
            hintText: hintText,
          ),
        );
}

class ModalHeader extends StatelessWidget {
  final String title, left, right;
  final void Function()? onComplete;
  const ModalHeader({
    super.key,
    this.left = "나가기",
    this.right = "완료",
    required this.title,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            left,
            style: TextStyles.bodyMedium,
          ),
        ),
        Text(
          title,
          style: TextStyles.bodyLarge,
        ),
        TextButton(
          onPressed: onComplete,
          child: Text(
            right,
            style: TextStyles.bodyMedium,
          ),
        )
      ],
    );
  }
}
