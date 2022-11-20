
import 'package:miniproject/models/asset.dart';
import 'package:miniproject/view/screens/home/detail_assets_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:miniproject/view/constant/constant.dart';

class AssetCard extends StatelessWidget {
  final Asset? asset;
  const AssetCard({
    Key? key,
    this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      // onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DetailAssetScreen(asset: asset!),
      //     )),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 1,
                    child: SizedBox(
                            height: 40,
                            width: 50,
                            child: Image.asset(
                              "assets/${asset!.symbol}.png",
                            ),
                          )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        asset?.name ?? "",
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        asset?.symbol ?? "",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        asset?.priceUsd!.substring(0, 6) ?? "0",
                        textScaleFactor: 1,
                        style: titleStyleText.copyWith(
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${asset?.changePercent24Hr?.substring(0, 5)}%",
                        style: TextStyle(
                            color:
                                (asset?.changePercent24Hr ?? "").contains("-")
                                    ? Colors.red
                                    : Colors.green,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
