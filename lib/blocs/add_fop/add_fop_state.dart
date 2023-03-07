// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'add_fop_cubit.dart';

// addfop state enum
enum AddFopStatus { initial, submitting, success, error }

class AddFopState extends Equatable {
  final AddFopStatus status;
  final CustomError error;
  final FormOfPayment fop;
  AddFopState({
    required this.status,
    required this.error,
    required this.fop,
  });

  // initial fop state
  factory AddFopState.initial() {
    return AddFopState(
      status: AddFopStatus.initial,
      error: CustomError(),
      fop: FormOfPayment(
        id: '',
        cardName: '',
        cardNumber: '',
        cardHolderName: '',
        cardExpirationDate: '',
        cardCcv: '',
        cardType: CardType.invalid,
      ),
    );
  }
  @override
  List<Object> get props => [status, error, fop];

  @override
  bool get stringify => true;

  AddFopState copyWith({
    AddFopStatus? status,
    CustomError? error,
    FormOfPayment? fop,
  }) {
    return AddFopState(
      status: status ?? this.status,
      error: error ?? this.error,
      fop: fop ?? this.fop,
    );
  }
}
