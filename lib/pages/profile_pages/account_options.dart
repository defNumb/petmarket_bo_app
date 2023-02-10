// import material
import 'package:flutter/material.dart';

class AccountOptionsPage extends StatefulWidget {
  static String routeName = '/account_options';
  const AccountOptionsPage({super.key});

  @override
  State<AccountOptionsPage> createState() => _AccountOptionsPageState();
}

class _AccountOptionsPageState extends State<AccountOptionsPage> {
  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: const Text('Opciones de cuenta'),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 150,
                width: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey,
                ),
                child: Column(
                  children: [
                    Divider(
                      height: 2,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
