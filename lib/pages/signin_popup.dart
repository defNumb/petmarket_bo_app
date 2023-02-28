import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import '../blocs/signin/signin_cubit.dart';
import '../constants/app_constants.dart';
import '../utils/error_dialog.dart';

class SigninPopup extends StatefulWidget {
  const SigninPopup({super.key});

  @override
  State<SigninPopup> createState() => _SigninPopupState();
}

class _SigninPopupState extends State<SigninPopup> {
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
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state.signinStatus == SigninStatus.error) {
          errorDialog(context, state.error);
        }
      },
      builder: (context, state) {
        return Container(
          // height and width equal to media query
          height: MediaQuery.of(context).size.height * 0.90,
          width: MediaQuery.of(context).size.width,
          // rounded top corners and green color
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child:
              // Form with two fields for email and password with hint text and icon
              Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child: Column(
                children: [
                  // email field
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
                  // sign in button
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
                  // sign up button
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}