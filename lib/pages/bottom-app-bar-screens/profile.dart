import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/auth/auth_bloc.dart';
import 'package:petmarket_bo_app/blocs/profile/profile_cubit.dart';
import 'package:petmarket_bo_app/constants/db_constant.dart';
import 'package:petmarket_bo_app/utils/error_dialog.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() {
    final String uid = context.read<AuthBloc>().state.user!.uid;
    print(uid);
    context.read<ProfileCubit>().getProfile(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      // AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 26, 134, 223),
          elevation: 15,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              iconSize: 30,
            ),
          ),
          title: const Center(
              child: Text(
            'Mi Perfil',
            style: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              iconSize: 30,
            )
          ],
        ),
      ),

      // Body
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ProfileStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.profileStatus == ProfileStatus.initial) {
            return Container();
          } else if (state.profileStatus == ProfileStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.profileStatus == ProfileStatus.error) {
            return Center(
              child: Text('Oops! try again!'),
            );
          }
          return SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                // Getting User name and sign up date
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hola! ${state.user.name}',
                        style: const TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 15),
                      child: Text(
                        'Usuario desde: ${state.user.dateJoined} ',
                        style: const TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                // Divider
                const Divider(height: 0, thickness: 2, color: Colors.white60),

                // Llamanos Banner
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 11, 33, 51),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'Estamos aqui para ti 24/7',
                          style: TextStyle(
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          // Llamanos
                          Padding(
                            padding: const EdgeInsets.fromLTRB(70, 10, 0, 0),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 46, 107, 156),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                      child: Icon(Icons.phone, color: Colors.white),
                                    ),
                                    Center(
                                        child: Text(
                                      'Llamanos',
                                      style: TextStyle(
                                        fontFamily: "Quicksand",
                                        color: Colors.white,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Envianos un mensaje
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 46, 107, 156),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Icon(Icons.message, color: Colors.white),
                                    ),
                                    Center(
                                        child: Text(
                                      'Email',
                                      style: TextStyle(
                                        fontFamily: "Quicksand",
                                        color: Colors.white,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Mi informacion
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 32, 66, 94),
                  ),
                  child: const Text(
                    'Mi Info',
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),

                // ------BUTTONS------
                // MY INFO
                // Mis mascotas
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.pets_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Mis Mascotas',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // Historial de Compras
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.local_shipping_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Historial de compra',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // Mis Favoritos
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Favoritos',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // Metodos de Pago
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.credit_card,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Metodos de Pago',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // Direcciones
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Mis Direcciones',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // MY SETTINGS
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 32, 66, 94),
                  ),
                  child: const Text(
                    'Mis Opciones',
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Account Settings
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Opciones de Cuenta',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // Notifications
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // HELP CENTER
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 32, 66, 94),
                  ),
                  child: const Text(
                    'Centro de Ayuda',
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Share the app
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Comparte la aplicacion',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // Terms and Policies
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.article,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Terminos y condiciones',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // Privacy Policy
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Icon(
                            Icons.privacy_tip,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Política de privacidad',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0, color: Colors.white60),
                // Spacer
                const SizedBox(height: 50),
                // Sign Out Button
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 5, 14, 20),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignoutRequestedEvent());
                    },
                    child: const Text(
                      'Cerrar sesión',
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Spacer
                const SizedBox(height: 25),
                // App Version Number
                const Text(
                  'v1.0.1',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),

                // Spacer
                const SizedBox(height: 100),
              ],
            ),
          ));
        },
      ),
    );
  }
}
