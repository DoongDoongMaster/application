import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String label;
  const HomeHeader({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const _ProfileButton()
        ],
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.account_circle_rounded,
        size: 36,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      position: PopupMenuPosition.under,
      tooltip: 'show logout',
      surfaceTintColor: Colors.transparent,
      constraints: const BoxConstraints(),
      onSelected: (value) {
        switch (value) {
          case 0:
          //TODO: logout 함수 구현하기.
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
          padding: EdgeInsets.zero,
          height: 28,
          value: 0,
          child: ListTile(
            visualDensity: const VisualDensity(vertical: -3),
            dense: true,
            trailing: const Icon(
              Icons.logout_rounded,
              size: 18,
              color: Colors.black,
            ),
            contentPadding: const EdgeInsets.only(left: 16, right: 16),
            minLeadingWidth: 200,
            leading: Text(
              "로그아웃",
              style: TextStyles.bodyMedium.copyWith(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
