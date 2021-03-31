import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:note_keeper_app/widgets/ReusableWhenListEmpty.dart';

import 'package:note_keeper_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import './../models_providers/theme_provider.dart';
import './../models/Note.dart';
import './../utils/db_helper.dart';
import './../views/NoteDetail.dart';

//import 'NoteDetail.dart';

class NoteList extends StatefulWidget {
  NoteList();
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int count = 0;

  DBHelper dbHelper = DBHelper();
  List<Note> noteList;
  List<String> values = ['Light', 'Dark'];

  List<String> reactionImages = [
    'assets/images/happy.png',
    'assets/images/angry.png',
    'assets/images/in-love.png',
    'assets/images/sad.png',
    'assets/images/surprised.png',
    'assets/images/mad.png',
    'assets/images/na_react.png'
  ];

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = <Note>[];
      updateListView();
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Notes',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                )),
          ],
        ),
      ),
      drawer: MainDrawer(width),
      body: noteList.isEmpty ? ReusableWhenListEmpty() : getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToDetails(Note('', '', 2), 'Add Note', this.reactionImages);
          debugPrint('FAB Clicked!');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext ctx, int position) {
        return GradientCard(
          margin: EdgeInsets.all(10),
          gradient: Gradients.haze,
          elevation: 10.0,
          child: Column(
            children: <Widget>[
              ExpansionTile(
                title: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        getReactionImage(this.noteList[position].reaction),
                  ),
                  title: Text(this.noteList[position].title,
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  subtitle: Text(this.noteList[position].date,
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  trailing:
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      onTap: () => _delete(ctx, noteList[position]),
                    ),
                  ]),
                  onTap: () {
                    _navigateToDetails(this.noteList[position], 'Edit Note',
                        this.reactionImages);
                    debugPrint("ListTile Tapped!");
                  },
                ),
                // backgroundColor: Colors.grey[200],
                children: <Widget>[getDescriptionContainer(position)],
              ),
            ],
          ),
        );
      },
    );
  }

  Container getDescriptionContainer(int p) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.black,
            indent: 100.0,
            endIndent: 100.0,
          ),
          Text(
            this.noteList[p].description,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  void _delete(BuildContext ctx, Note note) async {
    int result = await dbHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(ctx, 'Note Deleted Successfully');
    }
  }

  ImageProvider getReactionImage(int react) {
    switch (react) {
      // 0
      case 1:
        return Image.asset(reactionImages[0].toString()).image;
        break;

      // 1
      case 2:
        return Image.asset(reactionImages[1].toString()).image;
        break;
      // 2
      case 3:
        return Image.asset(reactionImages[2].toString()).image;
        break;
      // 3
      case 4:
        return Image.asset(reactionImages[3].toString()).image;
        break;
      // 4
      case 5:
        return Image.asset(reactionImages[4].toString()).image;
        break;
      // 5
      case 6:
        return Image.asset(reactionImages[5].toString()).image;
        break;
      // 6
      case 7:
        return Image.asset(reactionImages[6].toString()).image;
        break;
      default:
        return null;
    }
  }

  void _navigateToDetails(
      Note note, String pgName, List<String> reactImgs) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return NoteDetail(note, pgName, reactImgs);
        },
      ),
    );
    if (result == true) {
      updateListView();
    }
  }

  void _showSnackBar(BuildContext ctx, String s) {
    final snackBar = SnackBar(content: Text(s));
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initiateDB();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = dbHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
