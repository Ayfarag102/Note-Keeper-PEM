// import 'package:flutter/material.dart';

// class ReusableChips extends StatefulWidget {
//   @override
//   _ReusableChipsState createState() => _ReusableChipsState();
// }

// class _ReusableChipsState extends State<ReusableChips> {
//    static var _reactionTitles = [
//     'Happy',
//     'Angry',
//     'In love',
//     'Sad',
//     'Surprised',
//     'Mad'
//   ];
//   List<String> reactionImages = [
//     'assets/images/happy.png',
//     'assets/images/angry.png',
//     'assets/images/in-love.png',
//     'assets/images/sad.png',
//     'assets/images/surprised.png',
//     'assets/images/mad.png'
//   ];

//    int _selectedIndex;
//       List<Widget> chips = [];
//   @override
//   Widget build(BuildContext context) {
//   return Widget _buildChips() {

//       for (int i = 0; i < _reactionTitles.length; i++) {
//         ChoiceChip choiceChip = ChoiceChip(
//           selected: _selectedIndex == i,
//           label:
//               Text(_reactionTitles[i], style: TextStyle(color: Colors.white)),
//           avatar: CircleAvatar(
//             backgroundImage: Image.asset(reactionImages[i].toString()).image,
//           ),
//           elevation: 10,
//           pressElevation: 5,
//           shadowColor: Colors.green,
//           backgroundColor: Colors.black12,
//           selectedColor: Colors.blue,
//           onSelected: (bool selected) {
//             setState(() {
//               if (selected) {
//                 _selectedIndex = i;
//                 debugPrint(
//                     '${_reactionTitles[i].toString()} = ${_selectedIndex.toString()}');
//                 updateReactionAsInt(
//                     _reactionTitles[_selectedIndex], _selectedIndex);
//               }
//             });
//           },
//         );

//         chips.add(
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: choiceChip,
//           ),
//         );
//       }
//       return ListView(
//         shrinkWrap: true,
//         // This next line does the trick.
//         scrollDirection: Axis.horizontal,
//         children: chips,
//       );
//     }
//   }
// }