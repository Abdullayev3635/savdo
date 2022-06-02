import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:savdo_agnet_client/core/photo/image_picker_utils.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/add_client/data/datasource/add_client_remote_datasource.dart';
import 'package:savdo_agnet_client/features/add_client/data/repository/repository_impl.dart';
import 'package:savdo_agnet_client/features/add_client/domain/repository/client_repository.dart';
import 'package:savdo_agnet_client/features/add_client/domain/usescase/usescase.dart';
import 'package:savdo_agnet_client/features/add_client/domain/usescase/validate_name_usescase.dart';
import 'package:savdo_agnet_client/features/add_client/domain/usescase/validate_phone_usescase.dart';
import 'package:savdo_agnet_client/features/add_client/presentation/bloc/add_client_bloc.dart';
import 'package:savdo_agnet_client/features/archive/data/datasource/archive_remote_datasource.dart';
import 'package:savdo_agnet_client/features/archive/data/repository/archive_repository_impl.dart';
import 'package:savdo_agnet_client/features/archive/domain/repository/archive_repository.dart';
import 'package:savdo_agnet_client/features/archive/domain/usescase/archive_usescase.dart';
import 'package:savdo_agnet_client/features/archive/presentation/bloc/archive_bloc.dart';
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
import 'package:savdo_agnet_client/features/edit_client/data/datasource/edit_client_remotedatasource.dart';
import 'package:savdo_agnet_client/features/edit_client/data/repository/repository.dart';
import 'package:savdo_agnet_client/features/edit_client/domain/repository/repository.dart';
import 'package:savdo_agnet_client/features/edit_client/domain/usescase/usescase.dart';
import 'package:savdo_agnet_client/features/edit_client/presentation/bloc/edit_client_bloc.dart';
import 'package:savdo_agnet_client/features/firmalar/presentation/bloc/firma_cubit.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/data/datasources/foto_remote_datasource.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/data/repository/foto_repository_impl.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/domain/repositories/foto_repository.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/domain/usescase/foto_xisobot_usescase.dart';
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
import 'package:savdo_agnet_client/features/product/domain/usescase/brand_products.dart';
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
import 'package:savdo_agnet_client/features/select_client/domain/usescase/client_usescase_local.dart';
import 'package:savdo_agnet_client/features/select_region/data/datasources/region_local_datasource.dart';
import 'package:savdo_agnet_client/features/select_region/data/datasources/region_remote_datasource.dart';
import 'package:savdo_agnet_client/features/select_region/data/model/region_model.dart';
import 'package:savdo_agnet_client/features/select_region/data/repository/region_repository.dart';
import 'package:savdo_agnet_client/features/select_region/domain/repositories/region_repository.dart';
import 'package:savdo_agnet_client/features/select_region/domain/usescase/region_usescase.dart';
import 'package:savdo_agnet_client/features/select_region/domain/usescase/region_usescase_local.dart';
import 'package:savdo_agnet_client/features/select_region/presentation/bloc/region_bloc.dart';
import 'package:savdo_agnet_client/features/select_viloyat/data/datasources/viloyat_local_datasource.dart';
import 'package:savdo_agnet_client/features/select_viloyat/data/datasources/viloyat_remote_datasource.dart';
import 'package:savdo_agnet_client/features/select_viloyat/data/model/viloyat_model.dart';
import 'package:savdo_agnet_client/features/select_viloyat/data/repository/viloyat_repository.dart';
import 'package:savdo_agnet_client/features/select_viloyat/domain/repositories/viloyat_repository.dart';
import 'package:savdo_agnet_client/features/select_viloyat/domain/usescase/viloyat_usescase.dart';
import 'package:savdo_agnet_client/features/select_viloyat/presentation/bloc/client/viloyat_bloc.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/data/datasources/tulov_remote_datasource.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/data/repository/tulov_repository_impl.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/domain/repositories/tulov_repository.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/domain/usescase/select_client_tulov_usescase.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/domain/usescase/tulov_qilish_usescase.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/presentation/bloc/qarizdorlik_bloc/tulov_qarizdorlik_bloc.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/data/datasources/tt_local_datasource.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/data/datasources/tt_remote_datasource.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/data/model/tulov_turi_model.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/data/repository/tt_repository.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/domain/repositories/tulov_turi_repository.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/domain/usescase/tulov_turi_usescase.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/domain/usescase/tulov_turi_usescase_local.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/presentation/bloc/select_tt_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/location/location_service.dart';
import '../core/network/network_info.dart';
import '../features/buyurtma/data/datasources/buyurtma_remote_datasource.dart';
import '../features/foto_xisobot/presentation/bloc/foto_bloc.dart';
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
import '../features/select_viloyat/domain/usescase/viloyat_usescase_local.dart';

