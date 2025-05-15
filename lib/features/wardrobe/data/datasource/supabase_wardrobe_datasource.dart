import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';

class SupabaseWardrobeDatasource {
  final SupabaseClient supabase;

  SupabaseWardrobeDatasource(this.supabase);

  Future<void> saveWardrobeItem(String userId, WardrobeItem item) async {
    await supabase.from('wardrobe_items').insert({
      'user_id': userId,
      'image_path': item.imagePath,
      'category': item.category,
      'timestamp': DateTime.now().toUtc().toIso8601String(),
    });
  }

  Future<List<WardrobeItem>> loadWardrobeItems(String userId) async {
    final List<Map<String, dynamic>> data = await supabase
        .from('wardrobe_items')
        .select()
        .eq('user_id', userId)
        .order('timestamp', ascending: false);

    return data.map((item) {
      return WardrobeItem(
        imagePath: item['image_path'],
        category: item['category'],
      );
    }).toList();
  }
}
