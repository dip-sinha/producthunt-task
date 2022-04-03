// enum Status { EMPTY, LOADING, COMPLETED, ERROR }
//
// enum DataSource { NONE, API, CACHE }
//
// class Result<T> {
//   Status status;
//   T? data;
//   String? message;
//
//   Result.empty() : status = Status.EMPTY;
//
//   Result.loading() : status = Status.LOADING;
//
//   Result.completed(this.data) : status = Status.COMPLETED;
//
//   Result.error(this.message) : status = Status.ERROR;
//
//   @override
//   String toString() {
//     return "Status : $status \n Message : $message \n Data : $data";
//   }
// }