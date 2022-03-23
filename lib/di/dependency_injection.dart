import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:savdo_agnet_client/core/photo/image_picker_utils.dart';
import 'package:savdo_agnet_client/features/firmalar/presentation/bloc/firma_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/location/location_service.dart';
import '../core/network/network_info.dart';

final di = GetIt.instance;
//di is referred to as Service Locator

Future<void> init() async {
  /// bloc
  // di.registerFactory(
  //   () => NotSendBloc(notSend: di(), notSendLocal: di()),
  // );
  di.registerFactory(
    () => SearchFirmaItemsCubit(
        id: di(), title: di(), image: di(), maxsulotlarBulimiCubit: di()),
  );

  ///Repositories
  // di.registerLazySingleton<SendDataRepository>(
  //   () => SendDataRepositoryImpl(
  //       networkInfo: di(),
  //       dataRemoteDatasource: di(),
  //       sharedPreferences: di(),
  //       dataLocalDatasource: di()),
  // );

  /// UsesCases
  //   di.registerLazySingleton(() => SendData(sendDataRepository: di()));

  /// Data sources
  // di.registerLazySingleton(
  //   () => SendDataRemoteDatasourceImpl(sharedPreferences: di(), client: di()),
  // );

  /// Image picker
  di.registerLazySingleton<ImagePickerUtils>(() => ImagePickerUtilsImpl());

  /// Location Service
  di.registerLazySingleton<LocationService>(() => LocationServiceImpl());

  /// Network
  di.registerLazySingleton<http.Client>(() => http.Client());

  /// Network Info
  di.registerLazySingleton(() => InternetConnectionChecker());

  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));

  /// Local cache
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPreferences);

  /// Local datasource
  await Hive.initFlutter();
  // home
  // Hive.registerAdapter(CategoryModelAdapter());
  // await Hive.openBox(categoryBox);
}
