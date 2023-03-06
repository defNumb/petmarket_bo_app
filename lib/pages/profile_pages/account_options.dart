// import material
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/pages/widgets/warning_popup.dart';

import '../../blocs/profile/profile_cubit.dart';
import '../../models/user_model.dart';

class AccountOptionsPage extends StatefulWidget {
  static String routeName = '/account_options';
  const AccountOptionsPage({super.key});

  @override
  State<AccountOptionsPage> createState() => _AccountOptionsPageState();
}

class _AccountOptionsPageState extends State<AccountOptionsPage> {
  // validate mode
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // form fields variables
  String? _name, _lastName, _phoneNumber, _email;

  // submit form
  void _submitForm() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    form.save();
    // new user
    User newUser = User(
      id: BlocProvider.of<ProfileCubit>(context).state.user.id,
      name: _name ?? BlocProvider.of<ProfileCubit>(context).state.user.name,
      lastName: _lastName ?? BlocProvider.of<ProfileCubit>(context).state.user.lastName,
      email: _email ?? BlocProvider.of<ProfileCubit>(context).state.user.email,
      point: BlocProvider.of<ProfileCubit>(context).state.user.point,
      rank: BlocProvider.of<ProfileCubit>(context).state.user.rank,
      phoneNumber: _phoneNumber ?? BlocProvider.of<ProfileCubit>(context).state.user.phoneNumber,
      dateJoined: BlocProvider.of<ProfileCubit>(context).state.user.dateJoined,
      emailVerified: BlocProvider.of<ProfileCubit>(context).state.user.emailVerified,
      phoneVerified: BlocProvider.of<ProfileCubit>(context).state.user.phoneVerified,
      isSubscribed: BlocProvider.of<ProfileCubit>(context).state.user.isSubscribed,
      location: BlocProvider.of<ProfileCubit>(context).state.user.location,
      orderNotification: BlocProvider.of<ProfileCubit>(context).state.user.orderNotification,
      promotionNotification:
          BlocProvider.of<ProfileCubit>(context).state.user.promotionNotification,
      postNotification: BlocProvider.of<ProfileCubit>(context).state.user.postNotification,
      isOnline: BlocProvider.of<ProfileCubit>(context).state.user.isOnline,
    );
    // update user info
    BlocProvider.of<ProfileCubit>(context).updateProfile(
      newUser.id,
      newUser.name,
      newUser.lastName,
      newUser.phoneNumber,
    );
    // get user info
    BlocProvider.of<ProfileCubit>(context).getProfile(uid: newUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: const Text('Opciones de cuenta'),
        ),
        // save button
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: _submitForm,
              child: Text(
                'Guardar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              // if loading show circular progress indicator
              if (state.profileStatus == ProfileStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // dark blue grey color and rounded edges
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 89, 87, 87),
                    ),
                    child: Form(
                      autovalidateMode: _autoValidateMode,
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          // form fields with rounded corners populated with user data
                          // name field
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextFormField(
                                initialValue: state.user.name,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nombre',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese su nombre';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  _name = newValue;
                                },
                              ),
                            ),
                          ),
                          // last name field
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextFormField(
                                initialValue: state.user.lastName,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Apellido',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese su apellido';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  _lastName = newValue;
                                },
                              ),
                            ),
                          ),
                          // phone number field
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextFormField(
                                initialValue: state.user.phoneNumber,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Número de teléfono',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese su número de teléfono';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  _phoneNumber = newValue;
                                },
                              ),
                            ),
                          ),
                          // email field WARN THE user that if this is changed
                          // the app will log out
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextFormField(
                                initialValue: state.user.email,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Correo electrónico',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese su correo electrónico';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          // warning text
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Si cambia su correo electrónico, se cerrará la sesión',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // size box
          const SizedBox(
            height: 10,
          ),
          // change password section with arrow icon
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Cambiar contraseña',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // size box
          const SizedBox(
            height: 10,
          ),
          // use Face ID section with turn on switch button
          // that turns blue when on and grey when off
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Usar Face ID',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Switch(
                      value: false,
                      onChanged: (bool value) {
                        setState(() {
                          // switch value
                          value = true;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // size box
          const SizedBox(
            height: 10,
          ),
          // clickable delete account section with red font color and arrow icon
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: TextButton(
                onPressed: () {
                  // modal bottom sheet leading to warning popup screen
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return const WarningPopUp();
                    },
                  );
                },
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Eliminar cuenta',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
