part of 'summary_bloc.dart';

sealed class SummaryEvent extends Equatable {
  const SummaryEvent();

  @override
  List<Object> get props => [];
}

class GetNewsSummary extends SummaryEvent {
  const GetNewsSummary({required this.news});

  final NewsModel news;

  @override
  List<Object> get props => [super.props, news];
}

class ResetState extends SummaryEvent {}
