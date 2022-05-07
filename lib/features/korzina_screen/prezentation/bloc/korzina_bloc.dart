import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/buyurtma_usescase.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/error_model.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';

import '../../domain/usescase/u_order_list.dart';

part 'korzina_event.dart';

part 'korzina_state.dart';

class KorzinaBloc extends Bloc<KorzinaEvent, KorzinaState> {
  // final Database cardDatabase;
  // List<KorzinaCard> cards = [];
  final UsesBuyurtma usesBuyurtma;
  final UKorzinaOrderList karzina;

  KorzinaBloc({required this.usesBuyurtma, required this.karzina}) : super(KorzinaInitial()) {
    on<KorzinaInitialEvent>(initialState, transformer: sequential());
    on<KorzinaSendDataEvent>(getBuyurtma, transformer: sequential());
  }

  FutureOr<void> initialState(
      KorzinaInitialEvent event, Emitter<KorzinaState> emit) async {
    emit(KorzinaLoadingState());
    final result = await usesBuyurtma(BuyurtmaParams());

    var box = Hive.box<KorzinaCard>(korzinaBox);
    var transaction = box.values.toList().cast<KorzinaCard>();
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(KorzinaNoInternetState(message: failure.message))}
              else if (failure is ServerFailure)
                {emit(KorzinaFailureState(message: failure.message))}
            },
        (r) => {
              if (transaction.isEmpty)
                {
                  emit(KorzinaSuccessState(
                      buyurtmaList: r, korzinaSaveList: const []))
                }
              else
                {
                  emit(KorzinaSuccessState(
                      korzinaSaveList: transaction, buyurtmaList: r))
                }
            });
  }

  FutureOr<void> getBuyurtma(
      KorzinaSendDataEvent event, Emitter<KorzinaState> emit) async {
    emit(KorzinaLoadingState());
    final result = await karzina(GetOrderListParams(listSendData: event.card));
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(KorzinaNoInternetState(message: failure.message))}
              else if (failure is ServerFailure)
                {emit(KorzinaFailureState(message: failure.message))}
            },
        (r) => {
          if (r.isNotEmpty)
            {emit(const KorzinaErrorMessageState(korzinaErrorList: []))}
          else
            {emit(KorzinaErrorMessageState(korzinaErrorList: r))}
    });
  }
}
// on<KorzinaInitialEvent>((event, emit) async {
//   //   emit(KorzinaLoadingState());
//   //   await getCard();
//   //   emit(YourKorzinaState(cards: cards));
//   // });
//   // on<KorzinaAddEvent>((event, emit) async {
//   //   emit(KorzinaLoadingState());
//   //   await korzinaAdd(
//   //     bloklarSoni: event.bloklarSoni,
//   //     blok: event.blok,
//   //     id: event.id,
//   //     name: event.name,
//   //     category: event.category,
//   //     currencyId: event.currencyId,
//   //     currencyName: event.currencyName,
//   //     price: event.price,
//   //     residue: event.residue,
//   //     size: event.size,
//   //     image: event.image,
//   //     dona: event.dona,
//   //   );
//   //   emit(YourKorzinaState(cards: cards));
//   // });
//   // on<KorzinaEditEvent>((event, emit) async {
//   //   emit(KorzinaLoadingState());
//   //   await korzinaUpdate(
//   //     bloklarSoni: event.bloklarSoni,
//   //     id: event.id,
//   //     name: event.name,
//   //     category: event.category,
//   //     currencyId: event.currencyId,
//   //     currencyName: event.currencyName,
//   //     price: event.price,
//   //     residue: event.residue,
//   //     size: event.size,
//   //     image: event.image,
//   //     blok: event.blok,
//   //     dona: event.dona,
//   //   );
//   //   emit(YourKorzinaState(cards: cards));
//   // });
//   // on<KorzinaDeleteEvent>((event, emit) async {
//   //   emit(KorzinaLoadingState());
//   //   await deleteCard(index: event.index);
//   //   cards.sort((a, b) {
//   //     var aData = a.name;
//   //     var bData = b.name;
//   //     return aData.compareTo(bData);
//   //   });
//   //   emit(YourKorzinaState(cards: cards));
//   // });
//
// }}
// }
//
//   Future<void> getCard() async {
//     await cardDatabase.getFullNote().then((value) => cards = value);
//   }
//
//   Future<void> deleteCard({required int index}) async {
//     await cardDatabase.deleteElement(index);
//     await getCard();
//   }
//
//   Future<void> korzinaAdd(
//       {required int id,
//       required String name,
//       required String category,
//       required int currencyId,
//       required String currencyName,
//       required String price,
//       required int residue,
//       required String size,
//       required String image,
//       required String dona,
//       required String blok,
//       required String bloklarSoni}) async {
//     await cardDatabase.addElement(KorzinaCard(
//         id: id,
//         blok: blok,
//         name: name,
//         category: category,
//         currencyId: currencyId,
//         currencyName: currencyName,
//         price: price,
//         residue: residue,
//         size: size,
//         image: image,
//         dona: dona,
//         bloklarSoni: bloklarSoni));
//     await getCard();
//   }
//
//   Future<void> korzinaUpdate(
//       {required int id,
//       required String name,
//       required String category,
//       required int currencyId,
//       required String currencyName,
//       required String price,
//       required int residue,
//       required String size,
//       required String image,
//       required String dona,
//       required String blok,
//       required String bloklarSoni}) async {
//     await cardDatabase.updateElement(
//         id,
//         KorzinaCard(
//             blok: blok,
//             id: id,
//             name: name,
//             category: category,
//             currencyId: currencyId,
//             currencyName: currencyName,
//             price: price,
//             residue: residue,
//             size: size,
//             image: image,
//             dona: dona,
//             bloklarSoni: bloklarSoni));
//     await getCard();
//   }
// }
