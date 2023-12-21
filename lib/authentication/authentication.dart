import 'package:firebase_auth/firebase_auth.dart';
import '../database/database.dart';
import 'package:flutter/foundation.dart';

class Authentication extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final Database _db = Database();


  bool loggedin = false;

  Authentication() {
    init();
  }

  init() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        loggedin = true;
      } else {
        debugPrint("User not logged in");
      }
      notifyListeners();
    });
  }

  Future sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then(
          (_) => debugPrint("Trying to send email link"),
        );
  }

  Future<String> login(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (credential) {
          if (credential.user != null) {
            loggedin = true;
            notifyListeners();
            _db.addUser(credential.user!.uid);
            return "Logged In";
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return '';
  }

  Future signout() async {
    await _auth.signOut();
    loggedin = false;
    notifyListeners();
  }

  Future createAccount(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((credential) {
        if (credential.user != null) {
          loggedin = true;
          notifyListeners();
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
