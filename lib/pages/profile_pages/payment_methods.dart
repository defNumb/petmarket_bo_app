import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/utils/error_dialog.dart';

import '../../blocs/add_fop/add_fop_cubit.dart';
import '../../blocs/fop_list/fop_list_cubit.dart';
import '../../constants/app_constants.dart';
import '../../models/fop_model.dart';

class PaymentMethodPage extends StatefulWidget {
  static String routeName = '/payment_methods';
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  @override
  void initState() {
    super.initState();
    getFopList();
  }

  void getFopList() {
    BlocProvider.of<FopListCubit>(context).getFopList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Center(
          child: const Text(
            'Métodos de Pago',
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
            onPressed: () {
              Navigator.pushNamed(context, '/add_fop');
            },
            icon: const Icon(Icons.add),
            iconSize: 30,
          ),
        ],
      ),
      body: BlocConsumer<FopListCubit, FopListState>(
        listener: (context, state) {
          if (state.listStatus == FopListStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.listStatus == FopListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.listStatus == FopListStatus.loaded && state.fopList.isEmpty) {
            return noFormsOfPayment(context);
          }
          return ListView.builder(
            itemCount: state.fopList.length,
            itemBuilder: (context, index) {
              // container with round edges in the shape of a card with shadow
              // and a row with the fop name and a delete button
              // and display the digits obscured by * until the last 4 digits
              return Container(
                height: 235,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            state.fopList[index].cardName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AddFopCubit>(context)
                                .deleteFop(state.fopList[index].id);
                          },
                          icon: const Icon(Icons.delete),
                          iconSize: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '**** **** **** ${state.fopList[index].cardNumber.substring(state.fopList[index].cardNumber.length - 4)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        // sized box
                        const SizedBox(width: 10),
                        getCardTypeIcon(
                          state.fopList[index].cardType,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Widget noFormsOfPayment(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 20),
      Center(
        child: const Text(
          'No tienes ningún método de pago agregado',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        'Añade un método de pago para poder realizar tus pedidos',
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Quicksand',
        ),
      ),
      const SizedBox(height: 20),
      Container(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_fop');
          },
          child: const Text(
            'Añadir Método de Pago',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: appbarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ],
  );
}

// method to get card type icon image from assets based on CardType enum
Widget getCardTypeIcon(CardType cardType) {
  switch (cardType) {
    case CardType.visa:
      return Image.asset(
        'assets/images/visa.png',
        width: 50,
        height: 50,
      );
    case CardType.mastercard:
      return Image.asset(
        'assets/images/mastercard.png',
        width: 50,
        height: 50,
      );
    case CardType.amex:
      return Image.asset(
        'assets/images/american_express.png',
        width: 50,
        height: 50,
      );
    case CardType.discover:
      return Image.asset(
        'assets/images/discover.png',
        width: 50,
        height: 50,
      );

    case CardType.others:
      return Image.asset(
        'assets/images/unknown.png',
        width: 50,
        height: 50,
      );
    default:
      return Placeholder(
        fallbackHeight: 50,
        fallbackWidth: 50,
      );
  }
}
