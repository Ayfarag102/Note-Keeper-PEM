// import 'package:flutter/material.dart';
// import 'package:gradient_widgets/gradient_widgets.dart';

// class ReusableNoteListView extends StatelessWidget {
//   @override
//   ListView build(BuildContext context) {
//     return ListView();
//   }
// }
// int count = 0;

// ListView getNoteListView() {
//   return ListView.builder(
//     itemCount: count,
//     itemBuilder: (BuildContext ctx, int position) {
//       return GradientCard(
//         margin: EdgeInsets.all(10),
//         gradient: Gradients.haze,
//         elevation: 10.0,
//         child: Column(
//           children: <Widget>[
//             ExpansionTile(
//               title: ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   backgroundImage:
//                       getReactionImage(this.noteList[position].reaction),
//                 ),
//                 title: Text(this.noteList[position].title,
//                     style: TextStyle(
//                       color: Colors.black,
//                     )),
//                 subtitle: Text(this.noteList[position].date,
//                     style: TextStyle(
//                       color: Colors.black,
//                     )),
//                 trailing:
//                     Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                   GestureDetector(
//                     child: Icon(
//                       Icons.delete,
//                       color: Colors.grey,
//                     ),
//                     onTap: () => _delete(ctx, noteList[position]),
//                   ),
//                 ]),
//                 onTap: () {
//                   _navigateToDetails(this.noteList[position], 'Edit Note',
//                       this.reactionImages);
//                   debugPrint("ListTile Tapped!");
//                 },
//               ),
//               // backgroundColor: Colors.grey[200],
//               children: <Widget>[getDescriptionContainer(position)],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// Container getDescriptionContainer(int p) {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//     child: Column(
//       children: <Widget>[
//         Divider(
//           color: Colors.black,
//           indent: 100.0,
//           endIndent: 100.0,
//         ),
//         Text(
//           this.noteList[p].description,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// void _delete(BuildContext ctx, Note note) async {
//   int result = await dbHelper.deleteNote(note.id);
//   if (result != 0) {
//     _showSnackBar(ctx, 'Note Deleted Successfully');
//   }
// }

//  void _showSnackBar(BuildContext ctx, String s) {
//   final snackBar = SnackBar(content: Text(s));
//   ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
//   updateListView();
// }


// ImageProvider getReactionImage(int react) {
//   switch (react) {
//     // 0
//     case 1:
//       return Image.asset(reactionImages[0].toString()).image;
//       break;

//     // 1
//     case 2:
//       return Image.asset(reactionImages[1].toString()).image;
//       break;
//     // 2
//     case 3:
//       return Image.asset(reactionImages[2].toString()).image;
//       break;
//     // 3
//     case 4:
//       return Image.asset(reactionImages[3].toString()).image;
//       break;
//     // 4
//     case 5:
//       return Image.asset(reactionImages[4].toString()).image;
//       break;
//     // 5
//     case 6:
//       return Image.asset(reactionImages[5].toString()).image;
//       break;
//     // 6
//     case 7:
//       return Image.asset(reactionImages[6].toString()).image;
//       break;
//     default:
//       return null;
//   }
// }
