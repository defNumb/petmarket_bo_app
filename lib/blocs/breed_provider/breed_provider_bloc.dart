import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petmarket_bo_app/repositories/dog_api.dart';

import '../../models/custom_error.dart';
import '../../repositories/cat_api.dart';

part 'breed_provider_event.dart';
part 'breed_provider_state.dart';

class BreedProviderBloc extends Bloc<BreedProviderEvent, BreedProviderState> {
  final DogApiRepository dogApiRepository;
  final CatApiRepository catApiRepository;

  BreedProviderBloc({required this.catApiRepository, required this.dogApiRepository})
      : super(BreedProviderState.initial()) {
    on<BreedProviderGetCatApiEvent>(
      (event, emit) async {
        emit(state.copyWith(status: BreedProviderStatus.loading));
        try {
          final breeds = await catApiRepository.getCatBreeds();
          emit(
            state.copyWith(
              status: BreedProviderStatus.success,
              breeds: breeds,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              status: BreedProviderStatus.error,
              error: CustomError(
                message: e.toString(),
              ),
            ),
          );
        }
      },
    );

    on<BreedProviderGetDogApiEvent>(
      (event, emit) async {
        emit(
          state.copyWith(status: BreedProviderStatus.loading),
        );
        try {
          final breeds = await dogApiRepository.getDogBreeds();
          emit(
            state.copyWith(
              status: BreedProviderStatus.success,
              breeds: breeds,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              status: BreedProviderStatus.error,
              error: CustomError(
                message: e.toString(),
              ),
            ),
          );
        }
      },
    );

    // other breed provider event which returns an empty list
    on<BreedProviderSetBreedsEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: BreedProviderStatus.success,
            breeds: [],
          ),
        );
      },
    );
  }
}
