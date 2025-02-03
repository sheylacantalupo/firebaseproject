import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> singUp({
    required String nome,
    required String senha,
    required String email,
  }) async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: senha
      );
      await userCredential.user!.updateDisplayName(nome);

      return userCredential;

    } on FirebaseAuthException catch (e) {
      print("Erro ao realizar cadastro: ${e.message}");
      return null; // Retorna null se houver erro
    }
    
  }

  Future<UserCredential?> loginUser({
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return userCredential; // Retorna o UserCredential em caso de sucesso
    } on FirebaseAuthException catch (e) {
      // Captura os códigos de erro e retorna null + mensagem amigável
      switch (e.code) {
        case 'user-not-found':
          throw Exception("Usuário não encontrado.");
        case 'wrong-password':
          throw Exception("Senha incorreta.");
        case 'invalid-email':
          throw Exception("E-mail inválido.");
        case 'user-disabled':
          throw Exception("Esta conta foi desativada.");
        default:
          throw Exception("Erro ao realizar login: ${e.message}");
      }
    } catch (e) {
      throw Exception("Erro inesperado: ${e.toString()}");
    }
  }
}