import 'package:application/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool get isloggedIn => _auth.currentUser != null;
  Future<String?>? get idToken => _auth.currentUser?.getIdToken();

  FireBaseService() {
    _auth.authStateChanges().listen((event) {
      goRouter.refresh();
    });
  }

  Future<void> signInWithGoogle() async {
  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication authentication =
            await account.authentication;
        OAuthCredential googleCredential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken,
        );
        await _auth.signInWithCredential(googleCredential);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String?> singInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "가입된 이메일이 아닙니다.";
        case "wrong-password":
          return "비밀번호가 틀렸습니다.";
        case "invalid-email":
          return "이메일 형식이 맞지 않습니다.";
      }
    }
    return null;
  }

  Future<String?> createUserWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "이미 가입된 이메일 입니다.";
        case "invalid-email":
          return "이메일 형식이 맞지 않습니다.";
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
