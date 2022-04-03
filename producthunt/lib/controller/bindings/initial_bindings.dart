import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/dio_client.dart';
import '../../data/local/db_provider.dart';

class InitialBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    //String secretKey = await getSecretKey();
    var daoSession = await DbProvider.instance.getDaoSession();

   // Get.put<DioClient>(DioClient.getInstance(), permanent: true);
    Get.put<DaoSession>(daoSession, permanent: true);

  }
}