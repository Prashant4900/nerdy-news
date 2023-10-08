part of 'reader_mode_cubit.dart';

abstract class ReaderModeState extends Equatable {
  const ReaderModeState({required this.status});

  final bool status;

  @override
  List<Object> get props => [status];
}

class ReaderModeInitial extends ReaderModeState {
  const ReaderModeInitial({required super.status});

  @override
  List<Object> get props => [status];
}

class ReaderModeChanged extends ReaderModeState {
  const ReaderModeChanged({required super.status});

  @override
  List<Object> get props => [status];
}
