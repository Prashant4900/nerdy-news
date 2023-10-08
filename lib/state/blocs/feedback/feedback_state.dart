part of 'feedback_bloc.dart';

sealed class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackLoading extends FeedbackState {}

final class FeedbackSubmit extends FeedbackState {}

final class FeedbackError extends FeedbackState {
  const FeedbackError({required this.message});

  final String message;

  @override
  List<Object> get props => [super.props, message];
}
