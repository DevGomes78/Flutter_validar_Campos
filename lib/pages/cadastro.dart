import 'package:flutter/material.dart';
import 'package:flutter_validation/constants/string_constants/string_constants.dart';
import 'package:flutter_validation/widgets/button_widget.dart';
import 'package:flutter_validation/widgets/my_custon_clipper_widget.dart';
import 'package:flutter_validation/widgets/text_form_widget.dart';
import 'package:flutter_validation/widgets/text_widget.dart';
import '../controller/validate_fields.dart';
import '../routes/routes.dart';
import '../service/register_service.dart';

class Cadastro extends StatefulWidget {
  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();

  TextEditingController senhaController = TextEditingController();

  TextEditingController nomeController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _CustonClipper(),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _mountAreaNome(),
                    const SizedBox(height: 10),
                    _mountAreaEmail(),
                    const SizedBox(height: 10),
                    _MountAreaPassword(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesPage.loginPage);
                },
                child: Textwidget(
                  cadastro: StringConstants.MountAreaRegisterLogin,
                  login: StringConstants.MountAreaLoginName,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    SingUpService().singUp(
                      context,
                      nomeController.text,
                      emailController.text,
                      senhaController.text,
                    );
                  }
                  nomeController.clear();
                  emailController.clear();
                  senhaController.clear();
                },
                child: ButtonWidget(
                  text: StringConstants.MountAreaRegister,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _MountAreaPassword() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
      ),
      child: TextFormWidget(
        StringConstants.MountAreaLogin,
        StringConstants.MountAreaDigiteLogin,
        const Icon(
          Icons.vpn_key,
          color: Colors.green,
        ),
        sulfixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        controller: senhaController,
        obscureText: _obscureText,
        validator: Validate().validateSenha,
      ),
    );
  }

  _mountAreaEmail() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
      ),
      child: TextFormWidget(
        StringConstants.MountAreaEmail,
        StringConstants.MountAreaDigiteEmail,
        const Icon(
          Icons.email,
          color: Colors.green,
        ),
        controller: emailController,
        obscureText: false,
        validator: Validate().validateEmail,
      ),
    );
  }

  _mountAreaNome() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
      ),
      child: TextFormWidget(
        StringConstants.MountAreaName,
        StringConstants.MountAreaRegisterName,
        const Icon(
          Icons.person_add,
          color: Colors.green,
        ),
        controller: nomeController,
        obscureText: false,
        validator: Validate().validateNome,
      ),
    );
  }

  _CustonClipper() {
    return ClipPath(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(90),
          ),
          gradient: LinearGradient(
              colors: [(Colors.green), (Colors.black)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        height: 180,
      ),
      clipper: MycustonClipper(),
    );
  }
}
