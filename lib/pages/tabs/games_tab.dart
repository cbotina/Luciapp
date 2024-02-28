import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .1326,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Juegos 🎮",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Aprende mientras te diviertes",
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
      // backgroundColor: Colors.amber,
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) {
                //     return const YtVideo();
                //   },
                // ));
              },
              child: const Text("Video"))
        ],
      ),
    );
  }
}
