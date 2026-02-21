import 'package:budget/constants/icons.dart';
import 'package:budget/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

enum UserMenuItem { remove, exit }

class UserMenu extends StatelessWidget {
  const UserMenu({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<UserMenuItem>(
          icon: SvgPicture.asset(
            icons.user,
            width: 25,
            height: 25,
            theme:
                SvgTheme(currentColor: Theme.of(context).colorScheme.primary),
          ),
          onSelected: (UserMenuItem item) {
            switch (item) {
              case UserMenuItem.exit:
                context.read<AuthBloc>().add(AuthLogoutRequested());

              case UserMenuItem.remove:
                context.read<AuthBloc>().add(AuthRemoveRequested());
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<UserMenuItem>>[
            const PopupMenuItem<UserMenuItem>(
              value: UserMenuItem.remove,
              child: Text('Удалить пользователя'),
            ),
            const PopupMenuItem<UserMenuItem>(
              value: UserMenuItem.exit,
              child: Text('Выход'),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Text(title ?? ''),
          ),
        ),
        const SizedBox(width: kMinInteractiveDimension),
      ],
    );
  }
}
