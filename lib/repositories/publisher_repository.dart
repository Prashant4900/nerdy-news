import 'package:mobile/models/publisher_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PublisherRepository {
  const PublisherRepository();

  Future<List<PublisherModel>?> getAllPublishers({
    required SupabaseClient client,
  }) async {
    try {
      final result = await client
          .from('publisher')
          .select<List<Map<String, dynamic>>>()
          .filter('enable', 'eq', true)
          .onError((error, stackTrace) => throw Exception(error));

      return result.map(PublisherModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
