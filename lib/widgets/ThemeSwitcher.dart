import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ThemeProvider.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Theme Mode"),
          Row(
            children: [
              Switch(value: themeProvider.isDartModeChecked, onChanged: (value){

                themeProvider.updateMode(darkMode: value);



              }),
              SizedBox(width: 20,)
              ,
              Text(themeProvider.isDartModeChecked?"DarkMode":"LightMode")

            ],
          )
        ]

    );
  }
}
