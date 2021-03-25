import 'package:ELoja/models/user.dart';
import 'package:ELoja/validators/firebase_errors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  final Firestore firestore = Firestore.instance;

  bool get isLoggedIn => user != null;

  bool loading = false;
  Future<void> singIn({User user, Function onFail, Function onSucess}) async {
    setLoading(true);
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await _loadCurrentUser(firebaseUser: result.user);

      onSucess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      this.user = user;
      await user.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').document(currentUser.uid).get();
      user = User.fromDocument(docUser);

      final docAdmin =
          await firestore.collection('admins').document(user.id).get();
      if (docAdmin.exists) {
        user.admin = true;
      }

      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user.admin;
}
