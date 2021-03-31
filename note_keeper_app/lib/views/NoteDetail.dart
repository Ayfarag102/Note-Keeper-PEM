import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_keeper_app/widgets/ReusableCard.dart';
import 'package:note_keeper_app/widgets/ReusableDropDown.dart';
import 'package:note_keeper_app/widgets/ReusableDescriptionFormField.dart';
import 'package:note_keeper_app/widgets/ReusableTitleFormField.dart';
import './../models/Note.dart';
import './../utils/db_helper.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;
  Note note;
  List<String> images;

  NoteDetail(
    this.note,
    this.appBarTitle,
    this.images,
  );
  @override
  _NoteDetailState createState() =>
      _NoteDetailState(this.note, this.appBarTitle, this.images);
}

class _NoteDetailState extends State<NoteDetail> {
  var _formKey = GlobalKey<FormState>();
  DBHelper dbHelper = DBHelper();
  String appBarTitle;
  Note note;
  List<String> images;

  _NoteDetailState(this.note, this.appBarTitle, this.images);

  /// Priority and Emotional Management =/= Time Management

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            appBarTitle,
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                ReusableDropDown(this.note),
                ReusableCard(this.note, this.images),
                ReusableTitleFormField(this.note),
                ReusableDescriptionFormField(this.note),
                getButtonsRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _onDropDownPriorityItemSelected(String prior) {
  //   setState(() {
  //     this._currentChosenPriority = prior;
  //   });
  // }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  Widget getButtonsRow() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                setState(() {
                  debugPrint('Save Button Pressed');
                  if (_formKey.currentState.validate()) {
                    _save();
                  }
                });
              },
              child: Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Container(width: 5.0),
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    debugPrint('Delete Button Pressed');
                    _delete();
                  });
                },
                child: Text('Delete',
                    style: TextStyle(fontWeight: FontWeight.w800))),
          )
        ],
      ),
    );
  }

  void _save() async {
    moveToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await dbHelper.updateNote(note);
    } else {
      result = await dbHelper.insertNote(note);
      debugPrint(note.toString());
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else
      _showAlertDialog('Status', 'Problem Saving Note');
  }

  void _delete() async {
    moveToLastScreen();
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was Deleted');
      return;
    }

    int result = await dbHelper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else
      _showAlertDialog('Status', 'Error Occurred while Deleting Note');
  }

  void _showAlertDialog(String title, String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
