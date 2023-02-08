import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DogCategory extends StatelessWidget {
  const DogCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
            color: Colors.white,
            image: DecorationImage(
              alignment: Alignment.centerLeft,
              image: AssetImage('assets/images/dog_category.jpg'),
              fit: BoxFit.scaleDown,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(140, 30, 0, 0),
                      child: Text(
                        "PERROS",
                        style: TextStyle(
                          fontFamily: "Marhey",
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                          color: Color.fromARGB(255, 25, 103, 166),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                  color: Colors.deepOrange,
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  children: [
                    // BUTTON 1
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: (MediaQuery.of(context).size.width / 3) - 10,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                        ),
                        color: Colors.lightBlue,
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            "COMIDA",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      width: 2,
                      color: Colors.blue.shade700,
                    ),
                    // BUTTON 2
                    Container(
                      width: (MediaQuery.of(context).size.width / 3),
                      height: MediaQuery.of(context).size.height,
                      color: Colors.lightBlue,
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            "SNACKS",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      width: 2,
                      color: Colors.blue.shade700,
                    ),
                    // BUTTON 3
                    Container(
                      width: (MediaQuery.of(context).size.width / 3) - 10,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(35),
                        ),
                        color: Colors.lightBlue,
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            "ACCESSORIOS",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
