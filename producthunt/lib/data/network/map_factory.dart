// import 'package:producthunt/data/network/register_constructors.dart';
//
// class MapperFactory {
//   static Map<Type, dynamic Function(dynamic)> constructors = {};
//
//   static void registerConstructor<T>(T Function(dynamic) callback,) {
//     if (constructors[T] == null) constructors[T] = callback;
//   }
//
//   static void initialize() {
//     registerConstructors();
//   }
//
//   static T? map<T>(dynamic json) {
//     assert(
//     constructors[T] != null,
//     "A proper constructor callback must be registered for all api model classes. Couldn't find registry for $T",
//     );
//
//     if (json == null) return null;
//
//     return constructors[T]!(json) as T;
//   }
// }