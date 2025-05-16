import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';

class SupabaseWardrobeDatasource {
  final SupabaseClient supabase;

  SupabaseWardrobeDatasource(this.supabase);

  Future<void> saveWardrobeItem(String userId, WardrobeItem item) async {
    final String filePath = 'images/${DateTime.now().millisecondsSinceEpoch}';
    final File file = File(item.imageUrl);

    await supabase.storage.from('wardrobe-images').upload(filePath, file);

    final imageUrl = supabase.storage
        .from('wardrobe-images')
        .getPublicUrl(filePath);

    await supabase.from('wardrobe_items').insert({
      'user_id': userId,
      'image_url': imageUrl,
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
        imageUrl: item['image_url'],
        category: item['category'],
      );
    }).toList();
  }
}
