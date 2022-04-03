import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:producthunt/data/dio_client.dart';
import 'package:producthunt/data/network/home_page_api_service.dart';
import 'package:producthunt/view/home/home_page.dart';

class SplashController extends GetxController{

@override
  void onReady() {
    super.onReady();
    checkInternet();
    //navigateToHome();
  }
 // todo: check internet
  Future<void> navigateToHome ({required bool? isNetworkError}) async {
    Future.delayed(Duration(seconds: 3), () async {
      await Get.offAndToNamed(HomePage.routeName, arguments: isNetworkError);
    });
  }

  checkInternet ()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      navigateToHome(isNetworkError: false);
    } else {
      navigateToHome(isNetworkError: true);
    }
  }
}