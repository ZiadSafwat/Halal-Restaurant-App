import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ecommerce/Core/Const/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/UserModel.dart';
import 'package:flutter/foundation.dart';


class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
    PocketBase pb=PocketBase(AppConstants.baseUrl);
  UserModel? user;

  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _initAuth();
  }
  Future<void> updateName(String name) async {
    try {
      await pb.collection('users').update(user!.id!, body: {"name": name});
      user!.name = name;
      notifyListeners();
    } catch (e) {
      print("Failed to update name: $e");
    }
  }

  Future<void> updateAvatar(String imagePath) async {
    try {
      File image = File(imagePath);
      MultipartFile file = await MultipartFile.fromPath(
        'avatar', image.path,
        filename: image.path.split('/').last,
        contentType: MediaType.parse(lookupMimeType(image.path) ?? 'image/jpeg'),
      );

      await pb.collection('users').update(user!.id!,fields:'avatar' , files: [file]);
      final authData = await pb.collection('users').authRefresh();
      user!.avatar = authData.record.data["avatar"];
      notifyListeners();
    } catch (e) {
      print("Failed to update avatar: $e");
    }
  }

  Future<void> updateGender(String gender) async {
    try {
      await pb.collection('users').update(user!.id!, body: {"gender": gender});
      user!.gender = gender;
      notifyListeners();
    } catch (e) {
      print("Failed to update gender: $e");
    }
  }


  Future<void> _initAuth() async {
    final prefs = await SharedPreferences.getInstance();

    final store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
    );
    print(store.token);
    pb = PocketBase(AppConstants.baseUrl, authStore: store);
    _isAuthenticated = pb.authStore.isValid;

    if (_isAuthenticated) {
      try {
        // 🔹 Refresh authentication token
        final authData = await pb.collection('users').authRefresh();
        // 🔹 Save updated token
        pb.authStore.save(authData.token, authData.record);

        user = UserModel.fromJson((authData.record.toString()));
      } catch (e) {
        print("Auth refresh failed: $e");
        user = null;
        logout(); // Clear authentication on failure
      }
    }

    notifyListeners();
  }


  Future<bool> login(String email, String password) async {
    try {
      final authData = await pb.collection('users').authWithPassword(email, password

      );

      _isAuthenticated = pb.authStore.isValid;
      notifyListeners();        user = UserModel.fromJson((authData.record.toString()));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signup(String email, String password,
      Map<String, dynamic>? additionalData) async {
    try {
      await pb.collection('users').create(body: {
        "email": email,
        "password": password,
        "passwordConfirm": password,
        "fullname": additionalData?['fullname'],
        "gender": additionalData?['gender'],
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> recoverPassword(String email) async {
    try {
      await pb.collection('users').requestPasswordReset(email);
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    pb.authStore.clear();
    _isAuthenticated = false;
    notifyListeners();
  }
}
