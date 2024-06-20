import 'package:application/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';

class FireBaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool get isloggedIn => _auth.currentUser != null;
  Future<String?>? get idToken => _auth.currentUser?.getIdToken();

  FireBaseService() {
    _auth.authStateChanges().listen((event) {
      goRouter.refresh();
    });

    //Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      if (message != null) {
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print(message.data["click_action"]);
        }
      }
    });
    // background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message != null) {
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print(message.data["click_action"]);
        }
      }
    });
    // terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print(message.data["click_action"]);
        }
      }
    });
  }

  requestPermission() async {
    if (await Permission.notification.isDenied &&
        !await Permission.notification.isPermanentlyDenied) {
      await [Permission.notification].request();
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }

  static printError(String errCode) {
    switch (errCode) {
      case "user-not-found":
        return "가입된 이메일이 아닙니다.";
      case "wrong-password":
        return "비밀번호가 틀렸습니다.";
      case "invalid-email":
        return "이메일 형식이 맞지 않습니다.";
    }
  }

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
    } on FirebaseAuthException catch (e) {
      printError(e.code);
      return false;
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
      printError(e.code);
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
      printError(e.code);
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<String?> getFCMToken() async {
    await requestPermission();
    return FirebaseMessaging.instance.getToken();
  }
}
