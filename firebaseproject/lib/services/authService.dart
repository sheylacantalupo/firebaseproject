import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  cadastrarUsurario({
    required String nome,
    required String senha,
    required String email,
  }) async{
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: senha
    );

    await userCredential.user!.updateDisplayName(nome);

  }
}