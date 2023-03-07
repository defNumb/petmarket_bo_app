import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';

class WarningPopUp extends StatefulWidget {
  const WarningPopUp({super.key});

  @override
  State<WarningPopUp> createState() => _WarningPopUpState();
}

class _WarningPopUpState extends State<WarningPopUp> {
  // form key
  final _formKey = GlobalKey<FormState>();
  //auto validate mode disabled
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  // password controller
  final _passwordController = TextEditingController();

  @override
  //initialize
  void initState() {
    super.initState();
  }

  // verify password is correct and submit form to delete account
  void _submitForm() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    // if form is valid
    if (form == null || !form.validate()) {
      return;
    }
    form.save();
    context.read<AuthBloc>().add(
          DeleteAccountRequestedEvent(
            password: _passwordController.text,
          ),
        );
    // pop from all pages
    Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
    ;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          // 90% of the screen height
          height: MediaQuery.of(context).size.height * 0.95,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.cancel_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Eliminar cuenta'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // warning text in a container asking user if they are sure they want to delete their account
                  // display current email
                  // button to delete account
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estas seguro de que quieres eliminar tu cuenta de petmarket',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${state.user!.email}?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // sized box
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      'No podras reactivar tu cuenta despues de eliminarla, y perderas todos tus dato en petmarket.\nal eliminar tu cuenta perderas:\n\n       - No podras volver a entrar a tu cuenta\n       - No podras recuperar tus datos\n       - No podras volver a comprar productos\n',
                    ),
                  ),
                  // sized box
                  SizedBox(
                    height: 10,
                  ),
                  // text to ask user to verify password
                  Container(
                    child: Text(
                      'Por favor ingresa tu contraseña para eliminar tu cuenta',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // form to verify password
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 5, 16, 16),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autoValidateMode,
                      child: Column(
                        children: [
                          // password field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu contraseña';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // button to delete account
                  Container(
                    child: TextButton(
                      // red button
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        _submitForm();
                      },
                      child: Text(
                        'Eliminar cuenta',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
