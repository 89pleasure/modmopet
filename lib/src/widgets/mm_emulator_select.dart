import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modmopet/src/provider/emulator_provider.dart';
import 'package:modmopet/src/screen/games/game_list_view.dart';
import 'package:modmopet/src/widgets/mm_evelated_button.dart';

class MMEmulatorSelect extends HookConsumerWidget {
  final String emulatorId;
  final Map<String, dynamic> supportedEmulatorMetadata;
  const MMEmulatorSelect({
    required this.emulatorId,
    required this.supportedEmulatorMetadata,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Image(
          image: AssetImage('assets/images/emulator/$emulatorId.png'),
          width: 82,
          height: 82,
        ),
        const SizedBox(height: 35),
        MMElevatedButton.primary(
          onPressed: () {
            bool withCustomSelect = false;

            // On macos this needs to be always true in sandbox mode to get access to directories outside of sandbox container
            // if (Platform.isMacOS) withCustomSelect = true;

            ref.read(selectedEmulatorIdProvider.notifier).state = emulatorId;
            ref.read(withCustomSelectProvider.notifier).state = withCustomSelect;
            Navigator.of(context).pushReplacementNamed(GameListView.routeName);
          },
          child: Text(supportedEmulatorMetadata['name']),
        ),
        const SizedBox(height: 10.0),
        if (Platform.isMacOS == false)
          MMElevatedButton.secondary(
            onPressed: () {
              ref.read(selectedEmulatorIdProvider.notifier).state = emulatorId;
              ref.read(withCustomSelectProvider.notifier).state = true;
              Navigator.of(context).pushReplacementNamed(GameListView.routeName);
            },
            child: const Text('Select manually'),
          ),
      ],
    );
  }
}
