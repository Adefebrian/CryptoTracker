import 'package:miniproject/models/asset.dart';
import 'package:miniproject/models/candle.dart';
import 'package:miniproject/repository/api_repository.dart';
import 'package:flutter/foundation.dart';

class DetailAssetProvider extends ChangeNotifier {

  //* ----------------------------
  //* This is side for property data
  //* ----------------------------

  //* Selected asset variabel
  Asset _asset = Asset();
  Asset get asset => _asset;
  
  //* Candle of asset
  final List<Candle> _listCandle = [];
  List<Candle> get listCandle => _listCandle;

  bool _isLoadingAsset = false;
  bool _isFailedAsset = false;
  bool _isLoadingCandle = false;
  bool _isFailedCandle = false;
  bool _isEmptyCandle = false;

  //* To handle event get data
  bool get isLoadingAsset => _isLoadingAsset;
  bool get isFailedAsset => _isFailedAsset;
  bool get isSuccess => _asset.id != null;
  bool get isLaodingCandle => _isLoadingCandle;
  bool get isFailedCandle => _isFailedCandle;
  bool get isEmptyCandle => _isEmptyCandle;


  //* Interval list
  List<String> intervalCandleList = [
    "m1",
    "m5",
    "m15",
    "m30",
    "h1",
    "h2",
    "h4",
    "h8",
    "h12",
    "d1",
    "w1"
  ];

  //* Selected interval
  String selectedInterval = "m1";





  //* ----------------------------
  //* Function field
  //* ----------------------------

  //* Function to get candle by selected interval
  onSelectInterval(String assetId, String value) async {
    if (value != selectedInterval && !isLaodingCandle) {
      selectedInterval = value;
      await loadCandle(assetId, value);
      notifyListeners();
    }
  }

  //* Set loading asset state to active
  _startLoadingAsset() {
    _isLoadingAsset = true;
    notifyListeners();
  }

  //* Set loading asset state to deactive
  stopLoadingAsset() {
    _isLoadingAsset = false;
    notifyListeners();
  }

  //* Load asset by asset id
  Future<void> loadAsset(String id) async {
    _startLoadingAsset();
    final item = await ApiRepository.assetsFindById(id);
    if (item == null) {
      _isFailedAsset = true;
    } else {
      _asset = item;
      _isFailedAsset = false;
    }
    stopLoadingAsset();
  }

   //* Set loading candle state to active
  _startLoadingCandle() {
    _isLoadingCandle = true;
    notifyListeners();
  }

  //* Set loading candle state to deactive
  stopLoadingCandle() {
    _isLoadingCandle = false;
    notifyListeners();
  }


  //* Function to load candle of asset
  Future<void> loadCandle(String assetId, String interval) async {
    _startLoadingCandle();
    _listCandle.clear();
    final item = await ApiRepository.candle(assetId, interval);
    if (item == null) {
      _isFailedCandle = true;
    } else {
      if (item.isEmpty) {
        _isEmptyCandle = true;
      } else {
        _listCandle.addAll(item);
        _isEmptyCandle = false;
      }
    }

    _isFailedCandle = false;

    stopLoadingCandle();
  }

  // Function to set initial state
  Future<void> init(String assetId) async {
    _isEmptyCandle = false;
    _isLoadingAsset = false;
    _isLoadingCandle = false;
    _isFailedAsset = false;
    _isFailedCandle = false;
    _listCandle.clear();

    Future.wait([loadAsset(assetId), loadCandle(assetId, selectedInterval)]);
  }
}
