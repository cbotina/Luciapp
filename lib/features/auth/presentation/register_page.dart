import 'package:flutter/material.dart';
import 'package:luciapp/main.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(.5),
        ),
        Card(
          // decoration: BoxDecoration(
          //   color: Theme.of(context).colorScheme.surface,
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white.withOpacity(.85),
          //
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/imagotype_light.png',
                  width: 250,
                  fit: BoxFit.fitWidth,
                ),
                Text(
                  "Aprende sin límites",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 35,
                ),
                OutlinedTextField(
                  label: "Nombre",
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: OutlinedTextField(
                        label: "Edad",
                        isNumberField: true,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    DropdownMenu<String>(
                      initialSelection: list.first,
                      inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        outlineBorder: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        activeIndicatorBorder: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      width: 100,
                      menuStyle: MenuStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      label: const Text("Género"),
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        // setState(() {
                        //   dropdownValue = value!;
                        // });
                      },
                      dropdownMenuEntries:
                          list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Hello"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
