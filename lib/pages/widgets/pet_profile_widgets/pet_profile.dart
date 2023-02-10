import "package:flutter/material.dart";

import '../../../models/pet_model.dart';

class PetProfile extends StatefulWidget {
  final Pet pet;
  const PetProfile({Key? key, required this.pet}) : super(key: key);

  @override
  State<PetProfile> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;

  Image backgroundImage = Image.asset('images/wallpaper.png');

  @override
  void initState() {
    super.initState();
    // if (widget.pet.background != "") {
    //   backgroundImage = Image.network(widget.pet.background);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 144, 199, 244),
      //
      // APP BAR
      //
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 26, 134, 223),
          elevation: 15,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            iconSize: 30,
          ),
          title: const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Perfil de tu mascota',
              style: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Editar',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                ),
              ),
            )
          ],
        ),
      ),
      //
      // MAIN BODY
      //
      body: SingleChildScrollView(
        child: Column(
          children: [
            //
            // PROFILE ICON AND NAME
            Stack(
              children: [
                Container(
                  height: 155,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: backgroundImage.image, fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87.withOpacity(0.4),
                        blurRadius: 5,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB((width / 2) - 40, 115, 30, 15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87.withOpacity(0.4),
                              blurRadius: 5,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB((width / 2) - 35, 120, 30, 15),
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 35,
                        child: Container(
                          height: 50,
                          child: Image.asset(
                            widget.pet.icon,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //
            // PET INFO
            //
            // Pet name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.pet.name,
                  style: const TextStyle(fontSize: 18, fontFamily: 'Quicksand'),
                ),
              ],
            ),
            //
            // INFO ROW
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 25, 0, 25),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //
                      // Breed
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          const Text(
                            'RAZA',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.pet.breed,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        width: 50,
                        thickness: 2,
                      ),
                      //
                      // Weight
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          const Text(
                            'PESO',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${double.parse(widget.pet.weight)} Kg",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const VerticalDivider(
                        width: 50,
                        thickness: 2,
                      ),
                      //
                      // Age
                      Column(
                        children: [
                          const Text(
                            'EDAD',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // Text(
                          //   "${age.years.toString()} años, ${age.days.toString()} dias",
                          //   style: const TextStyle(fontSize: 12),
                          // )
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // HORIZONTAL DIVIDER
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Divider(
                height: 15,
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
