import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:savdo_agnet_client/core/photo/image_picker_utils.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/firmalar/presentation/bloc/firma_cubit.dart';
import 'package:savdo_agnet_client/features/lock/domain/bloc/pass_bloc.dart';
import 'package:savdo_agnet_client/features/lock/domain/repositories/lock_repositories.dart';
import 'package:savdo_agnet_client/features/product/data/datasource/product_local_datasources.dart';
import 'package:savdo_agnet_client/features/product/data/model/category_model1.dart';
import 'package:savdo_agnet_client/features/product/data/repositories/repository_impl.dart';
import 'package:savdo_agnet_client/features/product/domain/repositories/catalog_repository.dart';
import 'package:savdo_agnet_client/features/product/domain/usescase/usescase.dart';
import 'package:savdo_agnet_client/features/product/presentation/bloc/catalog_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/location/location_service.dart';
import '../core/network/network_info.dart';
import '../features/lock/data/datasources/lock_local_datasources.dart';
import '../features/lock/data/repositories/lock_repositories.dart';
import '../features/lock/domain/usescases/u_lock.dart';

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
  di.registerFactory(
    () => CatalogBloc(home: di()),
  );
  di.registerFactory(
    () => PassBloc(pass: di()),
  );

  ///Repositories
  // di.registerLazySingleton<SendDataRepository>(
  //   () => SendDataRepositoryImpl(
  //       networkInfo: di(),
  //       dataRemoteDatasource: di(),
  //       sharedPreferences: di(),
  //       dataLocalDatasource: di()),
  // );

  di.registerLazySingleton<PassRepository>(
    () => PassRepositoryImpl(passLocalDataSource: di()),
  );
  di.registerLazySingleton<CatalogRepository>(
    () => CatalogRepositoryImpl(
      homeLocalDatasourceImpl: di(),
      homeRemoteDatasourceImpl: di(),
      networkInfo: di(),
    ),
  );

  /// UsesCases
  //   di.registerLazySingleton(() => SendData(sendDataRepository: di()));

  di.registerLazySingleton(() => Pass(repository: di()));
  di.registerLazySingleton(() => ProductCatalog(catalogRepository: di()));

  /// Data sources
  // di.registerLazySingleton(
  //   () => SendDataRemoteDatasourceImpl(sharedPreferences: di(), client: di()),
  // );
  di.registerLazySingleton(
    () => PassLocalDataSourceImpl(sharedPreferences: di()),
  );
  di.registerLazySingleton(
    () => CatalogLocalDataSourceImpl(),
  );

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
  Hive.registerAdapter(CatalogModelAdapter());
  await Hive.openBox(catalogBox);


  // home
  // Hive.registerAdapter(CategoryModelAdapter());
  // await Hive.openBox(categoryBox);
}
