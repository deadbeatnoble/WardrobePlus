import 'dart:io';
import 'package:WardrobePlus/core/di/injection_container.dart';
import 'package:WardrobePlus/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/domain/usecases/load_wardrobe_items.dart';
import 'package:WardrobePlus/features/wardrobe/domain/usecases/save_wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_bloc.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_event.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_state.dart';
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
  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthBloc>().getCurrentUserId();
    if (userId != null) {
      BlocProvider.of<WardrobeBloc>(
        context,
      ).add(LoadWardrobeItemEvent(userId: userId));
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null && context.mounted) {
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder:
              (context) => BlocProvider.value(
                value: BlocProvider.of<WardrobeBloc>(context),
                child: AddItemPage(imagePath: pickedImage.path),
              ),
        ),
      );

      if (result == true) {
        final userId = context.read<AuthBloc>().getCurrentUserId();
        if (userId != null) {
          context.read<WardrobeBloc>().add(
            LoadWardrobeItemEvent(userId: userId),
          );
        }
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
            BlocBuilder<WardrobeBloc, WardrobeState>(
              builder: (context, state) {
                if (state is WardrobeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WardrobeItemsLoaded) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: state.items.length,
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
                            File(state.items[index].imagePath),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Text("Invalid Image"));
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is WardrobeFailure) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text("No items found!"));
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
