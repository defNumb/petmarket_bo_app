import 'package:flutter/material.dart';
import 'package:petmarket_bo_app/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../signin_popup.dart';

class UnauthProfile extends StatelessWidget {
  const UnauthProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                            onTap: () {
                              _launchCaller();
                            },
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
                onTap: () {
                  showModalBottomSheet<dynamic>(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: <Widget>[],
                      );
                    },
                  );
                },
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
        ),
      ),
    );
  }
}

// Call store's phone number
_launchCaller() async {
  Uri url = Uri(scheme: "tel", path: "+591 3461466");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
