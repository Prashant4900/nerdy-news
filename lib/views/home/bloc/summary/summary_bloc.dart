import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/models/news_summary.dart';
import 'package:mobile/repositories/summarize_repository.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  SummaryBloc() : super(SummaryState.initial()) {
    on<GetNewsSummary>(_getNewsSummary);
    on<ResetState>(_resetState);
  }

  final summary = getIt<SummarizeRepository>();

  FutureOr<void> _getNewsSummary(
    GetNewsSummary event,
    Emitter<SummaryState> emit,
  ) async {
    emit(const SummaryState(status: SummaryStatus.loading));
    try {
      final result = await summary.getNewsSummary(event.news);
      emit(
        SummaryState(
          summaryModel: result,
          status: SummaryStatus.success,
        ),
      );
    } catch (e) {
      final message = e.toString();
      emit(SummaryState(status: SummaryStatus.failed, message: message));
    }
  }

  FutureOr<void> _resetState(ResetState event, Emitter<SummaryState> emit) {
    emit(SummaryState.initial());
  }
}
