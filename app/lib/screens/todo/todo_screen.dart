import 'package:flutter/material.dart';

import '../../constants/constants.dart' as constants;
import '../../modules/modules.dart';
import '../../widgets/widgets.dart';
import 'todo_form.dart';
import 'todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<TodoItem> _items = [];

  void _addItem(Map<String, dynamic> data) {
    setState(() {
      _items.add(TodoItem(
        category: data['category']?.toString().trim() ?? '',
        expense: data['expense']?.toString().trim() ?? '',
        value: data['value']?.toString().trim(),
      ));
    });
  }

  void _toggleItem(int index) {
    setState(() {
      _items[index].isCompleted = !_items[index].isCompleted;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const UserMenu(title: 'Todo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TodoList(
              items: _items,
              onToggle: _toggleItem,
              onDelete: _deleteItem,
            ),
          ),
          AddBtn(
            label: 'Todo',
            iconSrc: constants.icons.aim,
            onTap: () async {
              final result = await showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                isScrollControlled: true,
                builder: (context) => Modal(child: TodoForm()),
              );

              if (result != null) {
                _addItem(result);
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
