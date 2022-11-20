import 'package:animations/animations.dart';
import 'package:miniproject/view/constant/constant.dart';
import 'package:miniproject/models/asset.dart';
import 'package:miniproject/view/screens/home/detail_assets_screen.dart';
import 'package:miniproject/viewmodels/asset_provider.dart';
import 'package:miniproject/view/screens/home/assets_screen.dart';
import 'package:miniproject/view/widgets/asset_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AssetsProvider assetsProvider;

  @override
  void initState() {
    assetsProvider = context.read<AssetsProvider>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      assetsProvider.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AssetsProvider>(builder: (context, state, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Home",
            style: titleStyleHeader,
          ),
        ),
        body: Builder(builder: (context) {
          if (state.isFailed) {
            return const Center(
              child: Text("Failed to fetch data.."),
            );
          }
          if (state.isEmpty) {
            return const Center(
              child: Text("No data"),
            );
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: state.refresh,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Card Header
                  SizedBox(
                      height: 160,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          _boxHeader(
                              title: "🔥 Trending",
                              state: state.trendingAssets()),
                          _boxHeader(
                              title: "📈 Top Gainers",
                              state: state.topGainerAssets()),
                          _boxHeader(
                              title: "📉 Losers",
                              state: state.topLosesAssets()),
                        ],
                      )),

                  /// LIST COIN
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Coins",
                          style: titleStyleText,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const AssetsAllScreen(),
                              )),
                          child: Text(
                            "See all",
                            style: titleStyleText.copyWith(color: primaryColor),
                          ),
                        )
                      ],
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.listAllAssets.isEmpty ? 0 : 10,
                    itemBuilder: (context, index) => OpenContainer(
                      openElevation: 0,
                      closedElevation: 0,
                      closedColor: Theme.of(context).scaffoldBackgroundColor,
                      transitionDuration: const Duration(milliseconds: 700),
                      transitionType: ContainerTransitionType.fade,
                      closedBuilder: (context, action) =>
                          AssetCard(asset: state.listAllAssets[index]),
                      openBuilder: (context, _) =>
                          DetailAssetScreen(asset: state.listAllAssets[index]),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      );
    });
  }

  Padding _boxHeader({String? title, required List<Asset> state}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 270,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                  color: Colors.grey.withOpacity(0.2))
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  title ?? "title",
                  style: titleStyleText,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 18),
                  itemCount: state.isEmpty ? 0 : 4,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text("${index + 1}")),
                        Expanded(child: Text(state[index].name ?? "")),
                        Text(state[index].symbol ?? ""),
                        Text(
                            "${state[index].changePercent24Hr?.substring(0, 5)}%",
                            style: TextStyle(
                                color: (state[index].changePercent24Hr ?? "")
                                        .contains("-")
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 12))
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
