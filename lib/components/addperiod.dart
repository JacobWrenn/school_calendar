import 'package:flutter/material.dart';

class AddPeriod extends StatefulWidget {
  final Function done;

  AddPeriod(this.done);

  @override
  _AddPeriodState createState() => _AddPeriodState(done);
}

class _AddPeriodState extends State<AddPeriod> {
  Function done;
  TextEditingController controller = TextEditingController();
  TimeOfDay start = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay end = TimeOfDay(hour: 9, minute: 0);

  _AddPeriodState(this.done);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Period"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Period name...",
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("Start"),
              Spacer(),
              TextButton(
                onPressed: () async {
                  start = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 8, minute: 0),
                      ) ??
                      TimeOfDay(hour: 8, minute: 0);
                },
                child: Text("Pick Time"),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("End"),
              Spacer(),
              TextButton(
                onPressed: () async {
                  end = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 9, minute: 0),
                      ) ??
                      TimeOfDay(hour: 9, minute: 0);
                },
                child: Text("Pick Time"),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            done(controller.text, start, end);
          },
          child: Text("Add"),
        )
      ],
    );
  }
}
