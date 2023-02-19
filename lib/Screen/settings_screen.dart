// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:keepsettings/keepsettings.dart';
// import 'package:flutter/material.dart';
// import 'package:settings_ui/settings_ui.dart';
// import 'package:keepswitch/keepswitch.dart';
// // import 'package:settings_ui/main.dart';

// import '../utils/app_color.dart';

// enum RadioButtonOptions { op1, op2, op3 }

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key key}) : super(key: key);

//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   bool tileManager = settingUI.isDarkMode;
//   var initialRadioChoice = RadioButtonOptions.op2;
//   var checkBoxManager = true;

//   // Color iconColor = Colors.black;
//   double sliderCurVal = 20;
//   var initialValue = 20.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text('Settings UI')),
//       ),
//       body: SafeArea(
//         child: settingsList(),
//       ),
//     );
//   }

//   Widget settingsList() {
//     return SettingsList(
//       sections: [
//         TilesSection(
//           title: 'Tiles',
//           tiles: [
//             SettingsTile(
//               title: 'Language',
//               leading: const Icon(Icons.language),
//               trailing: languageTrailing(),
//             ),
//             SettingsTile.switchTile(
//               title: 'Stop Push Notification',
//               leading: const Icon(CupertinoIcons.bell),
//               switchActiveColor: Theme.of(context).colorScheme.secondary,
//               switchValue: tileManager,
//               onToggle: toggleDarkMode,
//             ),
//             SettingsTile(
//               trailing: const Icon(
//                 CupertinoIcons.forward,
//               ),
//               title: 'Primary Color',
//               leading: const Icon(
//                 Icons.color_lens_outlined,
//               ),
//               onPressed: (_) {
//                 colorPicker(primaryColors, onPrimaryColorChange);
//               },
//             ),
//             SettingsTile(
//               trailing: const Icon(
//                 CupertinoIcons.forward,
//               ),
//               title: ' Accent Color',
//               leading: const Icon(
//                 Icons.color_lens_outlined,
//               ),
//               onPressed: (_) {
//                 colorPicker(accentColors, onAccentColorChange);
//               },
//             ),
//             SettingsTile.switchTile(
//               title: ' Dark Mode',
//               subtitle: 'Save your eyes',
//               leading: const Icon(CupertinoIcons.cloud_sun),
//               switchActiveColor: Theme.of(context).colorScheme.secondary,
//               switchValue: tileManager,
//               onToggle: toggleDarkMode,
//               // togglerShape: TogglerShapes.heart,
//             ),
//             SettingsTile.checkListTile(
//               leading: const Icon(EvaIcons.clock),
//               onChanged: onCheckChanged,
//               enabled: checkBoxManager,
//               title: 'Slow Down Animations',
//             ),
//             SettingsTile(
//               onPressed: (_) {
//                 Navigator.of(context).maybePop();
//               },
//               title: 'Back to home screen',
//               subtitle: 'Home',
//               leading: const Icon(CupertinoIcons.back),
//             ),
//           ],
//         ),
//         SliderSection(
//           slider: SliderTile(
//             initialSliderValue: initialValue,
//             onSliderChange: (value) {
//               setState(() {
//                 initialValue = value;
//               });
//             },
//             min: 0,
//             max: 100,
//           ),
//           title: 'Slider',
//         ),
//         RadioButtonSection(
//           title: 'Radio Button',
//           tiles: [
//             RadioButton<RadioButtonOptions>(
//               label: 'Monthly',
//               value: RadioButtonOptions.op1,
//               groupValue: initialRadioChoice,
//               onChanged: onRadioChanged,
//             ),
//             RadioButton<RadioButtonOptions>(
//               label: 'Yearly',
//               value: RadioButtonOptions.op2,
//               groupValue: initialRadioChoice,
//               onChanged: onRadioChanged,
//             ),
//             RadioButton<RadioButtonOptions>(
//               label: 'Life Time',
//               value: RadioButtonOptions.op3,
//               groupValue: initialRadioChoice,
//               onChanged: onRadioChanged,
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   // ignore: avoid_positional_boolean_parameters
//   Future<void> toggleDarkMode(bool value) async {
//     doSomething(value);
//     setState(() {
//       settingUI.isDarkMode = !settingUI.isDarkMode;
//       tileManager = !tileManager;
//     });
//     settingUI.callSetState();
//   }

//   Widget languageTrailing() {
//     return PopupMenuButton(
//       icon: Icon(Icons.arrow_drop_down,
//           color: Theme.of(context).colorScheme.secondary),
//       iconSize: 30,
//       onSelected: doSomething,
//       itemBuilder: (_) => supportedLanguages
//           .map(
//             (e) => PopupMenuItem(
//               value: e,
//               child: Text(e.name),
//             ),
//           )
//           .toList(),
//     );
//   }

//   final supportedLanguages = <LanguageData>[
//     LanguageData('🇺🇸', 'English', 'en'),
//     LanguageData('in', 'Hindi', 'hi'),
//   ];

//   void doSomething(value) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         duration: Duration(seconds: 1),
//         content: Text('You did something'),
//       ),
//     );
//   }

