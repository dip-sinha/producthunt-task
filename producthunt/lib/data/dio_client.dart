// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'network/api_respone.dart';
// import 'network/map_factory.dart';
//
// const int _defaultConnectTimeout = 30 * 1000; // 30 sec
// const int _defaultReceiveTimeout = 60 * 1000; // 60
// class DioClient {
//   late Dio _dio;
//
//   static final DioClient _instance = DioClient._internal();
//
//   factory DioClient.getInstance() {
//     return _instance;
//   }
//
//   DioClient._internal() {
//
//     _dio = Dio()
//     ..options.connectTimeout = _defaultConnectTimeout // using spread operator
//     ..options.receiveTimeout = _defaultReceiveTimeout;
//     _addCommonHeaders;
//   }
//   void _addCommonHeaders() {
//     _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, h) {
//       final headers = options.headers;
//       final additionalHeader = {
//         'Authorization':'Bearer 9bloC-ir9q6iVM4WxQ4g1msS42kJ_UR9FHeQ3_EB-Hk',
//         "Accept": 'application/json',
//         "Content-Type": "application/json",
//         "Host": "api.producthunt.com"
//       };
//       if (additionalHeader.isNotEmpty) headers.addAll(additionalHeader);
//       h.next(options);
//     }));
//   }
//
//   Future<ApiResponse<T>> get<T>(String url, dynamic data,
//       {Options? options,
//         bool readErrorResponse = false,
//         String? noDataEcCode}) async {
//     print(url);
//     try {
//       final response = await _dio.get<Map<String, dynamic>>(
//         'https://api.producthunt.com/v1/posts?day=2022-04-02',
//         queryParameters: {'date':"2022-04-02"},
//       );
//       print(response.statusCode);
//       return _processResponse(response,noDataEcCode);
//     } catch (error) {
//       print('error test');
//       return _handleError(error, readErrorResponse);
//     } // end of catch block
//   }
//
//
//   ApiResponse<T> _processResponse<T>(
//       Response response,
//       String? noDataEcCode,
//       ) {
//     if (response.statusCode != 200) {
//       return ApiResponse.error(
//         status: ApiStatus.SERVER_ERROR,
//         httpStatusCode: response.statusCode!,
//       );
//     }
//     final responseData = MapperFactory.map<T>(response.data);
//
//     if (responseData == null) {
//       return ApiResponse.error(
//         httpStatusCode: response.statusCode!,
//         status: ApiStatus.SERVER_ERROR,
//       );
//     }
//     print('processData failed');
//     return ApiResponse.success(
//       httpStatusCode: response.statusCode!,
//       data: responseData,
//     );
//   }
//
//   /// Handling exception thrown by dio client
//   ApiResponse<T> _handleError<T>(
//       Object error,
//       bool readErrorResponse,
//       ) {
//     int httpStatusCode = -1;
//     if (error is DioError && error.type == DioErrorType.cancel) {
//       return ApiResponse.error(
//         httpStatusCode: httpStatusCode,
//         status: ApiStatus.CANCELED,
//       );
//     }
//     if (error is DioError) {
//       debugPrint("readErrorResponse $readErrorResponse");
//       if (readErrorResponse && error.response?.data != null) {
//         final errorResponseData = error.response?.data;
//         //Handling HTML response
//         return ApiResponse.error(
//           httpStatusCode: httpStatusCode,
//           status: ApiStatus.SERVER_ERROR,
//         );
//       }else{
//         return ApiResponse.error(status: ApiStatus.SERVER_ERROR);
//       }
//     }else{
//       return ApiResponse.error(status: ApiStatus.SERVER_ERROR);
//     }
//   }
// }
//
