import 'package:flutter/material.dart';
import 'package:note_keeper_app/models/Note.dart';
import 'package:note_keeper_app/models_providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ReusableCard extends StatefulWidget {
  Note note;
  List<String> images = [];
  ReusableCard(this.note, this.images);
  @override
  _ReusableCardState createState() =>
      _ReusableCardState(this.note, this.images);
}

class _ReusableCardState extends State<ReusableCard> {
  Note note;
  int _selectedIndex;
  final _reactionTitles = [
    'Happy', //1/0
    'Angry', //2/1
    'In love', //3/2
    'Sad', //4/3
    'Surprised', //5/4
    'Mad', //6/5
    'N/A' //7/6
  ];
  List<String> images = [];
  _ReusableCardState(this.note, this.images);

  @override
  Widget build(BuildContext context) {
    // _selectedIndex = note.reaction;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 5,
              child: Image.asset(
                "./assets/images/bg.jpg",
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                child: Column(
                  children: [
                    Text("How do you feel about this task?"),
                    Container(width: 5.0),
                    Container(height: 50, child: _buildChips()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChips() {
    // _selectedIndex = note.reaction;
    final themeProvider = Provider.of<ThemeProvider>(context);
    List<Widget> chips = [];

    for (int i = 0; i < _reactionTitles.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_reactionTitles[i],
            style: TextStyle(
                color: themeProvider.isLightTheme
                    ? Color(0xFF1E1F28)
                    : Colors.white)),
        avatar: CircleAvatar(
          backgroundImage: Image.asset(images[i].toString()).image,
          // backgroundColor: Colors.transparent,
        ),
        elevation: 10,
        selectedColor: Colors.blue,
        pressElevation: 5,
        shadowColor: null,
        backgroundColor: Colors.black12,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;

              updateReactionAsInt(_reactionTitles[_selectedIndex]);
            }
          });
        },
      );

      chips.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: choiceChip,
        ),
      );
    }
    return ListView(
      shrinkWrap: true,
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  void updateReactionAsInt(String val) {
    switch (val) {
      case 'Happy':
        note.reaction = 1;
        break;
      case 'Angry':
        note.reaction = 2;
        break;
      case 'In love':
        note.reaction = 3;
        break;
      case 'Sad':
        note.reaction = 4;
        break;
      case 'Surprised':
        note.reaction = 5;
        break;
      case 'Mad':
        note.reaction = 6;
        break;
      case 'N/A':
        note.reaction = 7;
        break;
      default:
        return null;
    }
  }

  // String getReactionTitleAsString(int val) {
  //   String title;
  //   switch (val) {
  //     case 1:
  //       title = _reactionTitles[0];
  //       break;
  //     case 2:
  //       title = _reactionTitles[1];
  //       break;
  //     case 3:
  //       title = _reactionTitles[2];
  //       break;
  //     case 4:
  //       title = _reactionTitles[3];
  //       break;
  //     case 5:
  //       title = _reactionTitles[4];
  //       break;
  //     case 6:
  //       title = _reactionTitles[5];
  //       break;
  //     case 7:
  //       title = _reactionTitles[6];
  //       break;
  //     default:
  //       return null;
  //   }
  //   return title;
  // }
}
