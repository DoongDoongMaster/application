import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum DeleteConfirm {
  ok,
  cancel,
}

class DeleteConfirmDialog extends CustomDialog {
  final String drillId;
  DeleteConfirmDialog({
    super.key,
    required this.drillId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: 180,
      width: 540,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "정말 삭제하시겠습니까?",
            style: TextStyles.titleMedium.copyWith(
              color: ColorStyles.onSurfaceBlack,
            ),
          ),
          const Divider(height: 0),
          Text(
            "구간을 삭제하면 레포트 기록도 함께 삭제되며 복구할 수 없습니다.",
            maxLines: 2,
            style: TextStyles.bodyMedium.copyWith(
              color: ColorStyles.onSurfaceBlackVariant,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ConfrimButton(
                text: "취소",
                onPressed: () =>
                    context.pop<DeleteConfirm>(DeleteConfirm.cancel),
                foregroundColor: ColorStyles.onSurfaceBlackVariant,
                backgroundColor: const Color(0xFFEAEAEA),
              ),
              const SizedBox(width: 25),
              _ConfrimButton(
                text: "삭제",
                onPressed: () => context.pop<DeleteConfirm>(DeleteConfirm.ok),
                foregroundColor: Colors.white,
                backgroundColor: ColorStyles.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConfrimButton extends TextButton {
  _ConfrimButton({
    required String text,
    super.onPressed,
    required Color foregroundColor,
    required Color backgroundColor,
  }) : super(
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            fixedSize: const Size.fromWidth(120),
          ),
          child: Text(text),
        );
}
