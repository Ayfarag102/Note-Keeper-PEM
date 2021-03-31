import 'package:flutter/material.dart';
import 'package:note_keeper_app/models/Note.dart';
import 'package:note_keeper_app/models_providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ReusableDropDown extends StatefulWidget {
  Note note;
  ReusableDropDown(this.note);

  @override
  _ReusableDropDownState createState() => _ReusableDropDownState(this.note);
}

class _ReusableDropDownState extends State<ReusableDropDown> {
  Note note;
  _ReusableDropDownState(this.note);
  List<String> _priorities = [
    'Urgent & Important',
    'Urgent But Not Important',
    'Not Urgent But Important',
    'Not Urgent & Not Important'
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      title: Center(
        child: DropdownButtonFormField(
          items: _priorities.map((String prior) {
            return DropdownMenuItem(
                value: prior,
                child: Text(
                  prior,
                  textAlign: TextAlign.justify,
                ));
          }).toList(),
          // : Colors.green[400],
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: themeProvider.isLightTheme
                  ? Color(0xFF1E1F28)
                  : Colors.white),

          value: getPriorityAsString(note.priority),
          onChanged: (String prior) {
            setState(
              () {
                debugPrint('User Selected $prior');
                updatePriorityAsInt(prior);
              },
            );
          },
        ),
      ),
    );
  }

  void updatePriorityAsInt(String val) {
    switch (val) {
      case 'Urgent & Important':
        note.priority = 1;
        break;
      case 'Urgent But Not Important':
        note.priority = 2;
        break;
      case 'Not Urgent But Important':
        note.priority = 3;
        break;
      case 'Not Urgent & Not Important':
        note.priority = 4;
        break;
    }
  }

  String getPriorityAsString(int val) {
    String priority;
    switch (val) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
      case 3:
        priority = _priorities[2];
        break;
      case 4:
        priority = _priorities[3];
        break;
    }
    return priority;
  }
}
