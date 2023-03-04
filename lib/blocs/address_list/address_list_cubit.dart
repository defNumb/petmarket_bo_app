import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/address_model.dart';
import '../../models/custom_error.dart';
import '../../repositories/address_repository.dart';

part 'address_list_state.dart';

class AddressListCubit extends Cubit<AddressListState> {
  final AddressRepository addressRepository;
  AddressListCubit({required this.addressRepository})
      : super(
          AddressListState.initial(),
        );

  // get address list
  Future<void> getAddressList() async {
    emit(state.copyWith(status: AddressListStatus.loading));
    try {
      final List<Address> addressList = await addressRepository.getAddressList();
      emit(state.copyWith(
        status: AddressListStatus.success,
        addresses: addressList,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: AddressListStatus.error,
        error: e,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AddressListStatus.error,
        error: CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error.getAddressList',
        ),
      ));
    }
  }

  // remove address
  Future<void> removeAddress(String addressId) async {
    emit(state.copyWith(status: AddressListStatus.loading));
    try {
      await addressRepository.removeAddress(addressId: addressId);
      final List<Address> addressList = await addressRepository.getAddressList();
      emit(state.copyWith(
        status: AddressListStatus.success,
        addresses: addressList,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: AddressListStatus.error,
        error: e,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AddressListStatus.error,
        error: CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error.removeAddress',
        ),
      ));
    }
  }
}
