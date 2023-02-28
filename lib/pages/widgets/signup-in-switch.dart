import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petmarket_bo_app/blocs/signup-in-switch/signup_in_switch_cubit.dart';
import 'package:petmarket_bo_app/pages/signup_popup.dart';

import '../signin_popup.dart';

class SignSwitcher extends StatefulWidget {
  const SignSwitcher({super.key});

  @override
  State<SignSwitcher> createState() => _SignSwitcherState();
}

class _SignSwitcherState extends State<SignSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.90,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // sized box
          SizedBox(
            height: 10,
          ),
          // divider
          Divider(
            indent: 100,
            endIndent: 100,
            color: Color.fromARGB(255, 61, 61, 61),
            thickness: 2,
          ),
          // row with two buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sign in button
              TextButton(
                onPressed: () {
                  context.read<SignupInSwitchCubit>().switchToSignin();
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              // Sign up button
              TextButton(
                onPressed: () {
                  context.read<SignupInSwitchCubit>().switchToSignup();
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          // BlocBuilder to switch between signin and signup
          BlocBuilder<SignupInSwitchCubit, SignupInSwitchState>(
            builder: (context, state) {
              if (state.status == SignupInSwitchStatus.signup) {
                return SignupPopup();
              } else {
                return SigninPopup();
              }
            },
          ),
        ],
      ),
    );
  }
}
