import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmate/repository/network_repository.dart';
import 'package:workmate/utils/logger.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<UserCredential?> login({
    required String email,
    required String password,
  });

  Future<bool> singOut();

  Future<bool> isLogin();

  Future<UserCredential?> registerAccount(
      {required String username,
      required String email,
      required String password});
  // Future<void> deleteUser(String uid);
}

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.networkRepository});

  final NetworkRepository networkRepository;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> isLogin() async {
    return true;
  }

  @override
  Future<UserCredential?> login(
      {required String email, required String password}) async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<UserCredential?> registerAccount(
      {required String username,
      required String email,
      required String password}) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    return userCredential;
  }

  @override
  Future<bool> singOut() async {
    return true;
  }

  // @override
  // Future<void> deleteUser(String uid) async {
  //   try {
  //     User? user = firebaseAuth.currentUser;
  //     if (user != null && user.uid == uid) {
  //       await user.delete();
  //     } else {
  //       User? userToDelete = await firebaseAuth.getUser(uid);
  //       if (userToDelete != null) {
  //         await userToDelete.delete();
  //       }
  //     }
  //   } catch (e) {
  //     logger.e('Error deleting user: $e');
  //     rethrow;
  //   }
  // }
}
