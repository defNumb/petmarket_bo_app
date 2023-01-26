import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/signup_pet/signup_pet_cubit.dart';
import 'package:petmarket_bo_app/models/pet_model.dart';
import 'package:petmarket_bo_app/utils/error_dialog.dart';
import '../../../constants/app_constants.dart';

class RegisterPetScreen extends StatefulWidget {
  static const String routeName = '/add_pet';
  const RegisterPetScreen({Key? key}) : super(key: key);

  @override
  State<RegisterPetScreen> createState() => _RegisterPetScreenState();
}

class _RegisterPetScreenState extends State<RegisterPetScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String? _name,
      _icon,
      _species,
      _breed,
      _breed2,
      _gender,
      _birthDay,
      _weight,
      _neutered,
      _backgroundImage;

  void _submit() {
    print('works here');
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    print('works here');
    final form = _formKey.currentState;
    print(form);
    if (form == null || !form.validate()) {
      print('Form is invalid');
      return;
    }

    form.save();
    Pet newPet = Pet(
      id: '',
      icon: _icon ?? 'assets/images/dog_icon.png',
      name: _name!,
      breed: _breed ?? '',
      breed2: _breed2 ?? '',
      species: _species!,
      gender: _gender ?? '',
      weight: _weight!,
      birthDay: _birthDay!,
      healthConditions: '',
      neutered: _neutered ?? 'No',
      backgroundImage: _backgroundImage ?? '',
      referenceId: '',
    );
    context.read<SignupPetCubit>().signup(pet: newPet);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignupPetCubit, SignupPetState>(
        listener: (context, state) {
          if (state.signupPetStatus == SignupPetStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 26, 134, 223),
              elevation: 15,
              title: const Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Registra tu mascota',
                  style: TextStyle(
                    fontFamily: fontType,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: fontColor,
                  ),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child: ListView(
                //shrinkWrap: true,
                children: <Widget>[
                  //
                  // RELLENA LOS CAMPOS REQUERIDOS
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Row(
                      children: const [
                        Text('Porfavor rellena todos los campos requeridos',
                            style: TextStyle(color: Colors.white)),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text('*', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                  //
                  // INICIO DEL FORMULARIO
                  // TIPO DE MASCOTA & ICONO DE PERFIL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // TIPO DE MASCOTA
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            color: boxContainerColor,
                            border: Border.all(
                              color: boxContainerColor,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 37),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Tipo de Mascota',
                                      style: TextStyle(
                                        fontFamily: fontType,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text('*', style: TextStyle(color: Colors.redAccent))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FormField(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                          errorStyle:
                                              TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0))),
                                      isEmpty: _species == 'Perro',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _species,
                                          isExpanded: true,
                                          isDense: true,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _species = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items:
                                              species.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                  autovalidateMode: _autoValidateMode,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // <---- FINAL TIPO DE MASCOTA
                      // ICONO DE PERFIL
                      Flexible(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: boxContainerColor,
                            border: Border.all(
                              color: boxContainerColor,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Icono de perfil',
                                  style: TextStyle(
                                    fontFamily: fontType,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                Flexible(
                                  child: FormField(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                            errorStyle:
                                                TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0))),
                                        isEmpty: _icon == 'assets/images/dog_icon.png',
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _icon,
                                            isExpanded: true,
                                            isDense: true,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _icon = newValue!;
                                                state.didChange(newValue);
                                              });
                                            },
                                            items:
                                                icons.map<DropdownMenuItem<String>>((String icon) {
                                              return DropdownMenuItem<String>(
                                                value: icon,
                                                child: Image.asset(
                                                  icon,
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                    autovalidateMode: _autoValidateMode,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // <---- FINAL ICONO DE PERFIL
                    ],
                  ),
                  // <---- FINAL TIPO DE MASCOTA & ICONO DE PERFIL
                  //
                  // FOTO DE PERFIL
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: boxContainerColor,
                          border: Border.all(
                            color: boxContainerColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Foto de tu mascota',
                                style: TextStyle(
                                  fontFamily: fontType,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                  textStyle:
                                      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                child: const Text('Seleccionar foto'),
                              ),
                            )
                          ],
                        )),
                  ),
                  // <---- FINAL FOTO DE PERFIL
                  //
                  // INFO DE LA MASCOTA
                  //
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: boxContainerColor,
                        border: Border.all(
                          color: boxContainerColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          // INFORMACION GENERAL
                          const Text(
                            'Información Generál',
                            style: TextStyle(
                              fontFamily: fontType,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          //
                          // FORM
                          Column(
                            children: [
                              //
                              // NOMBRE DE LA MASCOTA
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 25, 0, 5),
                                child: Row(
                                  children: const [
                                    Text('Nombre de tu mascota'),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.0),
                                      child: Text('*', style: TextStyle(color: Colors.red)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white70,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Por favor ingrese un nombre';
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
                              ),
                              // <---- FINAL NOMBRE DE LA MASCOTA
                              //
                              // RAZA DE LA MASCOTA
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                child: Row(
                                  children: const [
                                    Text('Raza de tu mascota'),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.0),
                                      child: Text('*', style: TextStyle(color: Colors.red)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: FormField(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                          errorStyle:
                                              TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0))),
                                      isEmpty: _species == 'Perro',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _species,
                                          isExpanded: true,
                                          isDense: true,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _species = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items:
                                              species.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // <---- FINAL RAZA DE LA MASCOTA
                              //
                              // RAZA ADICIONAL DE LA MASCOTA
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                child: Row(
                                  children: const [
                                    Text('Raza adicional'),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white70,
                                    ),
                                    onSaved: (String? value) {
                                      _breed2 = value;
                                    },
                                  )),
                              // <---- FINAL RAZA ADICIONAL DE LA MASCOTA
                              //
                              // GENERO DE LA MASCOTA
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                child: Row(
                                  children: const [
                                    Text('Género'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white70,
                                  ),
                                  onSaved: (String? value) {
                                    _gender = value;
                                  },
                                ),
                              ),
                              // <---- FINAL GENERO DE LA MASCOTA
                              //
                              // PESO DE LA MASCOTA
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                child: Row(
                                  children: const [
                                    Text('Peso de tu mascota (kg)'),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.0),
                                      child: Text('*', style: TextStyle(color: Colors.red)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white70,
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Por favor ingrese el peso de su mascota';
                                    }
                                    return null;
                                  },
                                  onSaved: (String? value) {
                                    _weight = value;
                                  },
                                ),
                              ),
                              // <---- FINAL PESO DE LA MASCOTA
                              //
                              // EDAD DE LA MASCOTA
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                child: Row(
                                  children: const [
                                    Text('Fecha de nacimiento'),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.0),
                                      child: Text('*', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    hintText: 'dd/mm/aaaa',
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Por favor ingrese una fecha';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.datetime,
                                  onSaved: (value) {
                                    _birthDay = value.toString();
                                  },
                                ),
                              ), // <---- FINAL EDAD DE LA MASCOTA
                              //
                              // CASTRADO
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                child: Row(
                                  children: const [
                                    Text('Castrado/a'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: FormField(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        fillColor: Colors.white70,
                                        errorStyle:
                                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      isEmpty: _neutered == 'No',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _neutered,
                                          isExpanded: true,
                                          isDense: true,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _neutered = newValue!;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items:
                                              yesno.map<DropdownMenuItem<String>>((String answer) {
                                            return DropdownMenuItem<String>(
                                              value: answer,
                                              child: Text(answer),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                  autovalidateMode: _autoValidateMode,
                                ),
                              ),
                              // <---- FINAL CASTRADO
                              //
                              const SizedBox(height: 25),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                  // <---- FINAL FORMULARIO
                  //
                  //
                  // BOTON DE REGISTRO
                  ,
                  InkWell(
                    onTap: state.signupPetStatus == SignupPetStatus.submitting ? null : _submit,
                    child: Column(
                      children: [
                        Ink.image(
                          image: const AssetImage('assets/images/paw2.png'),
                          height: 74,
                          width: 72,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.signupPetStatus == SignupPetStatus.submitting
                              ? 'Guardando...'
                              : 'Guardar',
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
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
