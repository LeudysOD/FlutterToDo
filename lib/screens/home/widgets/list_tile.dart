import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({super.key});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  
  String _value = 'personal';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
        title: Row(
          children: const [
            Icon(Icons.person_rounded,
            color: kYellowDark,
            ),
            SizedBox(width: 8),
            Text('Personal'),
          ],
        ),
        leading: Radio(
          value: 'personal',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
      ListTile(
        title: Row(
          children: const [
            Icon(Icons.work_rounded,
            color: kRedDark,
            ),
            SizedBox(width: 8),
            Text('Work'),
          ],
        ),
        leading: Radio(
          value: 'work',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
      ListTile(
        title: Row(
          children: const [
            Icon(Icons.business_rounded,
            color: kOrangeDark,
            ),
            SizedBox(width: 8),
             Text('Bussiness'),
          ],
        ),
        leading: Radio(
          value: 'bussiness',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
      ListTile(
        title: Row(
          children: const [
            Icon(Icons.favorite_rounded,
            color: kGreenDark,
            ),
            SizedBox(width: 8),
            Text('Healt')
          ],
        ),
        leading: Radio(
          value: 'healt',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
      ListTile(
        title: Row(
          children: const [
            Icon(Icons.sports_basketball_rounded,
            color: kBlueDark,
            ),
            SizedBox(width: 8),
            Text('Sport')
          ],
        ),
        leading: Radio(
          value: 'sport',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
      ],
    );
  }
}