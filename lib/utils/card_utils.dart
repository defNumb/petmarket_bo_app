import 'package:flutter/material.dart';

import '../models/fop_model.dart';

class CardUtils {
  // validate CCV
  static String? validateCcv(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese el CCV';
    }
    if (value.length < 3 || value.length > 4) {
      return 'El CCV debe tener al menos 3 dígitos';
    }
    return null;
  }

  // validate date
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese la fecha de expiración';
    }
    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split((RegExp(r'(/)')));
      // The value before the slash is the month while the value after the slash is the year
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1;
    }
    if (month < 1 || month > 12) {
      return 'El mes debe estar entre 1 y 12';
    }

    var fourDigitYear = convertYearTo4Digits(year);
    if (fourDigitYear < 1 || fourDigitYear > 2099) {
      return 'La fecha de expiración no puede ser anterior a la fecha actual';
    }

    if (!hasDateExpired(month, year)) {
      return 'La tarjeta esta vencida';
    }
    return null;
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split((RegExp(r'(/)')));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    return hasYearPassed(year) || convertYearTo4Digits(year) == now.year && month < now.month;
  }

  static bool hasYearPassed(int year) {
    var now = DateTime.now();
    return convertYearTo4Digits(year) < now.year;
  }

  static String getCleanedNumber(String value) {
    var regExp = RegExp(r'[^0-9]');
    return value.replaceAll(regExp, '');
  }

  static Widget? getCardIcon(CardType? cardtype) {
    String img = '';
    Icon? icon;
    switch (cardtype) {
      case CardType.amex:
        img = 'assets/images/amex.png';
        break;
      case CardType.visa:
        img = 'assets/images/visa.png';
        break;
      case CardType.mastercard:
        img = 'assets/images/mastercard.png';
        break;
      case CardType.discover:
        img = 'assets/images/discover.png';
        break;
      case CardType.others:
        icon = const Icon(Icons.credit_card);
        break;
      default:
        icon = const Icon(Icons.credit_card);
        break;
    }

    Widget? widget;
    if (img.isNotEmpty) {
      widget = Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 20, 8),
        child: Image.asset(
          img,
          width: 40,
          height: 40,
        ),
      );
    } else {
      widget = icon;
    }
    return widget;
  }
  // validate card number with Luhn algorithm
  // https://en.wikipedia.org/wiki/Luhn_algorithm

  static String? validateCardNum(String? input) {
    if (input == null || input.isEmpty) {
      return 'Por favor ingrese el número de la tarjeta';
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      return 'El número de la tarjeta es muy corto';
    }

    int sum = 0;
    int length = input.length;

    for (var i = 0; i < length; i++) {
      int digit = int.parse(input[length - i - 1]);
      if (i % 2 == 1) {
        digit *= 2;
      }
      if (digit > 9) {
        digit -= 9;
      }
      sum += digit;
    }
    if (sum % 10 == 0) {
      return null;
    }
    return 'El número de la tarjeta es inválido';
  }

  // get card type from number, use regexp
  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(
        RegExp(r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.mastercard;
    } else if (input.startsWith(RegExp(r'([4])'))) {
      cardType = CardType.visa;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.discover;
    } else if (input.length <= 8) {
      cardType = CardType.others;
    } else {
      cardType = CardType.invalid;
    }
    return cardType;
  }
}
