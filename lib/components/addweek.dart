import 'package:flutter/material.dart';

class AddWeek extends StatefulWidget {
  final Function done;

  AddWeek(this.done);

  @override
  _AddWeekState createState() => _AddWeekState(done);
}

class _AddWeekState extends State<AddWeek> {
  Function done;
  TextEditingController controller = TextEditingController();
  bool copy = true;

  _AddWeekState(this.done);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Week"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Week name...",
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("Copy Periods from Previous"),
              Checkbox(
                value: copy,
                onChanged: (value) {
                  setState(() {
                    copy = value ?? true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            done(controller.text, copy);
          },
          child: Text("Add"),
        )
      ],
    );
  }
}
