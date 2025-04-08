import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Core/Models/UserModel.dart';
import 'package:ecommerce/Core/ViewModels/FavoriteProvider.dart';
import 'package:ecommerce/View/Screens/FavoritePlates/FavoritePlatesPage.dart';
import 'package:ecommerce/View/Screens/Profile/profilePage.dart';
import 'package:ecommerce/View/Screens/aboutUs/aboutUs.dart';
import 'package:ecommerce/View/Screens/drawer/widgets.dart';
import 'package:ecommerce/View/Screens/login/Auth.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import '../../../Core/Const/colors.dart';
import '../../../Core/ViewModels/AuthProvider.dart';

class DrawerRight extends StatelessWidget {
  const DrawerRight({super.key});

  void _logout(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.logout(); // Call logout from Provider
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const CustomLoginScreen()),
    );
  }

  UserModel? getUser(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final user = authProvider.user;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      width: width * 0.7,
      backgroundColor: Colors.white.withOpacity(0.9),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(50), bottomEnd: Radius.circular(50))),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 60),
        children: getUser(context) == null
            ? [
                buildDrawerItem(
                  context,
                  title: "حدث خطأ ما الرجاء تسجيل الخروج والمحاولة مجددأ",
                  leadingIcon: Icons.account_circle_outlined,
                  onTap: () {},
                ),
                buildDrawerItem(
                  context,
                  title: "Logout",
                  leadingIcon: Icons.logout,
                  onTap: () => _logout(context),
                ),
              ]
            : [
                // User Icon
                SizedBox(
                  width: width * 0.4,
                  height: width * 0.4,
                  child: FittedBox(
                    child: CircleAvatar(
                      radius: height * 0.1,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          user?.avatar != null && user!.avatar!.isNotEmpty
                              ? CachedNetworkImageProvider(
                                  "${authProvider.pb.baseUrl}/api/files/_pb_users_auth_/${user?.id}/${user?.avatar}",
                                )
                              : const AssetImage('assets/imgs/halal icon2.png')
                                  as ImageProvider,
                      child: user?.avatar == null
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.grey)
                          : null,
                    ),
                  ),
                ),

                // User Data Text
                SizedBox(
                  height: height * 0.05,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(getUser(context)!.name!,
                        style: const TextStyle(
                            fontSize: 24,
                            color: MyColors.drawerIconColor,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: 20),
                // Drawer Items
                buildDrawerItem(
                  context,
                  title: "حسابي",
                  leadingIcon: Icons.account_circle_outlined,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ProfileEditPage()),
                    );
                  },
                ),
                buildDrawerItem(
                  context,
                  title: "قائمة مفضلاتي",
                  leadingIcon: Icons.favorite_border,
                  onTap: () {
                    final s = Provider.of<FavoriteProvider>(context, listen: false);
                    s.getFavPlates(authProvider.pb);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FavoriteScreen()),
                    );
                  },
                ),
                buildDrawerItem(
                  context,
                  title: "سلة التسوق",
                  leadingIcon: Icons.shopping_cart_outlined,
                  onTap: () {},
                ),
                buildDrawerItem(
                  context,
                  title: "من نحن",
                  leadingIcon: Icons.people,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AboutUs()),
                    );
                  },
                ),
                buildDrawerItem(
                  context,
                  title: "الإعدادات",
                  leadingIcon: Icons.settings,
                  onTap: () {},
                ),
                buildDrawerItem(
                  context,
                  title: "Logout",
                  leadingIcon: Icons.logout,
                  onTap: () => _logout(context),
                ),
              ],
      ),
    );
  }
}
