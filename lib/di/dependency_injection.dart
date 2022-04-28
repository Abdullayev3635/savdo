import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:savdo_agnet_client/core/photo/image_picker_utils.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/repository/buyurtma_repository_impl.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/repositories/buyurtma_repository.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/buyurtma_usescase.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/select_usescase.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/bloc/buyurtma_bloc/buyurtma_dialog_bloc.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/bloc/qarizdorlik_bloc/qarizdorlik_bloc.dart';
import 'package:savdo_agnet_client/features/firmalar/presentation/bloc/firma_cubit.dart';
import 'package:savdo_agnet_client/features/lock/domain/bloc/pass_bloc.dart';
import 'package:savdo_agnet_client/features/lock/domain/repositories/lock_repositories.dart';
import 'package:savdo_agnet_client/features/password/presentation/bloc/pin_bloc.dart';
import 'package:savdo_agnet_client/features/product/data/datasource/product_local_datasources.dart';
import 'package:savdo_agnet_client/features/product/data/repositories/repository_impl.dart';
import 'package:savdo_agnet_client/features/product/domain/repositories/catalog_repository.dart';
import 'package:savdo_agnet_client/features/product/domain/usescase/catalog.dart';

import 'package:savdo_agnet_client/features/product_items/presentation/bloc/product_items_cubit.dart';
import 'package:savdo_agnet_client/features/select_client/data/repository/select_client_repository.dart';
import 'package:savdo_agnet_client/features/select_client/domain/repositories/client_repository.dart';
import 'package:savdo_agnet_client/features/select_client/domain/usescase/client_usescase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/location/location_service.dart';
import '../core/network/network_info.dart';
import '../features/buyurtma/data/datasources/buyurtma_remote_datasource.dart';
import '../features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import '../features/lock/data/datasources/lock_local_datasources.dart';
import '../features/lock/data/repositories/lock_repositories.dart';
import '../features/lock/domain/usescases/u_lock.dart';
import '../features/product/data/datasource/product_remote_datasources.dart';
import '../features/product/domain/usescase/brand.dart';
import '../features/product/presentation/bloc/brand/brand_bloc.dart';
import '../features/product/presentation/bloc/catalog/catalog_bloc.dart';
import '../features/select_client/data/datasources/client_local_datasource.dart';
import '../features/select_client/data/datasources/client_remote_datasource.dart';
import '../features/select_client/presentation/bloc/client/select_client_bloc.dart';

final di = GetIt.instance;

//di is referred to as Service Locator

Future<void> init() async {
  /// buyurtma_bloc
  di.registerFactory(
    () => SearchFirmaItemsCubit(
        id: di(), title: di(), image: di(), maxsulotlarBulimiCubit: di()),
  );
  di.registerFactory(
    () => CatalogBloc(product: di()),
  );
  di.registerFactory(
    () => BrandBloc(brandCategory: di()),
  );
  di.registerFactory(
    () => PassBloc(pass: di()),
  );
  di.registerFactory(
    () => ProductItemsCubit(maxsulotlarBulimiCubit: di()),
  );
  di.registerFactory(
    () => PinBloc(sharedPreferences: di()),
  );
  di.registerFactory(
    () => SelectClientBloc(usesSelectClient: di()),
  );
  di.registerFactory(
    () => BuyurtmaDialogBloc(usesBuyurtma: di()),
  );
  di.registerFactory(
    () => QarizdorlikBloc(onSelectClient: di()),
  );

  ///Repositories

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

  di.registerLazySingleton<SelectCaARepository>(
    () => SelectClientRepositoryImpl(
      localDataSourceImpl: di(),
      networkInfo: di(),
      remoteDataSourceImpl: di(),
    ),
  );
  di.registerLazySingleton<BuyurtmaRepository>(
    () => BuyurtmaRepositoryImpl(
      networkInfo: di(),
      remoteDataSourceImpl: di(),
    ),
  );

  /// UsesCases
  //   di.registerLazySingleton(() => SendData(sendDataRepository: di()));

  di.registerLazySingleton(() => Pass(repository: di()));
  di.registerLazySingleton(() => ProductCatalog(catalogRepository: di()));
  di.registerLazySingleton(() => BrandCatalog(catalogRepository: di()));
  di.registerLazySingleton(() => UsesSelectClient(clientRepository: di()));
  di.registerLazySingleton(() => UsesBuyurtma(repository: di()));
  di.registerLazySingleton(() => OnSelectClient(clientRepository: di()));

  /// Data sources
  // di.registerLazySingleton(
  //   () => SendDataRemoteDatasourceImpl(sharedPreferences: di(), client: di()),
  // );

  di.registerLazySingleton(
    () => PassLocalDataSourceImpl(sharedPreferences: di()),
  );

  di.registerLazySingleton(
    () => CatalogRemoteDatasourceImpl(client: di()),
  );
  di.registerLazySingleton(
    () => CatalogLocalDataSourceImpl(),
  );

  di.registerLazySingleton(
    () =>
        SelectClientRemoteDataSourceImpl(sharedPreferences: di(), client: di()),
  );
  di.registerLazySingleton(
    () => SelectClientLocalDataSourceImpl(sharedPreferences: di()),
  );
  di.registerLazySingleton(
    () => BuyurtmaRemoteDataSourceImpl(client: di()),
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
  // korzina
  Hive.registerAdapter(KorzinaCardAdapter());
  await Hive.openBox(korzinaBox);
  // client dialog
  // buyurtma dialog
  // Hive.registerAdapter(BuyurtmaModelAdapter());
  // await Hive.openBox(buyurtmaBox);

  // home
  // Hive.registerAdapter(CategoryModelAdapter());
  // await Hive.openBox(categoryBox);
}
