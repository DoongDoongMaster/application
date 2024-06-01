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
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