//   // ignore: avoid_positional_boolean_parameters
//   void onTileChanged(bool value) {
//     doSomething(value);

//     setState(() {
//       tileManager = !tileManager;
//     });
//   }

//   // ignore: avoid_positional_boolean_parameters
//   void onCheckChanged(bool? value) {
//     doSomething(value);

//     setState(() {
//       checkBoxManager = !checkBoxManager;
//     });
//   }

//   void onRadioChanged(RadioButtonOptions? value) {
//     doSomething(value);
//     setState(() {
//       if (value != null) {
//         initialRadioChoice = value;
//       }
//     });
//   }

//   Future<void> colorPicker(List<Color> appColors, onColorChange) async {
//     final status = await showDialog(
//           barrierDismissible: true,
//           context: context,
//           builder: (context) => MyAlertDialog(
//             title: const Text('Pick Color'),
//             content: SingleChildScrollView(
//               child: ColorPicker(
//                 availableColors: appColors,
//                 pickerColor: Colors.deepOrangeAccent,
//                 onColorChanged: onColorChange,
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                 },
//                 child: const Text('Done'),
//               ),
//             ],
//           ),
//         ) ??
//         false;
//     if (status) {}
//   }

//   void onPrimaryColorChange(Color value) {
//     setState(() {
//       settingUI.primaryColor = value;
//     });
//     settingUI.callSetState();
//   }

//   void onAccentColorChange(Color value) {
//     setState(() {
//       settingUI.accentColor = value;
//     });
//     settingUI.callSetState();
//   }
// }

// class LanguageData {
//   LanguageData(this.flag, this.name, this.languageCode);

//   final String flag;
//   final String name;
//   final String languageCode;
// }

// class MyAlertDialog extends StatelessWidget {
//   const MyAlertDialog({
//      this.content,
//      this.title,
//     this.actions,
//     Key key,
//   }) : super(key: key);

//   final Widget title;
//   final List<Widget> actions;
//   final Widget content;

//   @override
//   Widget build(BuildContext context) => AlertDialog(
//         title: Center(child: title),
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(
//             color: Theme.of(context).iconTheme.color!.withOpacity(0.1),
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         content: content,
//         actions: actions,
//       );
// }

// List<Color> primaryColors = <Color>[
//   Colors.red,
//   Colors.pink,
//   Colors.purple,
//   Colors.deepPurple,
//   Colors.blue,
//   Colors.indigo,
//   Colors.cyan,
//   Colors.teal,
//   Colors.orange,
//   Colors.deepOrange,
//   Colors.amber,
//   Colors.brown,
//   Colors.grey,
//   Colors.blueGrey,
//   Colors.black,
// ];

// List<Color> accentColors = <Color>[
//   Colors.redAccent,
//   Colors.pinkAccent,
//   Colors.purpleAccent,
//   Colors.deepPurpleAccent,
//   Colors.blueAccent,
//   Colors.indigoAccent,
//   Colors.cyanAccent,
//   Colors.tealAccent,
//   Colors.orangeAccent,
//   Colors.deepOrangeAccent,
//   Colors.lightBlueAccent,
//   Colors.amberAccent,
//   const Color(0xFFFF7582),
// ];
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage2 extends StatefulWidget {
  const SettingsPage2({Key key}) : super(key: key);

  @override
  State<SettingsPage2> createState() => _SettingsPage2State();
}

class _SettingsPage2State extends State<SettingsPage2> {
  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _SingleSection(
                  title: "General",
                  children: [
                    _CustomListTile(
                        title: "Dark Mode",
                        icon: Icons.dark_mode_outlined,
                        trailing: Switch(
                            value: _isDark,
                            onChanged: (value) {
                              setState(() {
                                _isDark = value;
                              });
                            })),
                    const _CustomListTile(
                        title: "Notifications",
                        icon: Icons.notifications_none_rounded),
                    const _CustomListTile(
                        title: "Security Status",
                        icon: CupertinoIcons.lock_shield),
                  ],
                ),
                const Divider(),
                const _SingleSection(
                  title: "Organization",
                  children: [
                    _CustomListTile(
                        title: "Profile", icon: Icons.person_outline_rounded),
                    _CustomListTile(
                        title: "Messaging", icon: Icons.message_outlined),
                    _CustomListTile(
                        title: "Calling", icon: Icons.phone_outlined),
                    _CustomListTile(
                        title: "People", icon: Icons.contacts_outlined),
                    _CustomListTile(
                        title: "Calendar", icon: Icons.calendar_today_rounded)
                  ],
                ),
                const Divider(),
                const _SingleSection(
                  children: [
                    _CustomListTile(
                        title: "Help & Feedback",
                        icon: Icons.help_outline_rounded),
                    _CustomListTile(
                        title: "About", icon: Icons.info_outline_rounded),
                    _CustomListTile(
                        title: "Sign out", icon: Icons.exit_to_app_rounded),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget trailing;
  const _CustomListTile({Key key, this.title, this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key key,
    this.title,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
