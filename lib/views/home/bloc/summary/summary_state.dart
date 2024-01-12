part of 'summary_bloc.dart';

enum SummaryStatus { initial, loading, failed, success }

class SummaryState extends Equatable {
  const SummaryState({
    this.status,
    this.message,
    this.summaryModel,
  });

  final SummaryStatus? status;
  final String? message;
  final NewsSummaryModel? summaryModel;

  // ignore: prefer_constructors_over_static_methods
  static SummaryState initial() => const SummaryState(
        status: SummaryStatus.initial,
      );

  SummaryState copyWith({
    SummaryStatus? status,
    String? message,
    NewsSummaryModel? summaryModel,
  }) {
    return SummaryState(
      status: status ?? this.status,
      message: message ?? this.message,
      summaryModel: summaryModel ?? this.summaryModel,
    );
  }

  @override
  List<Object?> get props => [status, message, summaryModel];
}
