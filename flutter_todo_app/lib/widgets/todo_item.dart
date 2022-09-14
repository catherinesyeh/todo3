// todo item widget
import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../constants/colors.dart';

class TodoItem extends StatelessWidget {
  final Todo todo; // create todo model object
  final onTodoChanged;
  final onDeleteItem;

  // require each todo item to have todo model object, and state changing methods
  const TodoItem(
      {Key? key,
      required this.todo,
      required this.onTodoChanged,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // add spacing between each todo item
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          //print('Clicked on Todo Item.');
          onTodoChanged(todo); // switch state of todo item
        },
        shape: RoundedRectangleBorder(
          // create rounded shape for each todo item
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        // add checkbox to the left of each item
        leading: Icon(
          // change icon depending on whether todo is done
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          // todo item text
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            // cross out items that are done
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
            // adjust size and padding of delete icon
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 8),
            height: 35,
            width: 34,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              // delete icon to the right of each item
              color: Colors.white,
              iconSize: 16,
              icon: Icon(Icons.delete),
              onPressed: () {
                //print("Clicked on delete icon.");
                onDeleteItem(todo.id);
              },
            )),
      ),
    );
  }
}
