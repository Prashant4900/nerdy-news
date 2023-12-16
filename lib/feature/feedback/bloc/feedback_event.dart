part of 'feedback_bloc.dart';

sealed class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

final class FeedbackSubmitEvent extends FeedbackEvent {
  const FeedbackSubmitEvent({
    required this.model,
    required this.image,
  });

  final FeedbackModel model;
  final XFile? image;

  @override
  List<Object> get props => [super.props, model, image!];
}
