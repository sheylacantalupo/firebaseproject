import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


class MyHomePage extends StatefulWidget {
  
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();
  
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();

  login (){
    print("logar...");
    print(_emailController.text);
    print(_senhaController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height, // Altura da tela
            width: MediaQuery.of(context).size.width,  // Largura da tela
            decoration: const BoxDecoration(
              color: Colors.black, // Fundo preto do container
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  'lib/assets/images/theClinicLogoRemovebg.png',
                  height: 100, // Define a altura da imagem
                  width: 100, // Define a largura da imagem
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.75, // O container ocupará 75% da altura da tela
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60), // Arredonda apenas o canto superior esquerdo
                  ),
                  color: Color(0xFFFAFAFA), // Cor de fundo branca
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                        ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              decoration: BoxDecoration(
                                color: Colors.white, 
                                borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                              ),  
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Senha",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.start,
                            ),
                            CupertinoTextField(
                              controller: _senhaController,
                              placeholder: "Digite sua senha",
                              placeholderStyle: const TextStyle(
                                color: Colors.black54, // Cor ajustada para contraste
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.italic
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white, // Fundo do TextField
                                borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                              ),
                            ),
                          ],
                        ),                       
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: Colors.black87,
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14, 
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        onPressed:() {
          
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: (){

                      },
                      child: Text(
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
        ],
      ),   // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}