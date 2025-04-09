import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tripto_flutter/features/change_info_features/services/change_api_repository.dart';

import 'change_event.dart';

part 'change_state.dart';

class ChangeBloc extends Bloc<ChangeEvent, ChangeState> {
  final ChangeApiRepository repository;

  ChangeBloc(this.repository) : super(ChangeInitial()) {
    on<GetUserNameEvent>((event, emit) async {
      emit(ChangeLoadingState());
      try {
        final userName = await repository.getUserNameFromServer();
        emit(ChangeUserNameLoadedState(userName));
      } catch (e) {
        emit(ChangeErrorState('Error fetching user name'));
      }
    });
  }
}