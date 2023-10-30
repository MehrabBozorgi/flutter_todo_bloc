import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_index_state.dart';

class ChangeIndexCubit extends Cubit<bool> {
  ChangeIndexCubit() : super(false);

  bool isDone = false;

  changeIndex(bool value) {
    emit(isDone = value);
  }
}
