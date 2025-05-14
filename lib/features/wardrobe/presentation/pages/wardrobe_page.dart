import 'dart:io';

import 'package:WardrobePlus/core/di/injection_container.dart';
import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/domain/usecases/save_wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_bloc.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/pages/add_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class WardrobePage extends StatefulWidget {
  const WardrobePage({super.key});

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  final List<WardrobeItem> items = [];

  Future<void> _pickImageFromGallery() async {

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null && context.mounted) {
      final result = await Navigator.push<WardrobeItem>(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => WardrobeBloc(saveWardrobeItem: sl<SaveWardrobeItem>()),
            child: AddItemPage(imagePath: pickedImage.path)
          ),
        ),
      );

      print("Returned: $result");

      if (result != null) {
        setState(() {
          items.add(result);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(
          top: 100,
          right: 32,
          left: 32,
          bottom: 50,
        ),
        child: Stack(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(items[index].imagePath), // Display uploaded images as File
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback for invalid images
                        return Center(child: Text("Invalid Image"));
                      },
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: Text("Add Item"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
