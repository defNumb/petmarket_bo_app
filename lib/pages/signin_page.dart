import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../blocs/signin/signin_cubit.dart';
import '../constants/app_constants.dart';
import '../utils/error_dialog.dart';
import 'signup_page.dart';

class SigninPage extends StatefulWidget {
  static const String routeName = '/signin';
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String? _email, _password;
  FocusNode myFocusNode = new FocusNode();

  void _submit() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    form.save();
    context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.signinStatus == SigninStatus.error) {
              errorDialog(context, state.error);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: primaryColor,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                      key: _formKey,
                      autovalidateMode: _autoValidateMode,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Image.asset(
                            'assets/images/petmarketlogo.png',
                            width: 250,
                            height: 250,
                          ),
                          SizedBox(height: 20.0),

                          // Correo Electrónico
                          TextFormField(
                            focusNode: myFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              labelText: 'Correo',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Por favor ingrese su correo';
                              }
                              if (!isEmail(value.trim())) {
                                return 'Por favor ingrese un correo válido';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _email = value;
                            },
                          ),
                          SizedBox(height: 20.0),

                          // Contraseña
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.white70,
                              filled: true,
                              labelText: 'Contraseña',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Por favor ingrese su contraseña';
                              }
                              if (value.trim().length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _password = value;
                            },
                          ),
                          SizedBox(height: 20.0),
                          // Iniciar Sesión
                          InkWell(
                            onTap: state.signinStatus == SigninStatus.submitting ? null : _submit,
                            child: Column(
                              children: [
                                Ink.image(
                                  image: const AssetImage('assets/images/paw2.png'),
                                  height: 74,
                                  width: 72,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  state.signinStatus == SigninStatus.submitting
                                      ? 'Cargando...'
                                      : 'Iniciar Sesión',
                                  style: TextStyle(
                                    fontFamily: fontType,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: fontColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          //Nuevo Usuario? Registrate Ahora!
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'nuevo usuario?',
                                style: TextStyle(
                                  fontFamily: fontType,
                                  fontSize: 13,
                                  color: fontColor,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, SignupPage.routeName);
                                },
                                child: const Text(
                                  'REGISTRATE AHORA',
                                  style: TextStyle(
                                    fontFamily: fontType,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: fontColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
