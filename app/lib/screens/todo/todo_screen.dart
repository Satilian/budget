import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../constants/constants.dart' as constants;
import '../../modules/modules.dart';
import '../../widgets/widgets.dart';
import 'todo_form.dart';
import 'todo_list.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const UserMenu(title: 'Todo')),
      body: Column(
        children: [
          Expanded(child: FormBuilder(child: TodoList())),
          AddBtn(
            label: 'Todo',
            iconSrc: constants.icons.aim,
            onTap: () async {
              final result = await showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                isScrollControlled: true,
                builder: (context) => Modal(child: TodoForm()),
              );

              if (result != null && context.mounted) {
                context.read<TodoBloc>().add(AddTodo(
                      category: result['category']?.toString().trim(),
                      expense: result['expense']?.toString().trim() ?? '',
                      value: result['value']?.toString().trim(),
                    ));
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
