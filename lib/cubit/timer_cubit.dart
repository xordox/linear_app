import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerInitial());
  bool isPressed = false;

  Timer? _timer;

  startTimer([double? time]){
    if(time !=null){
      emit(TimerProgress(time));
    }else {
      emit(const TimerProgress(0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1)
    ,onTick);
  }

  checkIsPressed(double increaseVal){

      log("isPressed: $isPressed");
    if( isPressed == false){
      emit(TimerProgress(state.elasped! + increaseVal));
      if(state is TimerProgress){
      TimerProgress tp = state as TimerProgress;
      if(tp.elasped! <5){
        emit(TimerProgress(tp.elasped! +1));
      }else{
        _timer!.cancel();
        //emit(const TimerInitial());
      }
    }
      isPressed = true;
      log("isPressed: $isPressed");
      //emit(TimerInitial());
    }
  }

  onTick(Timer timer){
    if(state is TimerProgress){
      TimerProgress tp = state as TimerProgress;
      if(tp.elasped! <5){
        emit(TimerProgress(tp.elasped! +1));
      }else{
        _timer!.cancel();
        emit(const TimerInitial());
      }
    }
  }
}
