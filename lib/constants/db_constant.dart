import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

const boxContainerColor = Colors.white70;
const primaryColor = Color(0xff068BCA);
const fontColor = Colors.white;
const fontType = 'Quicksand';
