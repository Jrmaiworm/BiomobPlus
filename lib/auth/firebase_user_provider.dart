import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BioPlusFirebaseUser {
  BioPlusFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

BioPlusFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BioPlusFirebaseUser> bioPlusFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<BioPlusFirebaseUser>(
        (user) => currentUser = BioPlusFirebaseUser(user));
