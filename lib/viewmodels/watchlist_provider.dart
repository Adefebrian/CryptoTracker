import 'dart:convert';

import 'package:miniproject/models/asset.dart';
import 'package:miniproject/viewmodels/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class WatchlistProvider extends ChangeNotifier {
  //* ----------------------------
  //* This is side for property data
  //* ----------------------------

    //* List watchlist asset variabel
  List<Asset> _listSelectedAssets = [];
  List<Asset> get listSelectedAssets => _listSelectedAssets;


  //* Call getstorage for saving data 
  final box = GetStorage();

  // Function to set favorite or unfavorite asset
  addRemoveAsset(BuildContext context, Asset asset) async {
    //* If asset is exist in List watchlist asset, remove from watchlist
    if (_listSelectedAssets.any((element) => element.id == asset.id)) {
      _listSelectedAssets.removeWhere((element) => element.id == asset.id);
    } 
    //* Add to watchlist
    else {
      _listSelectedAssets.add(asset);
    }

    //* Call user login state
    final account = Provider.of<AuthProvider>(context, listen: false).account;

    //* Save list watchlist to local
    await box.write("watchlist-${account.email}-${account.password}}",
        jsonEncode(_listSelectedAssets));
    notifyListeners();
  }
  //* Function to get watchlist asset by user login
  showWatchlist(BuildContext context) {
    //* Call user login state
    final account = Provider.of<AuthProvider>(context, listen: false).account;

    //* get list watchlist from local
    final list = box.read("watchlist-${account.email}-${account.password}}");

    //* if list watchling from local is exist then add to list watchlist state
    if (list != null) {
      final data = jsonDecode(list);
      if (data is List) {
        _listSelectedAssets.clear();
        _listSelectedAssets = data.map((e) => Asset.fromJson(e)).toList();
      }
    }
    notifyListeners();
  }
}
