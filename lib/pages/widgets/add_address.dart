import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/add_address/add_address_cubit.dart';
import '../../constants/app_constants.dart';
import '../../models/address_model.dart';
import '../../utils/error_dialog.dart';

class AddAddressPage extends StatefulWidget {
  static String routeName = '/add_address';
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String? _addressName, _address, _address2, _city, _state, _zipCode, _phoneNumber;

  void _submit() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      print('Form is invalid');
      return;
    }

    form.save();
    Address address = Address(
      id: '',
      name: _addressName ?? '',
      address: _address ?? '',
      address2: _address2 ?? '',
      city: _city ?? '',
      state: _state ?? '',
      zipCode: _zipCode ?? '',
      phoneNumber: _phoneNumber ?? '',
    );

    // add address to firebase
    context.read<AddAddressCubit>().addAddress(address);

    // todo update address list cubit
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAddressCubit, AddAddressState>(
      listener: (context, state) {
        if (state.status == AddAddressStatus.error) {
          errorDialog(context, state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appbarColor,
            title: Center(
              child: const Text(
                'Añadir Dirección',
                style: TextStyle(
                  fontFamily: fontType,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: fontColor,
                ),
              ),
            ),
          ),
          body: // form to register an address
              Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: ListView(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: const [
                      Text('Porfavor rellena todos los campos requeridos',
                          style: TextStyle(color: Colors.black)),
                      Padding(
                        padding: EdgeInsets.only(left: 2.0),
                        child: Text('*', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
                // address name
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nombre de la dirección *',
                      hintText: 'Casa, Trabajo, etc.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Porfavor ingresa un nombre de dirección';
                      }
                      // check if name is less than 3 characters
                      if (value.trim().length < 3) {
                        return 'El nombre de la dirección debe tener al menos 3 caracteres';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _addressName = value;
                    },
                  ),
                ),
                // address
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Dirección *',
                      hintText: 'Calle, Número, Colonia, etc.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                    ),
                    validator: (String? value) {
                      // check if address is empty
                      if (value == null || value.trim().isEmpty) {
                        return 'Porfavor ingresa una dirección';
                      }
                      // check if address is less than 3 characters
                      if (value.trim().length < 3) {
                        return 'La dirección debe tener al menos 3 caracteres';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _address = value;
                    },
                  ),
                ),
                // address 2
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Dirección 2 (Opcional)',
                      hintText: 'Apartamento, Edificio, Piso, etc.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                    ),
                    onSaved: (String? value) {
                      _address2 = value;
                    },
                  ),
                ),
                // city
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Ciudad *',
                      hintText: 'Ciudad',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                    ),
                    // check if city is empty
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Porfavor ingresa una ciudad';
                      }
                      // check if city is less than 3 characters
                      if (value.trim().length < 3) {
                        return 'La ciudad debe tener al menos 3 caracteres';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _city = value;
                    },
                  ),
                ),
                // state
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Estado *',
                      hintText: 'Estado',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                    ),
                    validator: (String? value) {
                      // check if state is empty
                      if (value == null || value.trim().isEmpty) {
                        return 'Porfavor ingresa un estado';
                      }
                      // check if state is less than 3 characters
                      if (value.trim().length < 3) {
                        return 'El estado debe tener al menos 3 caracteres';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _state = value;
                    },
                  ),
                ),
                // zip code
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Código Postal *',
                      hintText: 'Código Postal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                    ),
                    validator: (String? value) {
                      // check if zip code is empty
                      if (value == null || value.trim().isEmpty) {
                        return 'Porfavor ingresa un código postal';
                      }
                      // check if zip code is less than 3 characters
                      if (value.trim().length < 3) {
                        return 'El código postal debe tener al menos 3 caracteres';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _zipCode = value;
                    },
                  ),
                ),
                // phone number
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Número de teléfono *',
                      hintText: 'Número de teléfono',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                    ),
                    validator: (String? value) {
                      // check if phone number is empty
                      if (value == null || value.trim().isEmpty) {
                        return 'Porfavor ingresa un número de teléfono';
                      }
                      // check if phone number is less than 3 characters
                      if (value.trim().length < 3) {
                        return 'El número de teléfono debe tener al menos 3 caracteres';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _phoneNumber = value;
                    },
                  ),
                ),

                // save button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: state.status == AddAddressStatus.submitting ? null : _submit,
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
