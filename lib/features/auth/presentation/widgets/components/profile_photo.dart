import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/auth/data/providers/photo_url_provider.dart';

class ProfilePhoto extends ConsumerWidget {
  final UserId? userId;
  const ProfilePhoto({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchPhotoUrl = ref.watch(fetchPhotoUrlProvider(userId ?? ''));
    return fetchPhotoUrl.when(
      data: (photoUrl) {
        return CircleAvatar(
          foregroundImage: Image.network(photoUrl ?? "").image,
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Icon(Icons.error),
    );
  }
}
