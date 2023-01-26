import 'package:flutter/material.dart';

class BirdCategory extends StatelessWidget {
  const BirdCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
          color: Colors.white,
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            image: AssetImage('assets/images/testparrot1.png'),
            fit: BoxFit.fitHeight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 100,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(140, 10, 0, 0),
                  child: Text(
                    "AVES",
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
          ],
        ),
      ),
    );
  }
}
