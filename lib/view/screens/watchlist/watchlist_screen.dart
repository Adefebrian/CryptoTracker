import 'package:miniproject/view/constant/constant.dart';
import 'package:miniproject/view/screens/home/detail_assets_screen.dart';
import 'package:miniproject/viewmodels/watchlist_provider.dart';
import 'package:miniproject/view/widgets/asset_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late WatchlistProvider watchlistProvider;

  @override
  void initState() {
    watchlistProvider = context.read<WatchlistProvider>();
      WidgetsBinding.instance?.addPostFrameCallback((_) {
      watchlistProvider.showWatchlist(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top : 30, bottom : 50),
          child: Text(
            "Watchlist",
            style: titleStyleHeader,
          ),
        ),
      ),
    body: Consumer<WatchlistProvider>(
        builder: (context, state, child) {
          if (state.listSelectedAssets.isEmpty) {
            return const Center(
              child: Text("No watchlist"),
            );
          }

          return ListView.builder(
            itemCount: state.listSelectedAssets.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DetailAssetScreen(
                        asset: state.listSelectedAssets[index]),
                  )),
              child: AssetCard(
                asset: state.listSelectedAssets[index],
              ),
            ),
          );
        },
      ),
    );
  }
}