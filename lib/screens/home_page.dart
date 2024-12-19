// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'bags_page.dart';
import 'shop_page.dart';
import 'favorite_page.dart';
import 'profile_page.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Widget> Pages = [
    const ShopPage(),
    const BagsPage(),
    const FavoritePage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    //consumer- uurchlultiig sonsoh heseg
    return Consumer<Global_provider>(builder: (context, provider, child) {
      return Scaffold(
        //provider der currentIndx sonsoh
        body: Pages[provider.currentIdx],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.currentIdx,
            onTap:
                provider.changeCurrentIdx, //provider iin currentIdx soligdono
            items:[
              BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_cart), label: 'shop'.tr()),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_basket), label: 'bag'.tr()),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite), label: 'favorites'.tr()),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person), label: 'profile'.tr()),
            ]),
      );
    });
  }
}