final di = GetIt.instance;

//di is referred to as Service Locator

Future<void> init() async {
  /// bloc
  di.registerFactory(
    () => EditClientBloc(editClientUsescase: di()),
  );
  di.registerFactory(
    () => SearchFirmaItemsCubit(
        id: di(), title: di(), image: di(), maxsulotlarBulimiCubit: di()),
  );
  di.registerFactory(
    () => ViloyatBloc(
      usesSelectViloyatLocal: di(),
      usesSelectViloyat: di(),
    ),
  );
  di.registerFactory(
    () => CatalogBloc(product: di()),
  );
  di.registerFactory(() => AddClientBloc(
      usesValidatePhone: di(), usesClient: di(), usesValidateName: di()));
  di.registerFactory(
    () => FotoBloc(fotoUsesCase: di()),
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
    () => SelectClientBloc(usesSelectClient: di(), usesSelectClientLocal: di()),
  );
  di.registerFactory(
    () => SelectTulovTuriBloc(usesTulovTuri: di(), usesTulovTuriLocal: di()),
  );
  di.registerFactory(
    () => BuyurtmaDialogBloc(usesBuyurtma: di(), usesBuyurtmaLocal: di()),
  );
  di.registerFactory(
    () => QarizdorlikBloc(onSelectClient: di()),
  );
  di.registerFactory(
    () => KorzinaBloc(usesBuyurtmaLocal: di(), karzina: di()),
  );

  di.registerFactory(
    () => BrandsProductsBloc(brandProducts: di()),
  );
  di.registerFactory(
    () => TulovQarizdorlikBloc(
        onSelectClientTulov: di(), tulovQilishUsescase: di()),
  );
  di.registerFactory(
    () => RegionBloc(usesRegionLocal: di(), usesSelectRegion: di()),
  );
  di.registerFactory(
    () => ArchiveBloc(archiveUsescase: di()),
  );

  ///********************************************************///
  ///
  ///Repositories

  di.registerLazySingleton<EditClientRepository>(
    () => EditClientRepositoryImpl(
      networkInfo: di(),
      remoteDatasourceImpl: di(),
    ),
  );
  di.registerLazySingleton<PassRepository>(
    () => PassRepositoryImpl(passLocalDataSource: di()),
  );
  di.registerLazySingleton<KorzinaRepository>(
    () => KorzinaRepositoryImpl(
      remoteDatasource: di(),
      networkInfo: di(),
    ),
  );

  di.registerLazySingleton<SelectViloyatRepository>(
    () => ViloyatRepositoryImpl(
      localDataSourceImpl: di(),
      networkInfo: di(),
      remoteDataSourceImpl: di(),
    ),
  );

  di.registerLazySingleton<SelectRegionRepository>(
    () => RegionRepositoryImpl(
      localDataSourceImpl: di(),
      networkInfo: di(),
      regionRemoteDatasourceImpl: di(),
    ),
  );

  di.registerLazySingleton<CatalogRepository>(
    () => CategoryRepositoryImpl(
      categoryLocalDatasourceImpl: di(),
      categoryRemoteDatasourceImpl: di(),
      networkInfo: di(),
    ),
  );

  di.registerLazySingleton<SelectTulovTuriRepository>(
    () => SelectTulovTuriRepositoryImpl(
      localDataSourceImpl: di(),
      remoteDataSourceImpl: di(),
      networkInfo: di(),
    ),
  );

  di.registerLazySingleton<AddClientRepository>(
    () => AddClientRepositoryImpl(
      networkInfo: di(),
      remoteDatasource: di(),
    ),
  );

  di.registerLazySingleton<FotoRepository>(
    () => FotoRepositoryImpl(
      fotoRemoteDataSourceImpl: di(),
      networkInfo: di(),
    ),
  );
  di.registerLazySingleton<TulovRepository>(
    () => TulovRepositoryImpl(
      remoteDataSourceImpl: di(),
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
  di.registerLazySingleton<ArchiveRepository>(
    () => ArchiveRepositoryImpl(
      networkInfo: di(),
      remoteDatasourceImpl: di(),
    ),
  );

  ///********************************************************///
  /// UsesCases

  di.registerLazySingleton(() => UKorzinaOrderList(korzinaRepository: di()));

  di.registerLazySingleton(() => Pass(repository: di()));

  di.registerLazySingleton(() => OnSelectClientTulov(tulovRepository: di()));

  di.registerLazySingleton(() => OnTulovQilishUsescase(tulovRepository: di()));

  di.registerLazySingleton(() => ProductCatalog(catalogRepository: di()));

  di.registerLazySingleton(() => BrandCatalog(catalogRepository: di()));

  di.registerLazySingleton(() => BrandProductsCatalog(catalogRepository: di()));

  di.registerLazySingleton(() => UsesSelectClient(clientRepository: di()));

  di.registerLazySingleton(() => UsesBuyurtma(repository: di()));

  di.registerLazySingleton(() => UsesBuyurtmaLocal(repository: di()));

  di.registerLazySingleton(
      () => OnSelectClientUsescase(clientRepository: di()));

  di.registerLazySingleton(() => FotoUsesCase(fotoRepository: di()));

  di.registerLazySingleton(() => UsesClientLocal(repository: di()));

  di.registerLazySingleton(() => UsesTulovTuriLocal(repository: di()));

  di.registerLazySingleton(() => UsesTulovTuri(tulovTuriRepository: di()));

  di.registerLazySingleton(() => UsesSelectViloyat(clientRepository: di()));

  di.registerLazySingleton(() => UsesViloyatLocal(repository: di()));

  di.registerLazySingleton(() => UsesRegionLocal(regionRepository: di()));

  di.registerLazySingleton(() => UsesSelectRegion(regionRepository: di()));

  di.registerLazySingleton(() => UsesAddClient(clientRepository: di()));

  di.registerLazySingleton(() => UsesValidateName(clientRepository: di()));

  di.registerLazySingleton(() => UsesValidatePhone(clientRepository: di()));

  di.registerLazySingleton(() => EditClientUsescase(repository: di()));

  di.registerLazySingleton(() => ArchiveUsescase(archiveRepository: di()));

  ///********************************************************///
  ///
  /// Data sources
  di.registerLazySingleton(
    () => PassLocalDataSourceImpl(sharedPreferences: di()),
  );
  di.registerLazySingleton(
    () => ViloyatLocalDataSourceImpl(),
  );
  di.registerLazySingleton(
    () => ViloyatRemoteDataSourceImpl(
      sharedPreferences: di(),
      client: di(),
    ),
  );
  di.registerLazySingleton(() => RegionLocalDataSourceImpl());

  di.registerLazySingleton(
      () => RegionRemoteDatasourceImpl(sharedPreferences: di(), client: di()));

  di.registerLazySingleton(
    () => FotoRemoteDataSourceImpl(),
  );
  di.registerLazySingleton(
    () => AddClientRemoteDatasourceImpl(client: di()),
  );
  di.registerLazySingleton(
    () => SelectTulovTuriLocalDataSourceImpl(),
  );

  di.registerLazySingleton(
    () => SelectTulovTuriRemoteDataSourceImpl(
        sharedPreferences: di(), client: di()),
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
    () => TulovRemoteDataSourceImpl(client: di()),
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
  di.registerLazySingleton(
    () => EditClientRemoteDatasourceImpl(client: di()),
  );
  di.registerLazySingleton(
    () => ArchiveRemoteDatasourceImpl(client: di()),
  );

  ///********************************************************///
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

  // to'lov turi dialog
  Hive.registerAdapter(TulovTuriModelAdapter());
  await Hive.openBox(tulovTuriBox);

  // viloyatlar ro'yxati dialog
  Hive.registerAdapter(ViloyatModelAdapter());
  await Hive.openBox(viloyatBox);

  // region ro'yxati dialog
  Hive.registerAdapter(RegionModelAdapter());
  await Hive.openBox(regionBox);
}
