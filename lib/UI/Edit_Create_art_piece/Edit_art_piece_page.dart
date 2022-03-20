import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Edit_art_piece extends StatefulWidget {
  const Edit_art_piece({Key? key}) : super(key: key);

  @override
  _Edit_art_pieceState createState() => _Edit_art_pieceState();
}

class _Edit_art_pieceState extends State<Edit_art_piece> {
  String? _name;
  String? _description;

  // String _imageUrl;
  // String _category;
  // List<String> _imageUrls;
  // int _discount;
  // DateTime _startTime;
  // DateTime _finishTime;
  // int _ownerId;
  // String _ownerName;
  // int _price;
  // String _status;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is empty';
        }
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  // Widget _buildDescriptionField(){
  //   return null;
  // }
  // Widget _buildCategoryField(){
  //   return null;
  // }
  // Widget _buildImageUrlField(){
  //   return null;
  // }
  // Widget _buildNameField(){
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height(),
      width: context.width(),
      margin: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Name is empty';
                }
              },
              onSaved: (String? value) {
                _name = value;
              },
            ),
            // _buildDescriptionField(),
            // _buildCategoryField(),
            // _buildImageUrlField(),
            const SizedBox(
              height: 100,
            ),
            RaisedButton(
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              onPressed: () => {
                if (!_formKey.currentState!.validate()) {},
                _formKey.currentState!.save()
              },
            ),
          ],
        ),
      ),
    );
  }
}
