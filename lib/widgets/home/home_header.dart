import 'package:application/main.dart';
import 'package:application/router.dart';
import 'package:application/services/api_service.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/delete_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      onSelected: (value) async {
        switch (value) {
          case 0:
            fbService.signOut();
          // case 1: // HACK: !!!
          //   var response = showDialog<DeleteConfirm>(
          //       context: context,
          //       builder: (context) =>
          //           DeleteConfirmDialog(guideText: '악보/연습장/연습기록이 전부 삭제됩니다.'));

          //   if (response == DeleteConfirm.ok) {
          //     database.resetDatabse().then(
          //         (value) => context.pushReplacement(RouterPath.home.name));
          //   }
          case 2: // HACK: API 테스트!!!
            var key = await ApiService.getParams('init-bound');
            print(key);
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
        ),
        // const PopupMenuItem(
        //   padding: EdgeInsets.symmetric(horizontal: 16),
        //   height: 28,
        //   value: 1,
        //   child: ListTile(
        //     trailing: Icon(
        //       Icons.delete_forever_rounded,
        //       size: 18,
        //     ),
        //     leading: Text(
        //       "초기화",
        //     ),
        //   ),
        // ),

        const PopupMenuItem(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 28,
          value: 2,
          child: ListTile(
            trailing: Icon(
              Icons.error,
              size: 18,
            ),
            leading: Text(
              "API TEST",
            ),
          ),
        ),
      ],
    );
  }
}
