import 'package:flutter/material.dart';
const primaryColor = Color(0xff068BCA);
class MenuPage extends StatefulWidget {
  const MenuPage({ Key? key }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), 
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 26, 134, 223),
          elevation: 15,
          automaticallyImplyLeading: false,
          leading: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.search),
                iconSize: 30,
              ),
            ),
          title: const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                  color: Colors.white,
                ),
              )
            ),
          actions: [
            IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.shopping_cart),
              iconSize: 30,
            )
          ],       
        ),     
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SHOP
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                width: MediaQuery.of(context).size.width,
                decoration: 
                  const BoxDecoration(
                    color: Color.fromARGB(255, 32, 66, 94), 
                  ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                        child: Icon(
                          Icons.store_mall_directory_outlined,
                          color: Color.fromARGB(255, 95, 220, 252),
                          ),
                      ),
                      Expanded(
                        child: Text(
                          'Compra',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:20,
                              color: Colors.white,
                            ),
                          ),
                      ),
              ]),),
              // Dog
              InkWell(
                onTap:() {},
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: 
                    const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129), 
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Text(
                          'Perro',
                          style: TextStyle(
                              fontSize:15,
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
              const Divider(
                      height: 0,
                      color: Colors.white60
                    ),
              //Cat
              InkWell(
                onTap:() {},
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: 
                    const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129), 
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Text(
                          'Gato',
                          style: TextStyle(
                              fontSize:15,
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
              const Divider(
                height: 0,
                color: Colors.white60
              ),
              // Shop by Pet
              InkWell(
                onTap:() {},
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: 
                    const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129), 
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Text(
                          'Compra por mascota',
                          style: TextStyle(
                              fontSize:15,
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
              const Divider(
                height: 0,
                color: Colors.white60
              ),
              // Shop by Brand
              InkWell(
                onTap:() {},
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: 
                    const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129), 
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Text(
                          'Compra por marca',
                          style: TextStyle(
                              fontSize:15,
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
              const Divider(
                height: 0,
                color: Colors.white60
              ),
              // Today's Deals
              InkWell(
                onTap:() {},
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: 
                    const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129), 
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Text(
                          'Oferta de hoy',
                          style: TextStyle(
                              fontSize:15,
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
              const Divider(
                height: 0,
                color: Colors.white60
              ),
              // GIVE BACK
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                width: MediaQuery.of(context).size.width,
                decoration: 
                  const BoxDecoration(
                    color: Color.fromARGB(255, 32, 66, 94), 
                  ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                        child: Icon(
                          Icons.favorite_border_sharp,
                          color: Color.fromARGB(255, 95, 220, 252),
                          ),
                      ),
                      Expanded(
                        child: Text(
                          'Ayuda ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:20,
                              color: Colors.white,
                            ),
                          ),
                      ),
              ]),),
              // How we give back
              InkWell(
                onTap:() {},
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: 
                    const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129), 
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Text(
                          'Como ayudamos',
                          style: TextStyle(
                              fontSize:15,
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
              const Divider(
                height: 0,
                color: Colors.white60
              ),
              // donate
              InkWell(
                onTap:() {},
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: 
                    const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129), 
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Text(
                          'Donar a un refugio',
                          style: TextStyle(
                              fontSize:15,
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
              const Divider(
                height: 0,
                color: Colors.white60
              ),
              // adopt
              InkWell(
                onTap:() {},
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: 
                    const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129), 
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Text(
                          'Adopta',
                          style: TextStyle(
                              fontSize:15,
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
              const Divider(
                height: 0,
                color: Colors.white60
              ),
              // join our network
              InkWell(
                onTap:() {},
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 15, 0, 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: 
                    const BoxDecoration(
                      color: Color.fromARGB(179, 58, 89, 129), 
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Text(
                          'Únete a nuestra red',
                          style: TextStyle(
                              fontSize:15,
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
              const Divider(
                height: 0,
                color: Colors.white60
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}