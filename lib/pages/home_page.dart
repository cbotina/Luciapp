import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/user_container.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authControllerProvider).userId;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/imagotype_light.png',
          height: 30,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: ref.read(authControllerProvider.notifier).logOut,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sunny),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          UserContainer(userId: userId),
        ],
      ),
    );
  }
}
