import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../Core/ViewModels/AuthProvider.dart';

class ProfileEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text("Profile"),
            tiles: [
              SettingsTile(
                title: Text("Avatar"),
                leading: CircleAvatar(
                  backgroundImage: user?.avatar != null
                      ? NetworkImage("${authProvider.pb.baseURL}/api/files/_pb_users_auth_/${user?.id}/${user?.avatar}")
                      : AssetImage('assets/imgs/halal icon.png') as ImageProvider,
                ),
                trailing: Icon(Icons.edit),
                onPressed: (context) async {
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    await authProvider.updateAvatar(pickedFile.path);
                  }
                },
              ),
              SettingsTile.navigation(
                title: Text("Name"),
                value: Text(user?.name ?? ""),
                onPressed: (context) => _editName(context, authProvider),
              ),
              // SettingsTile.switchTile(
              //   title: Text("Email Visibility"),
              //   leading: Icon(Icons.email),
              //   initialValue: user?.emailVisibility ?? false,
              //   onToggle: (value) => authProvider.updateEmailVisibility(value),
              // ),
              SettingsTile.navigation(
                title: Text("Gender"),
                value: Text(user?.gender ?? ""),
                onPressed: (context) => _editGender(context, authProvider),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editName(BuildContext context, AuthProvider authProvider) {
    TextEditingController controller = TextEditingController(text: authProvider.user?.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Name"),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          TextButton(
            onPressed: () async {
              await authProvider.updateName(controller.text);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _editGender(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Gender"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text("Male"), onTap: () => _updateGender(context, authProvider, "male")),
            ListTile(title: Text("Female"), onTap: () => _updateGender(context, authProvider, "female")),
          ],
        ),
      ),
    );
  }

  void _updateGender(BuildContext context, AuthProvider authProvider, String gender) async {
    await authProvider.updateGender(gender);
    Navigator.pop(context);
  }
}
