// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'address_list_cubit.dart';

enum AddressListStatus { initial, loading, success, error }

class AddressListState extends Equatable {
  final List<Address> addresses;
  final AddressListStatus status;
  final CustomError error;
  AddressListState({
    required this.addresses,
    required this.status,
    required this.error,
  });

  // initial state
  factory AddressListState.initial() {
    return AddressListState(
      addresses: [],
      status: AddressListStatus.initial,
      error: CustomError(),
    );
  }
  @override
  List<Object> get props => [addresses, status, error];

  @override
  bool get stringify => true;

  AddressListState copyWith({
    List<Address>? addresses,
    AddressListStatus? status,
    CustomError? error,
  }) {
    return AddressListState(
      addresses: addresses ?? this.addresses,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
