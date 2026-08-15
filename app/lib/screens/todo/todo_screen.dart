import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../constants/constants.dart' as constants;
import '../../modules/modules.dart';
import '../../widgets/widgets.dart';
import 'todo_cards.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const UserMenu(title: 'Todo')),
      body: Column(
        children: [
          Expanded(child: FormBuilder(child: TodoCards())),
          AddBtn(
            label: 'Todo',
            iconSrc: constants.icons.aim,
            onTap: () async {
              context.read<TodoBloc>().add(AddTodoCard());
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
