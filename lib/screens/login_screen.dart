import 'package:application/main.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _DDMLogo(),
          Text(
            "당신의 드럼 연습을 도와드립니다.",
            textAlign: TextAlign.center,
            style: TextStyles.bodyLarge.copyWith(
              color: ColorStyles.graphMiss,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            "둥둥마스터",
            textAlign: TextAlign.center,
            style: TextStyles.headlineSmall.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.25,
                shadows: [
                  Shadow(
                    color: Colors.transparent.withOpacity(0.16),
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  )
                ]),
          ),
          const SizedBox(height: 40),
          Center(
            child: SizedBox(
              width: 280,
              child: TextButton(
                onPressed: fbService.signInWithGoogle,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6F1D),
                  foregroundColor: Colors.white,
                  textStyle: TextStyles.bodyLarge.copyWith(
                    letterSpacing: 1.25,
                  ),
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("로그인"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DDMLogo extends StatelessWidget {
  const _DDMLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 180,
      margin: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorStyles.primaryLight.withOpacity(0.8),
        boxShadow: [
          // 반지름 큰 순서부터 배치
          BoxShadow(
            color: Colors.transparent.withOpacity(0.04),
            blurRadius: 16,
            spreadRadius: 50,
            offset: const Offset(0, 4),
          ),
          const BoxShadow(
            // 가장 바깥 그림자 지우는 용도
            color: ColorStyles.background,
            blurRadius: 0,
            blurStyle: BlurStyle.solid,
            spreadRadius: 50,
          ),
          BoxShadow(
            color: ColorStyles.primaryLight.withOpacity(0.2),
            blurRadius: 0,
            blurStyle: BlurStyle.solid,
            spreadRadius: 50,
          ),
          BoxShadow(
            color: Colors.transparent.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
