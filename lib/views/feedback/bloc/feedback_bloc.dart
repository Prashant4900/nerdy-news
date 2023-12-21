import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/models/feedback_model.dart';
import 'package:mobile/repositories/feedback_repository.dart';
import 'package:mobile/utils/supabase_config.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<FeedbackSubmitEvent>(_submitFeedback);
  }

  final feedback = getIt<FeedbackRepository>();
  final client = getIt<SupabaseConfig>().client;

  FutureOr<void> _submitFeedback(
    FeedbackSubmitEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(FeedbackLoading());
    try {
      final imageUrl =
          await feedback.uploadImage(file: event.image, client: client);
      final model = FeedbackModel(
        title: event.model.title,
        message: event.model.message,
        image: imageUrl,
        createdAt: event.model.createdAt,
        updatedAt: event.model.updatedAt,
        buildNo: '0.0.1',
      );
      final result = await feedback.submitFeedback(
        client: client,
        model: model,
      );
      if (result == 'SUCCESS') {
        emit(FeedbackSubmit());
      } else {
        emit(const FeedbackError(message: 'Something went wrong'));
      }
    } catch (e) {
      emit(FeedbackError(message: e.toString()));
    }
  }
}
