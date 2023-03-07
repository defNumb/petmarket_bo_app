part of 'fop_list_cubit.dart';

// enum state
enum FopListStatus {
  initial,
  loading,
  loaded,
  error,
}

class FopListState extends Equatable {
  final FopListStatus listStatus;
  final List<FormOfPayment> fopList;
  final CustomError error;
  FopListState({
    required this.listStatus,
    required this.fopList,
    required this.error,
  });

  // initial state
  factory FopListState.initial() {
    return FopListState(
      listStatus: FopListStatus.initial,
      fopList: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [listStatus, fopList, error];

  @override
  bool get stringify => true;

  FopListState copyWith({
    FopListStatus? listStatus,
    List<FormOfPayment>? fopList,
    CustomError? error,
  }) {
    return FopListState(
      listStatus: listStatus ?? this.listStatus,
      fopList: fopList ?? this.fopList,
      error: error ?? this.error,
    );
  }
}
