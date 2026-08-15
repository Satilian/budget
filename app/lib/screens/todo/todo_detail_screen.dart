import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../constants/constants.dart' as constants;
import '../../modules/modules.dart';
import '../../widgets/widgets.dart';
import 'todo_form.dart';
import 'todo_list.dart';

class TodoDetailScreen extends StatelessWidget {
  const TodoDetailScreen({
    super.key,
    required this.cardId,
    required this.title,
  });

  final String cardId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FormBuilder(
              child: TodoList(cardId: cardId),
            ),
          ),
          AddBtn(
            label: 'Добавить',
            iconSrc: constants.icons.aim,
            onTap: () async {
              final result = await showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                isScrollControlled: true,
                builder: (context) => Modal(child: TodoForm()),
              );

              if (result != null && context.mounted) {
                context.read<TodoBloc>().add(AddTodoItem(
                      cardId: cardId,
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
