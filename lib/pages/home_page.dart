import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/presentation/state/providers/user_info_provider.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/presentation/state/providers/photo_url_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authControllerProvider).userId;
    final user = ref.watch(userInfoModelProvider(userId ?? ''));
    final photoUrl = ref.watch(photoUrlProvider(userId ?? ''));

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/imagotype_light.png',
          height: 30,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            ref.read(authControllerProvider.notifier).logOut();
          },
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
          user.when(
            data: (data) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 3,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hola ${data.name.split(' ').first}! 👋",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("¿Listo para aprender algo nuevo?")
                        ],
                      ),
                    ),
                    photoUrl.when(
                      data: (data) {
                        return CircleAvatar(
                          backgroundImage: Image.network(data).image,
                          radius: 30,
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) => Text(error.toString()),
                    )
                  ],
                ),
              );
            },
            error: (error, stackTrace) => const Text("error"),
            loading: () => const CircularProgressIndicator(),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
