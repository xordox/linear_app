import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerInitial());

  

  checkIsPressed(double increaseVal){
      emit(TimerProgress(state.elasped! + increaseVal));
      if(state is TimerProgress){
      TimerProgress tp = state as TimerProgress;
        emit(TimerProgress(tp.elasped! +5));
    }
  }

}
