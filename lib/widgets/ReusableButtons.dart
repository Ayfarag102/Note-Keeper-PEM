// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:note_keeper_app/utils/db_helper.dart';
// import './../models/Note.dart';
// import "./../views/NoteDetail.dart";

// class ReusableButtons extends StatefulWidget {
//   var _formKey = GlobalKey<FormState>();

//   ReusableButtons(this._formKey);

//   @override
//   _ReusableButtonsState createState() => _ReusableButtonsState();
// }

// class _ReusableButtonsState extends State<ReusableButtons> {
//   var _formKey = GlobalKey<FormState>();
//   Note note;
//   DBHelper dbHelper = DBHelper();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                     Theme.of(context).primaryColor),
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//               ),
//               onPressed: () {
//                 setState(() {
//                   debugPrint('Save Button Pressed');
//                   if (_formKey.currentState.validate()) {
//                     this._save();
//                   }
//                 });
//               },
//               child: Text(
//                 'Save',
//                 style: TextStyle(fontWeight: FontWeight.w800),
//               ),
//             ),
//           ),
//           Container(width: 5.0),
//           Expanded(
//             child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       Theme.of(context).primaryColor),
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.white),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     debugPrint('Delete Button Pressed');
//                     widget._deleteHandler();
//                   });
//                 },
//                 child: Text('Delete',
//                     style: TextStyle(fontWeight: FontWeight.w800))),
//           )
//         ],
//       ),
//     );
//   }

  
// }
