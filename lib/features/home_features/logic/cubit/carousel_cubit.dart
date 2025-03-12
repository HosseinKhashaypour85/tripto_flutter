import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<int> {
  CarouselCubit() : super(0);
  int currentIndex = 0;

  changeIndex(int index) {
    emit(currentIndex = index);
  }
}
