import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:producthunt/controller/home/home_page_controller.dart';
import 'package:producthunt/model/product_response_model.dart';
import 'package:producthunt/view/resources/asset_constants.dart';

import '../widgets/grouped_view.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  late final HomePageController _controller;

  HomePage() {
    _controller = Get.put(HomePageController(isNetworkError: Get.arguments));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Product Hunt',
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.deepOrange),
          ),
        ),
        body: Center(
            child: Obx(() => _controller.posts.isEmpty
                ? const CircularProgressIndicator(
                    color: Colors.deepOrange,
                  )
                : Container(
                    color: Colors.white,
                    height: Get.height,
                    width: Get.width,
                    child: bodyWidget,
                  ))));
  }

  Widget get loadingWidget => Image.asset(
        AssetConstants.loading,
        height: 125.0,
        width: 125.0,
      );

  Widget get bodyWidget => Padding(
        padding: const EdgeInsets.only(top: 13.0, left: 13, right: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [searchBar, const SizedBox(height: 10), postsWidget,  _controller.isApiCalling.value?const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            ),
          ):const SizedBox.shrink()],
        ),
      );

  Widget get searchBar => SearchCard(
        hint: "search",
        onSearch: _controller.onSearch,
        textEditingController: TextEditingController(),
        trailing: [
          InkWell(
            onTap: () {
              //select date from calendar and call API
              _selectDate();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                AssetConstants.calender,
                color: Colors.black54.withOpacity(0.5),
              ),
            ),
          ),
        ],
      );

  Widget get postsWidget {
    return GetBuilder<HomePageController>(
        init: _controller,
        id: HomePageController.tag,
        builder: (controller) {
          List<Post> list = _controller.filteredPostsList;
          _controller.checkPositionOfScroll();
          return Expanded(
            child: RefreshIndicator(
              color: Colors.deepOrange,
              onRefresh: _controller.pultoRefresh,
              child: SingleChildScrollView(
                  controller: _controller.scrollController,
                  child: GroupedViewWidget(
                    posts: list,
                    isFromCached: _controller.isNetworkError,
                  )
                  //  SliverToBoxAdapter(
                  //    child: toDayTile,
                  //  ),
                  //  const SliverToBoxAdapter(
                  //    child: SizedBox(
                  //      height: 10,
                  //    ),
                  //  ),
                  //  SliverList(
                  //    delegate: SliverChildBuilderDelegate(
                  //      (BuildContext context, int index) {
                  //        return Padding(
                  //          padding: const EdgeInsets.only(bottom: 8.0),
                  //          child: ProductCard(
                  //              post: list[index],
                  //              onClick: () {
                  //                Get.toNamed(ProductDetailsPage.routeName,
                  //                    arguments: list[index]);
                  //              }),
                  //        );
                  //      },
                  //      childCount: list.length,
                  //    ),
                  //  ),
                  // if( _controller.isApiCalling.value)
                  //   SliverToBoxAdapter(child: Container(
                  //     width: 20,
                  //    height: 20,
                  //    child: CircularProgressIndicator(
                  //      color: Colors.deepOrange,
                  //    ),
                  //  ),)

                  ),
            ),
          );
        });
  }

  _selectDate() {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        //height: Get.height * .5,
        child: CalendarDatePicker(
            firstDate: DateTime.now().subtract(Duration(days: 90)),
            lastDate: DateTime.now(),
            initialDate: DateTime.now().subtract(Duration(days: 1)),
            onDateChanged: (newDate) {
              _controller.dateTimeData.value = newDate;
              _controller.fetchTodaysPost(dateTime: newDate);
              Get.back();
            }),
      ),
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
