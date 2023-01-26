import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/auth/auth_bloc.dart';
import 'package:petmarket_bo_app/blocs/pet_list/pet_list_cubit.dart';
import 'package:petmarket_bo_app/models/pet_model.dart';
import 'package:petmarket_bo_app/utils/error_dialog.dart';

import '../../constants/app_constants.dart';

class MyPetsScreen extends StatefulWidget {
  static const String routeName = '/my_pets';
  const MyPetsScreen({Key? key}) : super(key: key);

  @override
  State<MyPetsScreen> createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  // VARIABLES
  Image backgroundImage = Image.asset('assets/images/wallpaper.png');
  late List<Pet> petList = [];

  @override
  void initState() {
    _getPetList();
    super.initState();
  }

  void _getPetList() async {
    final String uid = context.read<AuthBloc>().state.user!.uid;
    petList = await context.read<PetListCubit>().getPetList(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff068BCA),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 134, 223),
        elevation: 15,
        title: const Center(
            child: Text(
          'Mis Mascotas',
          style: TextStyle(
            fontFamily: fontType,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: fontColor,
          ),
        )),
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
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_pet');
              },
              icon: const Icon(Icons.add),
              iconSize: 30,
            ),
          ),
        ],
      ),
      body: BlocConsumer<PetListCubit, PetListState>(
        listener: (context, state) {
          if (state.listStatus == PetListStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.listStatus == PetListStatus.initial) {
            return Container();
          } else if (state.listStatus == PetListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.listStatus == PetListStatus.loaded && petList.isEmpty) {
            return noPets();
          } else if (state.listStatus == PetListStatus.error) {
            return Center(
              child: Text(
                'Oops try again',
              ),
            );
          }
          print(state.listStatus);
          return ListView.builder(
            itemCount: petList.length,
            itemBuilder: ((context, index) {
              Pet petDocument = petList[index];
              if (petDocument.backgroundImage != "") {
                backgroundImage = Image.network(petDocument.backgroundImage);
              } else {
                backgroundImage = Image.asset('assets/images/wallpaper.png');
              }
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: backgroundImage.image,
                        fit: BoxFit.cover,
                      ),
                      color: const Color.fromARGB(255, 5, 107, 155),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Center(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                            child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 130, 189, 217),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height / 10,
                                width: MediaQuery.of(context).size.width),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 130, 0, 0),
                            child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 130, 189, 217),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                height: 60,
                                width: 60),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(17, 132, 0, 0),
                            child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(221, 7, 33, 75),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                height: 56,
                                width: 56),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 125, 8, 0),
                                child: ClipOval(
                                  child: Image.asset(
                                    petDocument.icon,
                                    width: 40,
                                    height: 70,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 145, 8, 0),
                                child: Text(
                                  petDocument.name,
                                  style: const TextStyle(
                                    fontFamily: fontType,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: fontColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(150, 150, 0, 20),
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Confirmacion'),
                                      content: const Text('Cofirma tu decision'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {},
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

Widget noPets() => const Center(
      child: Text(
        '         No tienes animalitos registrados! \n usa la "+" para agregar una nueva mascota!',
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
