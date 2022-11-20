
import 'package:miniproject/models/asset.dart';
import 'package:miniproject/models/candle.dart';
import 'dio_handler.dart';


class ApiRepository {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'https://api.coincap.io/v2/';
  // ignore: constant_identifier_names
  static const String ASSETS = BASE_URL + 'assets';
  static Future<List<Asset>?> assetsFindAll() async {
    // final res = await http.get(Uri.parse(ASSETS));
    final res = await DioHandler.get(ASSETS, queryParematers: {
      'limit': 100,
    });
    if (res.statusCode == 200) {
      final json = res.data;

      if (json is Map && json.containsKey('data')) {
        final data = json['data'];

        if (data is List) {
          return data.map<Asset>((u) => Asset.fromJson(u)).toList();
        }
      }
    }

    return null;
  }

  static Future<Asset?> assetsFindById(String id) async {
    final url = ASSETS + "/$id";
    final res = await DioHandler.get(url);
    if (res.statusCode == 200) {
      final json = res.data;

      if (json is Map && json.containsKey('data')) {
        final data = json['data'];

        return Asset.fromJson(data);
      }
    }

    return null;
  }

  static Future<List<Candle>?> candle(String assetId, String interval) async {
    String url = BASE_URL + "candles";

    final res = await DioHandler.get(url, queryParematers: {
      "exchange": "binance",
      "interval": interval,
      "baseId": assetId,
      "quoteId": "tether",
    });

    if (res.statusCode == 200) {
      final json = res.data;

      if (json is Map && json.containsKey('data')) {
        final data = json['data'];

        if (data is List) {
          return data.map<Candle>((u) => Candle.fromJson(u)).toList();
        }
      }
    }

    return null;
  }
}
