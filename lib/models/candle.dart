import 'dart:convert';

Candle candleFromJson(String str) => Candle.fromJson(json.decode(str));

String candleToJson(Candle data) => json.encode(data.toJson());

class Candle {
  Candle({
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.period,
  });

  double? open;
  double? high;
  double? low;
  double? close;
  double? volume;
  int? period;

  factory Candle.fromJson(Map<String, dynamic> json) => Candle(
        open: double.parse(json["open"] ?? 0),
        high: double.parse(json["high"] ?? 0),
        low: double.parse(json["low"] ?? 0),
        close: double.parse(json["close"] ?? 0),
        volume: double.parse(json["volume"] ?? 0),
        period: json["period"],
      );

  Map<String, dynamic> toJson() => {
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "volume": volume,
        "period": period,
      };
}
