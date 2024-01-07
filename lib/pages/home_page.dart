import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/user_info_provider.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authControllerProvider).userId;
    print(userId);
    final user = ref.watch(userInfoModelProvider(userId ?? ''));
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          user.when(
            data: (data) {
              return Column(
                children: [
                  Text(data.name),
                  Text(data.userId),
                  Text(data.age.toString()),
                  Text(data.gender.toString()),
                ],
              );
            },
            error: (error, stackTrace) => const Text("error"),
            loading: () => const CircularProgressIndicator(),
          ),
          ElevatedButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logOut();
              },
              child: const Text("Logout"))
        ],
      ),
    );
  }
}
