import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/address_model.dart';
import '../../models/custom_error.dart';
import '../../repositories/address_repository.dart';

part 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  // address repository
  final AddressRepository addressRepository;

  AddAddressCubit({required this.addressRepository}) : super(AddAddressState.initial());

  // add address to firebase
  Future<void> addAddress(Address address) async {
    // emit submitting state
    emit(state.copyWith(status: AddAddressStatus.submitting));
    try {
      await addressRepository.addNewAddress(address);
      emit(
        state.copyWith(
          status: AddAddressStatus.success,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: AddAddressStatus.error,
          error: e,
        ),
      );
    }
  }
}
