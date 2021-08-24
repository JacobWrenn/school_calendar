import 'package:flutter/material.dart';

class FillPeriod extends StatefulWidget {
  final Function done;

  FillPeriod(this.done);

  @override
  _FillPeriodState createState() => _FillPeriodState(done);
}

class _FillPeriodState extends State<FillPeriod> {
  Function done;
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  _FillPeriodState(this.done);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Fill Period"),
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
          TextField(
            controller: controller2,
            decoration: InputDecoration(
              hintText: "Period location...",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            done(controller.text, controller2.text);
          },
          child: Text("Fill"),
        )
      ],
    );
  }
}
