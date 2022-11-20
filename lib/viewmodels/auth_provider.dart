import 'dart:convert';

import 'package:miniproject/models/account.dart';
import 'package:miniproject/viewmodels/watchlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  //* ----------------------------
  //* This is side for property data
  //* ----------------------------

  //* List register account variabel
  List<Account> _listRegisterAccount = [];
  List<Account> get listRegisterAccount => _listRegisterAccount;

  //* Account variabel
  Account _account = Account();
  Account get account => _account;

  //* To handle event loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Call getstorage for saving data of account
  final box = GetStorage();

  //* ----------------------------
  //* Function field
  //* ----------------------------

  /// Call function in constructor
  AuthProvider() {
    _loadProfile();
    notifyListeners();
  }

  // Function to load profile by user login
  _loadProfile() {
    final data = box.read("account");

    if (data != null) {
      _account = Account.fromJson(jsonDecode(data));
    }
  }

  //* Set loading state to active
  _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  //* Set loading state to deactive
  _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  //* Function to create account
  Future<void> createAccount(Account account) async {
    //* Set state to loading
    _startLoading();

    //* Add user account to list register variabel
    _listRegisterAccount.add(account);

    //* Save register account to local
    await box.write("register_account", jsonEncode(_listRegisterAccount));

    //* Save account user login to local
    await box.write("account", jsonEncode(account));

    //* Delay 2 second for time loading 
    await Future.delayed(const Duration(seconds: 2));

    //* Stop loading
    _stopLoading();

    // Call load profile function
    _loadProfile();

    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    //* message variabel to save response
    Map<String, dynamic> message = {};
    
    //* Set state to loading
    _startLoading();

    //* Get list register account from local
    final registerAccountList = box.read("register_account");

    //* Check if list register account is null
    if (registerAccountList == null) {
      //* Set account not exist message
      message = {
        "message": "Cannot find your account, please create account first",
        "success": false
      };
    } 
    
     //* Check if list register account is not null
    else {
      // *Clear list register account variabel
      _listRegisterAccount.clear();

      //* Decode list register account from json to List
      List data = jsonDecode(registerAccountList);

      //* Add list register account to list variabel
      _listRegisterAccount = data.map((e) => Account.fromJson(e)).toList();

      //* Check if email and password is exist in list register account
      final isAccountExist = _listRegisterAccount.any(
        (element) => element.email == email && element.password == password,
      );

      //* if email and password is true
      if (isAccountExist) {
        //* save account to local
        await box.write(
            'account',
            jsonEncode(_listRegisterAccount.singleWhere(
              (element) =>
                  element.email == email && element.password == password,
            )));
        //* Call load profile function
        _loadProfile();

        //* Set success message
        message = {"message": "Successfully", "success": true};
      } 
       //* if email and password is false
      else {
        //* Set failed message
        message = {
          "message": "Cannot find your account, please create account first",
          "success": false
        };
      }
    }

    //* Delay 2 second for time loading
    await Future.delayed(const Duration(seconds: 2));
    _stopLoading();
    notifyListeners();
    return message;
  }


  // Function to logout
  Future<void> logout(BuildContext context) async {
    //* Remove account state
    _account = Account();

    //* Remove watchlist asset state 
    Provider.of<WatchlistProvider>(context, listen: false)
        .listSelectedAssets
        .clear();
    //* Remove account from local
    await box.remove("account");
    notifyListeners();
  }
}
