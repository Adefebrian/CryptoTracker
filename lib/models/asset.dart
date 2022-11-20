// To parse this JSON data, do
//
//     final coin = coinFromJson(jsonString);

import 'dart:convert';

Asset coinFromJson(String str) => Asset.fromJson(json.decode(str));

String coinToJson(Asset data) => json.encode(data.toJson());

class Asset {
    Asset({
        this.id,
        this.rank,
        this.symbol,
        this.name,
        this.supply,
        this.maxSupply,
        this.marketCapUsd,
        this.volumeUsd24Hr,
        this.priceUsd,
        this.changePercent24Hr,
        this.vwap24Hr,
        this.explorer
    });

    String? id;
    String? rank;
    String? symbol;
    String? name;
    String? supply;
    String? maxSupply;
    String? marketCapUsd;
    String? volumeUsd24Hr;
    String? priceUsd;
    String? changePercent24Hr;
    String? vwap24Hr;
    String? explorer;

    factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json["id"],
        rank: json["rank"],
        symbol: json["symbol"],
        name: json["name"],
        supply: json["supply"],
        maxSupply: json["maxSupply"],
        marketCapUsd: json["marketCapUsd"],
        volumeUsd24Hr: json["volumeUsd24Hr"],
        priceUsd: json["priceUsd"],
        changePercent24Hr: json["changePercent24Hr"],
        vwap24Hr: json["vwap24Hr"],
        explorer: json["explorer"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rank": rank,
        "symbol": symbol,
        "name": name,
        "supply": supply,
        "maxSupply": maxSupply,
        "marketCapUsd": marketCapUsd,
        "volumeUsd24Hr": volumeUsd24Hr,
        "priceUsd": priceUsd,
        "changePercent24Hr": changePercent24Hr,
        "vwap24Hr": vwap24Hr,
        "explorer": explorer,
    };
}
