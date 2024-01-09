import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/providers/fetch_user.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/profile_photo.dart';

class UserContainer extends ConsumerWidget {
  final UserId? userId;
  const UserContainer({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchUser = ref.watch(fetchUserProvider(userId ?? ''));
    return fetchUser.when(
      data: (user) {
        if (user != null) {
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
                        "Hola ${user.name.split(' ').first}! 👋",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("¿Listo para aprender algo nuevo?")
                    ],
                  ),
                ),
                ProfilePhoto(userId: userId)
              ],
            ),
          );
        }

        return const Text("User not found");
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
