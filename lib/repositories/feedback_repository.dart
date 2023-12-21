import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:mobile/models/feedback_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template feedback}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FeedbackRepository {
  /// {@macro feedback}
  const FeedbackRepository();

  Future<String?> submitFeedback({
    required SupabaseClient client,
    required FeedbackModel model,
  }) async {
    try {
      await client
          .from('feedbacks')
          .insert(model.toJson())
          .onError((error, stackTrace) => throw Exception(error));
      return 'SUCCESS';
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> uploadImage({
    required SupabaseClient client,
    XFile? file,
  }) async {
    try {
      final arr = file!.path.split('.');
      final fileExt = arr.last;
      final imageByte = await file.readAsBytes();
      final path = 'users/unknown/${DateTime.now()}.$fileExt';
      final temp = await client.storage.from('feedback').uploadBinary(
            path,
            imageByte,
          );
      final url = client.storage.from('feedback').getPublicUrl(temp);
      return url;
    } catch (e) {
      log('$e - ${file!.path}');
      throw Exception(e);
    }
  }
}
