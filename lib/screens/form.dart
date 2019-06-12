import 'package:flutter/material.dart';

class NewTodoForm extends StatefulWidget {
  @override
  _NewTodoFormState createState() => _NewTodoFormState();
}

class _NewTodoFormState extends State<NewTodoForm> {
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              labelText: 'Title'
          ),
          controller: _controller,
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Create New Item'),
                onPressed: () {
                  Navigator.pop(context, _controller.text);
                }
            ),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
