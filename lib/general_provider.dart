import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// firebaseAuthのインスタンスを提供
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);