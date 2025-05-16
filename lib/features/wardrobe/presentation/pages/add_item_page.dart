import 'dart:io';
import 'package:WardrobePlus/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:WardrobePlus/features/wardrobe/domain/entities/wardrobe_item.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_bloc.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_event.dart';
import 'package:WardrobePlus/features/wardrobe/presentation/blocs/wardrobe_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemPage extends StatefulWidget {
  final String imagePath;

  const AddItemPage({super.key, required this.imagePath});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final List<String> categories = [
    'Top',
    'Bottom',
    'Shoes',
    'Accessory',
    'Outerwear',
  ];
  String? _selectedCategory;

  void _save() async {
    final userId = context.read<AuthBloc>().getCurrentUserId();
    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not logged in')));
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a category')));

      return;
    }

    final newItem = WardrobeItem(
      imageUrl: widget.imagePath,
      category: _selectedCategory!,
    );

    context.read<WardrobeBloc>().add(
      SaveWardrobeItemEvent(userId: userId, item: newItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WardrobeBloc, WardrobeState>(
      listener: (context, state) {
        if (state is WardrobeItemSaved) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pop(context, true);
        } else if (state is WardrobeFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.only(
            top: 100,
            right: 32,
            left: 32,
            bottom: 50,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: Image.file(File(widget.imagePath))),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      items:
                          categories
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Category',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  BlocBuilder<WardrobeBloc, WardrobeState>(
                    builder: (context, state) {
                      if (state is WardrobeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: _save,
                        child: const Text("Save"),
                      );
                    },
                  ),
                ],
              ),
              Material(
                shape: const CircleBorder(),
                elevation: 4,
                color: Colors.white.withOpacity(0.8),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.navigate_before, size: 28),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
