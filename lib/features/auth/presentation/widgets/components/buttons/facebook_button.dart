import 'package:flutter/material.dart';
import 'package:luciapp/common/keys/widget_keys.dart';

class FacebookButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FacebookButton({
    super.key = Keys.facebookButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.blue.shade100,
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xff486CB4),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 3,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(
              Icons.facebook,
              size: 38,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "Continuar con Facebook",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
