import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../modules/modules.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TodoBloc>().state;
    final items = state.items;

    return items.isEmpty
        ? const Center(
            child: Text('Todo list is empty. Add some items!'),
          )
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: item.isCompleted,
                        onChanged: (_) {
                          context.read<TodoBloc>().add(ToggleTodo(item.id));
                        },
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.expense,
                              style: TextStyle(
                                decoration: item.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: item.isCompleted ? Colors.grey : null,
                              ),
                            ),
                            Text(
                              item.category ?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: FormBuilderTextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            name: 'value_${item.id}',
                            initialValue: item.value,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                              final formState = FormBuilder.of(context);
                              final fieldState =
                                  formState?.fields['value_${item.id}'];
                              final newValue = fieldState?.value ?? '';
                              if (newValue != item.value) {
                                context.read<TodoBloc>().add(
                                      UpdateTodoValue(
                                        id: item.id,
                                        value: newValue,
                                      ),
                                    );
                              }
                            }),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<TodoBloc>().add(DeleteTodo(item.id));
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ));
            },
          );
  }
}
