import 'package:flutter/material.dart';
import './../models/Note.dart';

class ReusableDescriptionFormField extends StatelessWidget {
  Note note;
  ReusableDescriptionFormField(this.note);
  var descriptionHintTxt = 'Enter Description';
  var descriptionLblTxt = 'Description';
  TextEditingController _descriptionTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _descriptionTextController.text = note.description;
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: TextFormField(
        controller: _descriptionTextController,
        style: TextStyle(fontWeight: FontWeight.w700),
        onChanged: (val) {
          debugPrint('Something changed in the Description TextField');
          updateDescription();
        },
        validator: (String val) {
          if (val.isEmpty) {
            return 'Please enter a $descriptionLblTxt';
          }
          return null;
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.w700,
          ),
          labelText: descriptionLblTxt,
          labelStyle:
              TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5),
          hintText: descriptionHintTxt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  void updateDescription() {
    note.description = _descriptionTextController.text;
  }
}
