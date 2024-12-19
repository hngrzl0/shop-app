import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/global_keys.dart';
import 'package:shop_app/preferences_service.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  void changeLanguage(BuildContext context) async {
    final contxt = GLobalKeys.navigatorKey.currentContext!;
    final PreferencesService preferencesService = PreferencesService();

    if (contxt.locale.languageCode == const Locale('mn', 'MN').languageCode) {
      contxt.setLocale(const Locale('en', 'US'));
      await preferencesService.saveLanguageCode('en');
    } else {
      contxt.setLocale(const Locale('mn', 'MN'));
      await preferencesService.saveLanguageCode('mn');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<Global_provider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${provider.loggedUser.name?.firstname} ${provider.loggedUser.name?.lastname}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Username: ${provider.loggedUser.username}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: ${provider.loggedUser.email}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Phone: ${provider.loggedUser.phone}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Address: ${provider.loggedUser.address?.number} ${provider.loggedUser.address?.street}, ${provider.loggedUser.address?.city}, ${provider.loggedUser.address?.zipcode}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Geolocation: ${provider.loggedUser.address?.geolocation?.lat}, ${provider.loggedUser.address?.geolocation?.long}',
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                    onPressed: ()=> changeLanguage(context),
                    //child: const Text('Change Language'))
                    child: Text(context.tr("Change Language"))
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
