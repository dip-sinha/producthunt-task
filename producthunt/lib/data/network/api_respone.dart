
enum ApiStatus {
  EMPTY,
  NO_DATA,
  LOADING,
  SUCCESS,
  NETWORK_ERROR,
  SERVER_ERROR,
  CLIENT_ERROR,
  CANCELED,
}

class ApiResponse<T> {
  int httpStatusCode = -1;
  ApiStatus status;
  T? data;

  ApiResponse.empty() : status = ApiStatus.EMPTY;

  ApiResponse.loading() : status = ApiStatus.LOADING;

  ApiResponse.success({
    required this.httpStatusCode,
    this.data,
  }) : status = ApiStatus.SUCCESS;

  ApiResponse.error({
    this.httpStatusCode = -1,
    required this.status,
    this.data,
  });

  bool get success => status == ApiStatus.SUCCESS;
}