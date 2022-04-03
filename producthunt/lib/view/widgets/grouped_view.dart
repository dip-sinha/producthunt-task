import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:producthunt/view/product_details/product_details_page.dart';
import 'package:producthunt/view/resources/asset_constants.dart';

import '../../../model/product_response_model.dart';
import 'product_card.dart';


class GroupedViewWidget extends StatelessWidget {
  final List<Post> posts;
  final bool isFromCached;

  const GroupedViewWidget({Key? key, required this.posts, required this.isFromCached}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getViewViewForMonthly;
  }

  Widget get getViewViewForMonthly => GroupedListView<Post, DateTime>(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        elements: posts,
        groupBy: (element) =>
            DateFormat('yyyy-MM-dd', 'en_US').parse(element.day ?? ''),
        groupComparator: (item1, item2) => (item2).compareTo(item1),
        groupSeparatorBuilder: (DateTime groupByValue) =>
            groupedView(groupByValue),
        indexedItemBuilder: (context, Post element, int index) =>
            itemBuilder(context, element, index),
        itemComparator: (item1, item2) => DateTime.parse(item1.createdAt ?? '')
            .compareTo(DateTime.parse(item2.createdAt ?? '')), // optional
        useStickyGroupSeparators: true, // optional
        floatingHeader: false, // optional
        order: GroupedListOrder.ASC, // optional
      );

  String getDay(DateTime date) {
    if (checkTodayTomorrow(date)) {
      return getTodayOrTomorrow(date);
    } else {
      final DateFormat formatter = DateFormat("dd MMM yyyy");
      return formatter.format(date);
    }
  }

  Widget groupedView(DateTime date) => Container(
    color: Colors.white,
    child: Text(getDay(date),
        style: const TextStyle(
            fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold)),
  );

  Widget itemBuilder(BuildContext ctx, Post post, int index) => ProductCard(
      post: post,
      onClick: () {
        isFromCached? showNowInternet():Get.toNamed(ProductDetailsPage.routeName, arguments: post);
      });

   showNowInternet() {
     return Get.bottomSheet(
         Container(
           decoration: BoxDecoration(
               color: Colors.white,
               border: Border.all(
                 color: Colors.grey.withOpacity(0.2),
               ),
               borderRadius: const BorderRadius.all(Radius.circular(10))),

           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               SizedBox(height: 20,),
               Image.asset(AssetConstants.networkError,width: 200,
                 height: 200,
                 fit: BoxFit.fill,
               ),
               ElevatedButton(
                 style: ElevatedButton.styleFrom(
                     primary: Colors.purple,
                     //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                     textStyle: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold)),
                 onPressed: () {
                   // Respond to button press
                   Get.back();
                 },
                 child: const Text("No Internet!!"),
               ),
               SizedBox(height: 20,),
             ],
           ),
         ));
   }

  static bool checkTodayTomorrow(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(date.year, date.month, date.day);
    if (aDate == today || aDate == yesterday) {
      return true;
    } else {
      return false;
    }
  }

  static getTodayOrTomorrow(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day - 1);

    final aDate = DateTime(date.year, date.month, date.day);
    if (aDate == today) {
      return "Today";
    } else if (aDate == tomorrow) {
      return "Yesterday";
    }
  }
}
