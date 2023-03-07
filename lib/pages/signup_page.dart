import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../blocs/signin/signin_cubit.dart';
import '../blocs/signup/signup_cubit.dart';
import '../constants/app_constants.dart';
import '../utils/error_dialog.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final _passwordController = TextEditingController();
  String? _name, _lastName, _email, _password;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = false;
  }

  void _submit() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    form.save();
    context.read<SignupCubit>().signup(
          name: _name!,
          lastName: _lastName!,
          email: _email!,
          password: _password!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.signupStatus == SignupStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: primaryColor,
              elevation: 2.0,
            ),
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
                        height: 200.0,
                        width: 200.0,
                      ),
                      // WELCOME TEXT
                      Text(
                        'Bienvenido! Por favor rellene los siguientes campos para registrarse',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontType),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.0),
                      // Nombre
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          labelText: 'Nombre',
                          prefixIcon: Icon(Icons.account_box),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingrese su nombre';
                          }
                          if (value.trim().length < 3) {
                            return 'El nombre debe tener al menos 3 caracteres';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _name = value;
                        },
                      ),
                      SizedBox(height: 20.0),

                      // Apellido
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          labelText: 'Apellido',
                          prefixIcon: Icon(Icons.account_box),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingrese su apellido';
                          }
                          if (value.trim().length < 3) {
                            return 'El apellido debe tener al menos 3 caracteres';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _lastName = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      // Correo electrónico
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          labelText: 'Correo electrónico',
                          fillColor: Colors.white70,
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingrese su correo electrónico';
                          }
                          if (!isEmail(value.trim())) {
                            return 'Por favor ingrese un correo electrónico válido';
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
                        controller: _passwordController,
                        obscureText: !_obscureText,
                        decoration: InputDecoration(
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          labelText: 'Contraseña',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
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
                      // Confirmar contraseña
                      TextFormField(
                        obscureText: !_obscureText,
                        decoration: InputDecoration(
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          labelText: 'Confirmar contraseña',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (String? value) {
                          if (value != _passwordController.text.trim()) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50.0),
                      InkWell(
                        onTap: state.signupStatus == SignupStatus.submitting ? null : _submit,
                        child: Column(
                          children: [
                            Ink.image(
                              image: const AssetImage('assets/images/paw2.png'),
                              height: 74,
                              width: 72,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              state.signupStatus == SigninStatus.submitting
                                  ? 'Cargando...'
                                  : 'Registrarse',
                              style: TextStyle(
                                fontFamily: fontType,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: state.signupStatus == SignupStatus.submitting
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
                        style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 211, 189, 146),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: Text('¿Ya tienes una cuenta? Inicia sesión'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
