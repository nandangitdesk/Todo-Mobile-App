import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  final bool isChecked;
  final String todoText;

  final Function(bool?)? onChanged;
  final Function(BuildContext)? onPressed;

  const TodoItem({
    super.key,
    required this.isChecked,
    required this.todoText,
    required this.onChanged,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onPressed,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: Colors.deepPurple),
          ),
          child: Row(
            children: [
              Checkbox(value: isChecked, onChanged: onChanged),
              Text(
                todoText,
                style: TextStyle(
                  fontSize: 18,
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: isChecked ? Colors.grey : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
