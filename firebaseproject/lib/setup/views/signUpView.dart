import 'package:firebaseproject/services/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, required this.title});
  final String title;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

   final AuthService _authService = AuthService();


  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!EmailValidator.validate(value)) {
      return 'Digite um email válido';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
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

      final email = _emailController.text;
      final nome = _nomeController.text;
      final senha = _senhaController.text;

      try {
        // colocar o retorno de future no state
        await _authService.singUp(
          nome: nome,
          senha: senha,
          email: email,
        );

        // Exibir mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cadastro realizado com sucesso!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );        
        _emailController.clear();
        _senhaController.clear();
        _nomeController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao cadastrar: ${e.toString()}"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false; 
        });
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
                      Column(
                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Cadastro",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Nome",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              TextFormField(
                                controller: _nomeController,
                                validator: _validateName,
                                enabled: !_isLoading,
                                decoration: InputDecoration(
                                  hintText: "Digite seu nome",
                                  hintStyle: const TextStyle(
                                    color: Colors.black54, // Cor ajustada para contraste
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.italic,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none, // Remove a borda padrão
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.black, // Cor do texto digitado
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.italic, 
                                ),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.text,
                                //padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              ),
                              const SizedBox(height: 20),
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
                            "Cadastrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
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
