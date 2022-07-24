import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/api/sale_item_api.dart';
import 'package:rezeki_bundle_mobile/components/size_config.dart';
import 'package:rezeki_bundle_mobile/constants.dart';
import 'package:rezeki_bundle_mobile/model/sale_item.dart';

import 'package:async/async.dart';
import 'package:rezeki_bundle_mobile/model/sale_item_image.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.saleItem,
  }) : super(key: key);

  final SaleItem saleItem;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {


  String? selectedImageUrl;
  int selectedImage = 0;
  @override
  void initState() {
    selectedImageUrl = "http://192.168.0.157:8000" + widget.saleItem.url!;
  }
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var saleItemImage;
  List<SaleItemImage> _saleItemImageList = [];
  getData() async {
    _saleItemImageList.clear();

    saleItemImage = await getSaleItemImages(widget.saleItem.itemID);

    for (var data in saleItemImage) {
      //transfer states list from GET method call to a new one
      _saleItemImageList.add(SaleItemImage(
          id: data.id,
          url: data.url,
          sale_item_id: data.sale_item_id,
          sale_item_category_id: data.sale_item_category_id));
    }
    print(_saleItemImageList);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none) {
            print("Future builder failed");
            return const CircularProgressIndicator();
          } else if (projectSnap.connectionState == ConnectionState.done) {
            return Column(
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(238),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Hero(
                        tag: widget.saleItem.id.toString(),
                        child: CachedNetworkImage(
                          imageUrl:selectedImageUrl!,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                      ),),
                  ),
                ),
                // SizedBox(height: getProportionateScreenWidth(20)),
                   SizedBox(height: getProportionateScreenHeight(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(_saleItemImageList.length,
                        (index) => buildSmallProductPreview(index)),
                  ],
                )
              ],
            );
          }else {
                    return const SizedBox();
                  }
        });
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
          selectedImageUrl =
              "http://192.168.0.157:8000" + _saleItemImageList[index].url!;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(
            "http://192.168.0.157:8000" + _saleItemImageList[index].url!),
      ),
    );
  }
}
