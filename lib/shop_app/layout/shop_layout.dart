import 'package:flutter/material.dart';
import 'package:udemy_flutter/shop_app/modules/login/shop_login_screen.dart';
import 'package:udemy_flutter/shop_app/shared/components/components.dart';
import 'package:udemy_flutter/shop_app/shared/network/local/shop_cache_helper.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Shop'),
        actions: [
          TextButton(
            child: Text('Sign out'),
            onPressed: () {
              ShopCacheHelper.removeData(key: 'token').then((value) {
                if (value) {
                  navigateToReplacement(context, ShopLoginScreen());
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
