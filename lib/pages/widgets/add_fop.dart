import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/fop_list/fop_list_cubit.dart';
import 'package:petmarket_bo_app/utils/cc_input_formatter.dart';
import 'package:petmarket_bo_app/utils/error_dialog.dart';

import '../../blocs/add_fop/add_fop_cubit.dart';
import '../../constants/app_constants.dart';
import '../../models/fop_model.dart';
import '../../utils/card_utils.dart';

class AddFopPage extends StatefulWidget {
  static String routeName = '/add_fop';
  const AddFopPage({super.key});

  @override
  State<AddFopPage> createState() => _AddFopPageState();
}

class _AddFopPageState extends State<AddFopPage> {
  // the form key is used to validate the form
  final _formKey = GlobalKey<FormState>();
  // validation mode disabled
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  // text controller for card number
  final _cardNumberController = TextEditingController();
  String? _fopName, _fopCcv, _fopExpDate, _cardHolderName;
  CardType cardType = CardType.invalid;

  void getCardTypeFrmNumber() {
    // within in first 6 digits of the card number
    if (_cardNumberController.text.length <= 6) {
      String cardNum = CardUtils.getCleanedNumber(_cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(cardNum);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  void _submit() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      print('Form is invalid');
      return;
    }

    form.save();
    FormOfPayment fop = FormOfPayment(
      id: '',
      cardName: _fopName ?? '',
      cardNumber: _cardNumberController.text,
      cardCcv: _fopCcv ?? '',
      cardExpirationDate: _fopExpDate ?? '',
      cardHolderName: _cardHolderName ?? '',
      cardType: cardType,
      isDefault: false,
    );

    // add address to firebase
    context.read<AddFopCubit>().addFop(fop);
    // todo update address list cubit
    context.read<FopListCubit>().updateFopList();
    // todo update address list cubit
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(() {
      getCardTypeFrmNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFopCubit, AddFopState>(
      listener: (context, state) {
        if (state.status == AddFopStatus.error) {
          errorDialog(context, state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appbarColor,
            title: Center(
              child: const Text(
                'Agregar Método de Pago',
                style: TextStyle(
                  fontFamily: fontType,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: fontColor,
                ),
              ),
            ),
          ),

          // the body consists of a form within a column with fields for
          // the name of the fop, the number of the fop, the ccv, and the expiration date
          // the form is validated when the user presses the submit button
          body: Form(
            autovalidateMode: _autoValidateMode,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  // Nombre del método de pago
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Nombre del método de pago',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre del método de pago';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _fopName = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Numero de la tarjeta
                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardNumberInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.credit_card_rounded),
                      suffixIcon: CardUtils.getCardIcon(cardType),
                      hintText: 'Número de la tarjeta',
                      border: OutlineInputBorder(),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    validator: (value) {
                      return CardUtils.validateCardNum(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  // card holder name
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Nombre del titular de la tarjeta',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre del titular de la tarjeta';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _cardHolderName = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // a short text field for the ccv
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          //limit the input to 3 digits
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'CCV',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return CardUtils.validateCcv(value);
                          },
                          onChanged: (value) {
                            setState(() {
                              _fopCcv = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          // limit the input to 5 characters
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                            FilteringTextInputFormatter.digitsOnly,
                            CardMonthInputFormatter(),
                          ],
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            hintText: 'MM/YY',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return CardUtils.validateDate(value);
                          },
                          onChanged: (value) {
                            setState(() {
                              _fopExpDate = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state.status == FopListStatus.loading ? null : _submit,
                    child: const Text('Agregar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
