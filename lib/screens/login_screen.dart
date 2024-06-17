import 'package:application/globals.dart';
import 'package:application/main.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/custom_dialog.dart';
import 'package:application/widgets/modal_widget.dart';
import 'package:application/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AuthMode {
  signIn(text: "로그인", helpText: "계정이 없으신가요?"),
  signUp(text: "회원가입", helpText: "계정이 있으신가요?");

  const AuthMode({required this.text, required this.helpText});

  final String text, helpText;
  AuthMode get reverse =>
      this == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn;
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          _AuthButton(
            onPressed: () {
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (BuildContext dialogContext) {
                  return AuthModal(
                      context: dialogContext, mode: AuthMode.signIn);
                },
              );
            },
            backgroundColor: const Color(0xFFFF6F1D),
            foregroundColor: Colors.white,
            child: Text(AuthMode.signIn.text),
          ),
          const SizedBox(height: 5),
          _AuthButton(
            onPressed: () {
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (BuildContext dialogContext) {
                  return AuthModal(
                      context: dialogContext, mode: AuthMode.signUp);
                },
              );
            },
            backgroundColor: ColorStyles.gray,
            foregroundColor: ColorStyles.primary,
            child: Text(AuthMode.signUp.text),
          ),
        ],
      ),
    );
  }
}

class AuthModal extends StatefulWidget {
  final AuthMode mode;
  final BuildContext context;
  const AuthModal({
    super.key,
    required this.mode,
    required this.context,
  });

  @override
  State<AuthModal> createState() => AuthModalState();
}

class AuthModalState extends State<AuthModal> {
  late AuthMode mode;
  bool isLoading = false;
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();
  bool get isReadyToSubmit =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      (_formKey.currentState?.validate() ?? false);

  @override
  void initState() {
    super.initState();
    mode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ModalHeader(
            title: '둥둥마스터에 ${mode.text}',
            left: '취소',
            right: '',
          ),
          const Divider(height: 0),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                LoginInputField(
                  label: "이메일",
                  onChanged: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                  validator: (v) {
                    const pattern =
                        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                    final regex = RegExp(pattern);
                    if (v != null && v.isNotEmpty) {
                      if (!regex.hasMatch(v)) {
                        return "이메일 형식이 맞지 않습니다.";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                LoginInputField(
                  label: "비밀번호",
                  onChanged: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                  validator: (v) {
                    if (v != null && v.isNotEmpty) {
                      if (v.length < 6) {
                        return "비밀번호가 너무 짧습니다.";
                      }
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          _AuthButton(
            onPressed: isReadyToSubmit
                ? () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    String? msg;
                    switch (mode) {
                      case AuthMode.signIn:
                        msg = await fbService.singInWithEmail(email, password);
                        break;
                      case AuthMode.signUp:
                        msg = await fbService.createUserWithEmail(
                            email, password);
                    }
                    if (msg != null) {
                      showGlobalSnackbar(msg);
                    } else {
                      if (context.mounted) {
                        context.goNamed(RouterPath.home.name);
                      }
                    }
                  }
                : null,
            backgroundColor: isReadyToSubmit
                ? const Color(0xFFFF6F1D)
                : ColorStyles.lightGray,
            foregroundColor: Colors.white,
            child: Text(mode.text),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mode.helpText),
              TextButton(
                onPressed: () {
                  setState(() {
                    mode = mode.reverse;
                  });
                },
                child: Text(mode.reverse.text),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(height: 0),
          ),
          const SizedBox(height: 20),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            _AuthButton(
              foregroundColor: ColorStyles.secondary,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await fbService.signInWithGoogle();
                if (context.mounted) {
                  context.goNamed(RouterPath.home.name);
                }
              },
              drawBorder: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      'assets/images/google-icon.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Text("Google로 ${mode.text}"),
                ],
              ),
            ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

class LoginInputField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String label;
  const LoginInputField({
    super.key,
    required this.label,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: TextFormField(
        maxLines: 1,
        onChanged: onChanged,
        keyboardType: TextInputType.emailAddress,
        validator: validator,
        decoration: InputDecoration(
          hintText: label,
          isDense: true,
          contentPadding: const EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorStyles.secondary.withOpacity(0.4),
              strokeAlign: -1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorStyles.primary,
              strokeAlign: -1,
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final Color? foregroundColor, backgroundColor;
  final bool drawBorder;
  const _AuthButton({
    this.onPressed,
    required this.child,
    this.foregroundColor,
    this.backgroundColor,
    this.drawBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            textStyle: TextStyles.bodyLarge.copyWith(
              letterSpacing: drawBorder ? 0 : 1.25,
              fontWeight: drawBorder ? FontWeight.w600 : FontWeight.normal,
            ),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: drawBorder
                ? const BorderSide(
                    color: ColorStyles.graphMiss, strokeAlign: -1, width: 1)
                : null,
          ),
          child: child,
        ),
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
