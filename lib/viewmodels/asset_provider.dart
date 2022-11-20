import 'package:miniproject/models/asset.dart';
import 'package:miniproject/repository/api_repository.dart';
import 'package:flutter/foundation.dart';

class AssetsProvider extends ChangeNotifier {
  //* ----------------------------
  //* This is side for property data
  //* ----------------------------

  //* List asset variabel
  final List<Asset> _listAllAssets = [];
  List<Asset> get listAllAssets => _listAllAssets;

  //* To handle event get data
  bool _isEmpty = false;
  bool _isFailed = false;
  bool _isLoading = false;

  bool get isEmpty => _isEmpty;
  bool get isFailed => _isFailed;
  bool get isLoading => _isLoading;
  

  //* ----------------------------
  //* Function field
  //* ----------------------------

  //* Function init state
  Future<void> init() async {
    await refresh();
  }

  //* Function to refresh data
  Future refresh() async {
    _listAllAssets.clear();
    await loadAssets();
  }

  //* Set loading state to active
  _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  //* Set loading state to deactive
  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  //* Function to get list assets from API
  loadAssets() async {
    _startLoading();

    final item = await ApiRepository.assetsFindAll();
    if (item == null) {
      _isFailed = true;
    } else {
      if (item.isEmpty) {
        _isEmpty = true;
      } else {
        _listAllAssets.addAll(item);
        _isEmpty = false;
      }
      _isFailed = false;
    }

    notifyListeners();
    stopLoading();
  }

  //* Function to filter trending assets by highest volume
  List<Asset> trendingAssets() {
    List<Asset> item = [];
    item.addAll(_listAllAssets);
    item.sort(
      (a, b) => double.parse(b.volumeUsd24Hr!)
          .compareTo(double.parse(a.volumeUsd24Hr!)),
    );
    return item;
  }

  //* Function to filter gainer assets by highest price change
  List<Asset> topGainerAssets() {
    List<Asset> item = [];
    item.addAll(_listAllAssets);

    item.sort(
      (a, b) => double.parse(b.changePercent24Hr!)
          .compareTo(double.parse(a.changePercent24Hr!)),
    );
    return item;
  }

//* Function to filter loses assets by lowest price change
  List<Asset> topLosesAssets() {
    List<Asset> item = [];
    item.addAll(_listAllAssets);
    item.sort(
      (a, b) => double.parse(a.changePercent24Hr!)
          .compareTo(double.parse(b.changePercent24Hr!)),
    );
    return item;
  }
}
