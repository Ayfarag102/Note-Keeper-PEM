import 'package:flutter/material.dart';
import 'package:note_keeper_app/models/Note.dart';

class ReusableTitleFormField extends StatelessWidget {
  Note note;
  ReusableTitleFormField(this.note);
  var titleHintTxt = 'Enter Title';
  var titleLblTxt = 'Title';

  TextEditingController _titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleTextController.text = note.title;
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: TextFormField(
        controller: _titleTextController,
        style: TextStyle(fontWeight: FontWeight.w700),
        onChanged: (val) {
          debugPrint('Something changed in the Title TextField');
          updateTitle();
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.w700,
          ),
          labelText: titleLblTxt,
          labelStyle:
              TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5),
          hintText: titleHintTxt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (String val) {
          if (val.isEmpty) {
            return 'Please enter a $titleLblTxt';
          }
          return null;
        },
      ),
    );
  }

  void updateTitle() {
    note.title = _titleTextController.text;
  }
}
