import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/services/authService.dart';
import 'package:firebaseproject/setup/views/signUpView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.title});
  final String title;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

   final AuthService _authService = AuthService();


  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!EmailValidator.validate(value)) {
      return 'Digite um email válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    } else if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  bool _isLoading = false; 
  bool _isObscure = true;

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text.trim();
      final senha = _senhaController.text.trim();

      try {
        UserCredential? userCredential = await _authService.loginUser(
          email: email,
          senha: senha,
        );

        setState(() {
          _isLoading = false;
        });

        if (userCredential != null) {
          // Login bem-sucedido
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login realizado com sucesso!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
          _emailController.clear();
          _senhaController.clear();

          // Exemplo: acessar informações do usuário
          print("Usuário logado: ${userCredential.user?.email}");
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Exibe erro retornado pelo `AuthService`
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll("Exception: ", "")),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  'lib/assets/images/theClinicLogoRemovebg.png',
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.75,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                  color: Color(0xFFFAFAFA),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                            "Entrar",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                          ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "E-mail",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              TextFormField(
                                controller: _emailController,   
                                validator: _validateEmail, 
                                enabled: !_isLoading,                           
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Digite seu e-mail",
                                  hintStyle: const TextStyle(
                                    color: Colors.black54, // Cor ajustada para contraste
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.italic,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white, // Fundo branco
                                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Padding igual ao CupertinoTextField
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), // Arredondamento igual ao CupertinoTextField
                                    borderSide: BorderSide.none, // Remove a borda padrão para manter o visual limpo
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.black, // Cor do texto digitado
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.italic, 
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Senha",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              TextFormField(
                                controller: _senhaController,
                                validator: _validatePassword,
                                enabled: !_isLoading,
                                obscureText: _isObscure, // Oculta o texto da senha
                                decoration: InputDecoration(
                                  hintText: "Digite sua senha",
                                  hintStyle: const TextStyle(
                                    color: Colors.black54, // Cor ajustada para contraste
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.italic,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white, // Fundo branco
                                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Padding igual ao CupertinoTextField
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), // Arredondamento igual ao CupertinoTextField
                                    borderSide: BorderSide.none, // Remove a borda padrão para manter o visual limpo
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure ? Icons.visibility_off : Icons.visibility, // Alterna ícone
                                      color: Colors.black54,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure; // Alterna entre senha visível/oculta
                                      });
                                    },
                                  ), 
                                ),
                                style: const TextStyle(
                                  color: Colors.black, // Cor do texto digitado
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.italic, 
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      _isLoading 
                        ? const CircularProgressIndicator() 
                        : SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          color: Colors.black87,
                          onPressed: _onSubmit,
                          child: const Text(
                            "Entrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpView(title: 'Cadastro')),
                          );
                        },
                        child: const Text(
                          "Não possui uma conta? Cadastre-se",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
