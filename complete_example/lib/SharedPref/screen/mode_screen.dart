import 'package:flutter/material.dart';
import 'package:complete_example/SharedPref/preferences/app_pref_local_data_source.dart';
import 'package:complete_example/SharedPref/preferences/app_preferences_local_data_source_impl.dart';

class ModeScreen extends StatefulWidget {
  const ModeScreen({ super.key });

  @override
  State<ModeScreen> createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {

  final AppPreferencesLocalDataSourceImpl localDataSource = AppPreferencesLocalDataSourceImpl();
  bool isDarkMode = false;

  @override
  initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    bool savedTheme = await localDataSource.getDarkMode();

    setState(() {
      isDarkMode = savedTheme;
    });
  }

  void _themeToggler(bool value) async {
    setState(() {
      isDarkMode = value;
    });
    await localDataSource.saveDarkMode(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Switch(
                  value: isDarkMode,
                  onChanged: _themeToggler,
                ),
                IconButton(
                  onPressed: () => _themeToggler(!isDarkMode),
                  icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}