import 'package:flutter/material.dart';

import './theme_mode.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    loadThemeMode().then((val) => setState(() => _themeMode = val));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.lightbulb),
          title: const Text('Dark/Light Mode'),
          trailing: Text((_themeMode == ThemeMode.system)
              ? 'System'
              : (_themeMode == ThemeMode.dark ? 'Dark' : 'Light')),
          onTap: () async {
            var ret =
                await Navigator.of(context).push<ThemeMode>(MaterialPageRoute(
              builder: (context) => ThemeModeSelectionPage(mode: _themeMode),
            ));
            setState(() => _themeMode = ret!);
            await saveThemeMode(_themeMode);
          },
        ),
      ],
    );
  }
}

class ThemeModeSelectionPage extends StatefulWidget {
  const ThemeModeSelectionPage({
    Key? key,
    required this.mode,
  }) : super(key: key);
  final ThemeMode mode;

  @override
  _ThemeModeSelectionPageState createState() => _ThemeModeSelectionPageState();
}

class _ThemeModeSelectionPageState extends State<ThemeModeSelectionPage> {
  late ThemeMode _current;

  @override
  void initState() {
    super.initState();
    _current = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop<ThemeMode>(context, _current),
            ),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.system,
            groupValue: _current,
            title: const Text('System'),
            onChanged: (val) => {setState(() => _current = val!)},
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.dark,
            groupValue: _current,
            title: const Text('Dark'),
            onChanged: (val) => {setState(() => _current = val!)},
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.light,
            groupValue: _current,
            title: const Text('Light'),
            onChanged: (val) => {setState(() => _current = val!)},
          ),
        ],
      )),
    );
  }
}
