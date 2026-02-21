import 'package:flutter/material.dart';

class TodoItem {
  String? category;
  String expense;
  String? value;
  bool isCompleted;

  TodoItem({
    required this.category,
    required this.expense,
    this.value,
    this.isCompleted = false,
  });
}

class TodoList extends StatelessWidget {
  final List<TodoItem> items;
  final void Function(int) onToggle;
  final void Function(int) onDelete;

  const TodoList({
    super.key,
    required this.items,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Center(
            child: Text(
              'Todo list is empty. Add some items!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: Checkbox(
                  value: item.isCompleted,
                  onChanged: (_) => onToggle(index),
                ),
                title: Text(
                  item.expense,
                  style: TextStyle(
                    decoration:
                        item.isCompleted ? TextDecoration.lineThrough : null,
                    color: item.isCompleted ? Colors.grey : null,
                  ),
                ),
                subtitle: item.category != null || item.value != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.category != null &&
                              item.category!.isNotEmpty)
                            Text(
                              'Категория: ${item.category}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          if (item.value != null && item.value!.isNotEmpty)
                            Text(
                              'Значение: ${item.value}',
                              style: const TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      )
                    : null,
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(index),
                ),
              );
            },
          );
  }
}
