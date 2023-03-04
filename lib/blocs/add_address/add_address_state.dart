// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_address_cubit.dart';

enum AddAddressStatus { initial, submitting, success, error }

class AddAddressState extends Equatable {
  final AddAddressStatus status;
  final CustomError error;
  final Address address;
  AddAddressState({
    required this.status,
    required this.error,
    required this.address,
  });

  // initial address state
  factory AddAddressState.initial() {
    return AddAddressState(
      status: AddAddressStatus.initial,
      error: CustomError(),
      address: Address(
        id: '',
        name: '',
        address: '',
        address2: '',
        city: '',
        state: '',
        zipCode: '',
        phoneNumber: '',
      ),
    );
  }

  @override
  List<Object> get props => [status, error, address];

  AddAddressState copyWith({
    AddAddressStatus? status,
    CustomError? error,
    Address? address,
  }) {
    return AddAddressState(
      status: status ?? this.status,
      error: error ?? this.error,
      address: address ?? this.address,
    );
  }

  @override
  bool get stringify => true;
}
