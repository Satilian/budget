import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/modules.dart';
import '../../widgets/widgets.dart';
import 'todo_detail_screen.dart';
import 'todo_form.dart';

class TodoCards extends StatelessWidget {
  const TodoCards({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TodoBloc>().state;
    final cards = state.cards;

    if (cards.isEmpty) {
      return const Center(child: Text('Todo list is empty. Add some cards!'));
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 44,
        mainAxisExtent: 200,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];

        return _TodoCardTile(card: card, index: index);
      },
    );
  }
}

class _TodoCardTile extends StatelessWidget {
  const _TodoCardTile({required this.card, required this.index});

  final TodoCard card;
  final int index;

  @override
  Widget build(BuildContext context) {
    final items = card.items;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDetailScreen(
              cardId: card.id,
              title: 'Todo ${index + 1}',
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow,
              offset: const Offset(0, 3),
              blurRadius: 6,
            ),
          ],
          border: Border.all(color: theme.colorScheme.primary),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Todo ${index + 1}',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () async {
                    final result =
                        await showModalBottomSheet<Map<String, dynamic>>(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Modal(child: TodoForm()),
                    );

                    if (result != null && context.mounted) {
                      context.read<TodoBloc>().add(AddTodoItem(
                            cardId: card.id,
                            category: result['category']?.toString().trim(),
                            expense: result['expense']?.toString().trim() ?? '',
                            value: result['value']?.toString().trim(),
                          ));
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              child: _TodoPreview(items: items),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodoPreview extends StatelessWidget {
  const _TodoPreview({super.key, required this.items});

  final List<TodoItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = math.min(5, items.length);

    if (count == 0) {
      return Center(
        child: Text(
          'No items',
          style: TextStyle(color: theme.colorScheme.primary),
        ),
      );
    }

    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        final item = items[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            item.expense,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              decoration: item.isCompleted ? TextDecoration.lineThrough : null,
              color: item.isCompleted ? Colors.grey : theme.primaryColor,
            ),
          ),
        );
      },
    );
  }
}
