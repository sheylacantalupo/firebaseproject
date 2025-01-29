import 'package:firebaseproject/services/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key, required this.title});
  final String title;

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

   AuthService _authService = AuthService();


  /// Função para validar os campos manualmente
  bool _validateFields() {
    bool isValid = true;

    if (_nomeController.text.isEmpty) {
      isValid = false;
    }
    if (_emailController.text.isEmpty) {
      isValid = false;
    } else if (!EmailValidator.validate(_emailController.text)) {
      isValid = false;
    }
    if (_senhaController.text.isEmpty) {

      isValid = false;
    } else if (_senhaController.text.length < 6) {
      isValid = false;
    }

    return isValid;
  }

  /// Função para submeter o formulário apenas se os dados forem válidos
  void _submitForm() {
    if (_validateFields()) {
      print("E-mail: ${_emailController.text}");
      print("Senha: ${_senhaController.text}");
      print("Nome: ${_nomeController.text}");

      _authService.cadastrarUsurario(
        nome: _nomeController.text,
        senha: _senhaController.text,
        email: _emailController.text,
      );
    } else {
      print("Formulário inválido!");
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
                              CupertinoTextField(
                                controller: _nomeController,
                                placeholder: "Digite seu nome",
                                placeholderStyle: const TextStyle(
                                    color: Colors.black54, // Cor ajustada para contraste
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.italic
                                  ),
                                style: const TextStyle(
                                    color: Colors.black, // Cor do texto digitado
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.italic, 
                                  ),
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  return Visibility(
                                    visible: _nomeController.text.isEmpty,
                                    child: const Text(
                                      "Insira seu nome",
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  );
                                },
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
                              CupertinoTextField(
                                controller: _emailController,
                                placeholder: "Digite seu e-mail",
                                placeholderStyle: const TextStyle(
                                    color: Colors.black54, // Cor ajustada para contraste
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.italic
                                  ),
                                style: const TextStyle(
                                    color: Colors.black, // Cor do texto digitado
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.italic, 
                                  ),
                                keyboardType: TextInputType.emailAddress,
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Builder(
                                builder: (context) {
                                  return Visibility(
                                    visible: _emailController.text.isNotEmpty &&
                                        !EmailValidator.validate(_emailController.text),
                                    child: const Text(
                                      "E-mail inválido. Use um formato válido (exemplo@dominio.com)",
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  );
                                },
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
                              CupertinoTextField(
                                controller: _senhaController,
                                obscureText: true,
                                placeholder: "Digite sua senha",
                                placeholderStyle: const TextStyle(
                                    color: Colors.black54, // Cor ajustada para contraste
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                    fontStyle: FontStyle.italic
                                  ),
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Builder(
                                builder: (context) {
                                  return Visibility(
                                    visible: _senhaController.text.isNotEmpty &&
                                        _senhaController.text.length < 6,
                                    child: const Text(
                                      "A senha deve ter no mínimo 6 caracteres.",
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          color: Colors.black87,
                          onPressed: _submitForm,
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
                      // TextButton(
                      //   onPressed: () {
                      //     print("Ir para cadastro...");
                      //   },
                      //   child: const Text(
                      //     "Não possui uma conta? Cadastre-se",
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.normal,
                      //       fontFamily: 'Poppins',
                      //     ),
                      //   ),
                      // ),
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
