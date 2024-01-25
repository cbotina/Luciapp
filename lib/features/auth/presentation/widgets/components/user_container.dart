import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/auth/data/providers/user_model_provider.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';
import 'package:luciapp/features/auth/presentation/widgets/components/profile_photo.dart';

class UserContainer extends ConsumerWidget {
  const UserContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.invalidate(userIdProvider);
    final userId = ref.watch(userIdProvider);
    final fetchUser = ref.watch(userModelProvider(userId ?? ''));

    log(userId.toString());

    return fetchUser.when(
      data: (user) {
        if (user != null) {
          final String readyAdjective;

          switch (user.gender) {
            case Gender.male:
              readyAdjective = Strings.readyMale;
            case Gender.female:
              readyAdjective = Strings.readyFemale;
            case Gender.nonBinary:
              readyAdjective = Strings.readyNonBinary;
          }

          return Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * .18,
              maxHeight: double.infinity,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: SizedBox(
                    width:
                        MediaQuery.of(context).size.width - 30 - 30 - 30 - 30,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${Strings.hello} ${user.name.split(' ').first}! 👋",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "$readyAdjective ${Strings.toLearnSomethingNew}",
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                ProfilePhoto(userId: userId)
              ],
            ),
          );
        }

        return const Text(Strings.somethingWentWrong);
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
