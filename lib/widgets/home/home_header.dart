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
      tooltip: 'show logout',
      constraints: const BoxConstraints(),
      onSelected: (value) {
        switch (value) {
          case 0:
          //TODO: logout 함수 구현하기.
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        const PopupMenuItem(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 28,
          value: 0,
          child: ListTile(
            trailing: Icon(
              Icons.logout_rounded,
              size: 18,
            ),
            leading: Text(
              "로그아웃",
            ),
          ),
        )
      ],
    );
  }
}
