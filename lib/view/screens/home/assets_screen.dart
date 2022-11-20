import 'package:animations/animations.dart';
import 'package:miniproject/models/asset.dart';
import 'package:miniproject/view/constant/constant.dart';
import 'package:miniproject/view/screens/home/detail_assets_screen.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/viewmodels/asset_provider.dart';
import 'package:miniproject/view/widgets/asset_card.dart';
import 'package:flutter/material.dart';

class AssetsAllScreen extends StatefulWidget {
  const AssetsAllScreen({Key? key}) : super(key: key);

  @override
  State<AssetsAllScreen> createState() => _AssetsAllScreenState();
}

class _AssetsAllScreenState extends State<AssetsAllScreen> {
  late AssetsProvider assetsProvider;
  List<Asset> _listAsset = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    assetsProvider = context.read<AssetsProvider>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      assetsProvider.init();
      _listAsset = assetsProvider.listAllAssets;
    });
    super.initState();
  }

  searchAssets(String query) {
    final suggestion = assetsProvider.listAllAssets.where((element) {
      final name = element.name!.toLowerCase();
      final symbol = element.symbol!.toLowerCase();
      final input = query.toLowerCase();

      return name.contains(input) || symbol.contains(input);
    }).toList();

    setState(() {
      _listAsset = suggestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Assets",
          style: titleStyleHeader,
        ),
      ),
      body: Consumer<AssetsProvider>(builder: (context, state, _) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.2)),
              child: TextField(
                onChanged: searchAssets,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: "Search",
                    helperStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none),
              ),
            ),
            Builder(builder: (context) {
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
              } else {
                return Expanded(
                    child: RefreshIndicator(
                  onRefresh: () async {
                    _listAsset.clear();
                    await state.refresh();

                    _listAsset = state.listAllAssets;
                  },
                  child: ListView.builder(
                    itemCount: _listAsset.length,
                    itemBuilder: (context, index) {
                      return OpenContainer(
                        closedColor: Theme.of(context).scaffoldBackgroundColor,
                        openElevation: 0,
                        closedElevation: 0,
                        transitionDuration: const Duration(milliseconds: 700),
                        transitionType: ContainerTransitionType.fade,
                        closedBuilder: (context, action) =>
                            AssetCard(asset: _listAsset[index]),
                        openBuilder: (context, _) => DetailAssetScreen(asset: _listAsset[index]),
                      );
                    },
                  ),
                ));
              }
            })
          ],
        );
      }),
    );
  }
}
