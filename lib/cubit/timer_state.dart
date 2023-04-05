part of 'timer_cubit.dart';

abstract class TimerState extends Equatable {
  final double? elasped;
  const TimerState(this.elasped);

}

class TimerInitial extends TimerState {
  const TimerInitial():super(0);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TimerProgress extends TimerState{
  const TimerProgress(double? elapsed): super(elapsed);

  @override
  // TODO: implement props
  List<Object?> get props => [elasped];
}