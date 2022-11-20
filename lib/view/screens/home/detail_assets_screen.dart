import 'package:candlesticks_plus/candlesticks_plus.dart';
import 'package:miniproject/models/asset.dart';
import 'package:miniproject/view/constant/constant.dart';
import 'package:miniproject/viewmodels/detail_asset_provider.dart';
import 'package:miniproject/viewmodels/watchlist_provider.dart';
import 'package:miniproject/viewmodels/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension on String {
  String ceilNumber() {
    return double.parse(this).ceil().toString();
  }
}

class DetailAssetScreen extends StatefulWidget {
  final Asset asset;
  const DetailAssetScreen({Key? key, required this.asset}) : super(key: key);

  @override
  State<DetailAssetScreen> createState() => _DetailAssetScreenState();
}

class _DetailAssetScreenState extends State<DetailAssetScreen> {
  late DetailAssetProvider detailAssetProvider;

  @override
  void initState() {
    detailAssetProvider = context.read<DetailAssetProvider>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      detailAssetProvider.init(widget.asset.id ?? "btc");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.asset.name!),
          centerTitle: true,
          actions: [
            Consumer<WatchlistProvider>(builder: (context, state, _) {
              return GestureDetector(
                  onTap: () {
                    state.addRemoveAsset(context, widget.asset);
                  },
                  child: state.listSelectedAssets.any(
                    (element) => element.id == widget.asset.id,
                  )
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border));
            }),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer<DetailAssetProvider>(builder: (context, state, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Assset Header
                Builder(
                  builder: (context) {
                    if (state.isFailedAsset) {
                      return const Center(
                        child: Text("Failed to fetch data"),
                      );
                    }

                    return _assetHeader(state);
                  },
                ),

                // Candlestick
                Builder(
                  builder: (context) {
                    if (state.isFailedCandle) {
                      return const Center(
                        child: Text("Failed to fetch data"),
                      );
                    }

                    if (state.isEmptyCandle) {
                      return const Center(
                        child: Text("Candle is empty"),
                      );
                    }

                    return Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 30,
                                      offset: const Offset(0, 4),
                                      color: Colors.grey.withOpacity(0.2))
                                ]),
                            width: double.infinity,
                            child: Column(
                              children: [
                                state.isLaodingCandle
                                    ? const SizedBox(
                                        height: 400,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 400,
                                        child: Candlesticks(
                                            showToolbar: true,
                                            candles: state.listCandle
                                                .map((e) => Candle(
                                                    date: DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            e.period ?? 0),
                                                    high: e.high ?? 0,
                                                    low: e.low ?? 0,
                                                    open: e.open ?? 0,
                                                    close: e.close ?? 0,
                                                    volume: e.volume ?? 0))
                                                .toList()),
                                      ),
                                Consumer<ThemeProvider>(
                                    builder: (context, themeState, _) {
                                  return Wrap(
                                    spacing: 10,
                                    children: state.intervalCandleList
                                        .map((e) => ChoiceChip(
                                            labelStyle: themeState.darkTheme
                                                ? const TextStyle(
                                                    color: Colors.white)
                                                : (e == state.selectedInterval)
                                                    ? const TextStyle(
                                                        color: Colors.white)
                                                    : const TextStyle(
                                                        color: Colors.black54),
                                            selectedColor: primaryColor,
                                            onSelected: (_) =>
                                                state.onSelectInterval(
                                                    widget.asset.id ?? "btc",
                                                    e),
                                            label: Text(e),
                                            selected:
                                                state.selectedInterval == e))
                                        .toList(),
                                  );
                                })
                              ],
                            )),
                      ],
                    );
                  },
                ),

                state.isLoadingAsset
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Information",
                                style: titleStyleText.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 8,
                            ),
                            _rowInfo("Name", state.asset.name ?? "-"),
                            _rowInfo("Symbol", state.asset.symbol ?? "-"),
                            _rowInfo("Supply",
                                (state.asset.supply ?? '0').ceilNumber()),
                            _rowInfo("Max Supply",
                                (state.asset.maxSupply ?? '0').ceilNumber()),
                            _rowInfo("Marketcap (USD)",
                                (state.asset.marketCapUsd ?? '0').ceilNumber()),
                            _rowInfo(
                                "Volume (USD) 24h",
                                (state.asset.volumeUsd24Hr ?? '0')
                                    .ceilNumber()),
                            _rowInfo("Explorer", state.asset.explorer ?? "-"),
                          ],
                        ),
                      )
              ],
            );
          }),
        ));
  }

  Widget _rowInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(title)),
          Expanded(
            child: Text(
              value,
              style: titleStyleText.copyWith(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  Padding _assetHeader(DetailAssetProvider state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset("assets/${widget.asset.symbol}.png"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.asset.name ?? "-",
                  style: titleStyleText.copyWith(fontWeight: FontWeight.normal),
                ),
                Text(
                  state.isLoadingAsset
                      ? "-"
                      : state.asset.priceUsd == null
                          ? "0"
                          : state.asset.priceUsd!.substring(0, 5),
                  style: titleStyleText.copyWith(fontSize: 18),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Flexible(
            child: state.isLoadingAsset
                ? const Text("-")
                : Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                          (state.asset.changePercent24Hr ?? "0").contains("-")
                              ? Colors.red
                              : Colors.green,
                    ),
                    child: Text(
                      widget.asset.changePercent24Hr!.substring(0, 5),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
