import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:savdo_agnet_client/core/photo/image_picker_utils.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/datasources/buyurtma_locale_datasource.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/currency_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/repository/buyurtma_repository_impl.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/repositories/buyurtma_repository.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/buyurtma_usescase.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/buyurtma_usescase_local.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/select_usescase.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/bloc/buyurtma_bloc/buyurtma_dialog_bloc.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/bloc/qarizdorlik_bloc/qarizdorlik_bloc.dart';
import 'package:savdo_agnet_client/features/firmalar/presentation/bloc/firma_cubit.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/datasources/korzina_remote_datasources.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/repositories/korzina_repository.dart';
import 'package:savdo_agnet_client/features/korzina_screen/domain/repositories/i_korzina_repository.dart';
import 'package:savdo_agnet_client/features/korzina_screen/domain/usescase/u_order_list.dart';
import 'package:savdo_agnet_client/features/korzina_screen/prezentation/bloc/korzina_bloc.dart';
import 'package:savdo_agnet_client/features/lock/domain/bloc/pass_bloc.dart';
import 'package:savdo_agnet_client/features/lock/domain/repositories/lock_repositories.dart';
import 'package:savdo_agnet_client/features/password/presentation/bloc/pin_bloc.dart';
import 'package:savdo_agnet_client/features/product/data/datasource/product_local_datasources.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_model.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:savdo_agnet_client/features/product/data/model/category_model.dart';
import 'package:savdo_agnet_client/features/product/data/repositories/repository_impl.dart';
import 'package:savdo_agnet_client/features/product/domain/repositories/catalog_repository.dart';
import 'package:savdo_agnet_client/features/product/domain/usescase/brandProducts.dart';
import 'package:savdo_agnet_client/features/product/domain/usescase/catalog.dart';
import 'package:savdo_agnet_client/features/product_items/data/datasource/product_local_datasources.dart';
import 'package:savdo_agnet_client/features/product_items/data/datasource/product_remote_datasources.dart';
import 'package:savdo_agnet_client/features/product_items/data/repositories/repository_impl.dart';
import 'package:savdo_agnet_client/features/product_items/domain/repositories/brand_products_repository.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/bloc/brand_products/brands_products_bloc.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/bloc/product_items_cubit.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/client_model.dart';
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
import '../features/product/presentation/bloc/catalog/category_bloc.dart';
import '../features/select_client/data/datasources/client_local_datasource.dart';
import '../features/select_client/data/datasources/client_remote_datasource.dart';
import '../features/select_client/presentation/bloc/client/select_client_bloc.dart';

final di = GetIt.instance;

//di is referred to as Service Locator

Future<void> init() async {
  /// bloc
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
    () => BuyurtmaDialogBloc(usesBuyurtma: di(),usesBuyurtmaLocal: di()),
  );
  di.registerFactory(
    () => QarizdorlikBloc(onSelectClient: di()),
  );
  di.registerFactory(
    () => KorzinaBloc(usesBuyurtma: di(), karzina: di()),
  );

  di.registerFactory(
    () => BrandsProductsBloc(brandProducts: di()),
  );

  ///Repositories

  di.registerLazySingleton<PassRepository>(
    () => PassRepositoryImpl(passLocalDataSource: di()),
  );
  di.registerLazySingleton<KorzinaRepository>(
    () => KorzinaRepositoryImpl(
      remoteDatasource: di(),
      networkInfo: di(),
    ),
  );

  di.registerLazySingleton<CatalogRepository>(
    () => CategoryRepositoryImpl(
      categoryLocalDatasourceImpl: di(),
      categoryRemoteDatasourceImpl: di(),
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
      localeDatasourceImpl: di(),
      remoteDataSourceImpl: di(),
    ),
  );
  di.registerLazySingleton<BrandProductsRepository>(
    () => BrandProductsRepositoryImpl(
      localDataSource: di(),
      networkInfo: di(),
      remoteDatasource: di(),
    ),
  );

  /// UsesCases
  //   di.registerLazySingleton(() => SendData(sendDataRepository: di()));
  di.registerLazySingleton(() => UKorzinaOrderList(korzinaRepository: di()));
  di.registerLazySingleton(() => Pass(repository: di()));
  di.registerLazySingleton(() => ProductCatalog(catalogRepository: di()));
  di.registerLazySingleton(() => BrandCatalog(catalogRepository: di()));
  di.registerLazySingleton(() => BrandProductsCatalog(catalogRepository: di()));
  di.registerLazySingleton(() => UsesSelectClient(clientRepository: di()));
  di.registerLazySingleton(() => UsesBuyurtma(repository: di()));
  di.registerLazySingleton(() => UsesBuyurtmaLocal(repository: di()));
  di.registerLazySingleton(() => OnSelectClient(clientRepository: di()));

  /// Data sources
  di.registerLazySingleton(
    () => PassLocalDataSourceImpl(sharedPreferences: di()),
  );

  di.registerLazySingleton(
    () => CategoryRemoteDatasourceImpl(client: di()),
  );
  di.registerLazySingleton(
    () => CategoryLocalDataSourceImpl(),
  );
  di.registerLazySingleton(
    () => BrandProductsLocalDataSourceImpl(),
  );
  di.registerLazySingleton(
    () => BrandProductsRemoteDatasourceImpl(
        sharedPreferences: di(), client: di()),
  );

  di.registerLazySingleton(
    () =>
        SelectClientRemoteDataSourceImpl(sharedPreferences: di(), client: di()),
  );
  di.registerLazySingleton(
    () => SelectClientLocalDataSourceImpl(),
  );
  di.registerLazySingleton(
    () => BuyurtmaRemoteDataSourceImpl(client: di()),
  );
  di.registerLazySingleton(
    () => BuyurtmaLocaleDatasourceImpl(),
  );
  di.registerLazySingleton<KorzinaOrderRemoteDatasource>(
    () => KorzinaOrderRemoteDatasourceImpl(client: di()),
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
  await Hive.openBox<KorzinaCard>(korzinaBox);

  // category
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox(categoryBox);

  // brand
  Hive.registerAdapter(BrandModelAdapter());
  await Hive.openBox(brandBox);

  // brandProducts
  Hive.registerAdapter(BrandProductModelAdapter());
  await Hive.openBox(brandProductsBox);

  // clientModel
  Hive.registerAdapter(ClientModelAdapter());
  await Hive.openBox(clientBox);

  // debit credit model
  // Hive.registerAdapter(ClientDebitCreditModelAdapter());
  // await Hive.openBox(clientDebitCreditBox);

  // currency model
  Hive.registerAdapter(CurrencyModelAdapter());
  await Hive.openBox(currencyBox);

  // price type model
  Hive.registerAdapter(PriceTypeModelAdapter());
  await Hive.openBox(priceTypeBox);

  // buyurtma dialog
  Hive.registerAdapter(BuyurtmaModelAdapter());
  await Hive.openBox(buyurtmaBox);
}
