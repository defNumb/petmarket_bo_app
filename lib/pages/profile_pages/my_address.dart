import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/address_list/address_list_cubit.dart';
import 'package:petmarket_bo_app/utils/error_dialog.dart';

import '../../constants/app_constants.dart';
import '../widgets/add_address.dart';

class MyAddressPage extends StatefulWidget {
  static String routeName = '/my_address';
  const MyAddressPage({super.key});

  @override
  State<MyAddressPage> createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  // get address list
  @override
  void initState() {
    super.initState();
    context.read<AddressListCubit>().getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Center(
          child: const Text(
            'Mis Direcciones',
            style: TextStyle(
              fontFamily: fontType,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: fontColor,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            iconSize: 30,
          ),
        ],
      ),
      body: BlocConsumer<AddressListCubit, AddressListState>(
        listener: (context, state) {
          if (state.status == AddressListStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.status == AddressListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // if the address list is not empty, return a list of addresses
          if (state.addresses.isNotEmpty) {
            return ListView.builder(
              itemCount: state.addresses.length,
              itemBuilder: (context, index) {
                // return a container with the address information
                // and a button to delete the address
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.addresses[index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.addresses[index].address,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.addresses[index].city,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.addresses[index].state,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.addresses[index].zipCode,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.addresses[index].phoneNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Editar'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              context.read<AddressListCubit>().removeAddress(
                                    state.addresses[index].id,
                                  );
                            },
                            child: const Text('Eliminar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return noAddress(context);
        },
      ),
    );
  }
}

Widget noAddress(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 20),
      const Text(
        'No tienes ninguna dirección agregada',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: const Text(
          'Añade una dirección para poder realizar tus pedidos',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Quicksand',
          ),
        ),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AddAddressPage.routeName);
        },
        child: const Text('Agregar dirección'),
      ),
    ],
  );
}
