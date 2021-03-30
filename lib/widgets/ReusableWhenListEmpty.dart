import 'package:flutter/material.dart';

class ReusableWhenListEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No new notes here yet\nWhy not add something 😎',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: 400,
                height: 400,
                child: Image.asset(
                  'assets/images/sticky_note.png',
                  fit: BoxFit.cover,
                )),
          ],
        ),
      ),
    );
  }
}
