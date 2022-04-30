import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/database/database.dart';
import '../../data/korzina_hive/korzina_hive.dart';

part 'korzina_event.dart';

part 'korzina_state.dart';

class KorzinaBloc extends Bloc<KorzinaEvent, KorzinaState> {
  final Database cardDatabase;
  List<KorzinaCard> cards = [];

  KorzinaBloc({required this.cardDatabase}) : super(KorzinaInitial()) {
    on<KorzinaInitialEvent>((event, emit) async {
      emit(KorzinaLoadingState());
      await getCard();
      emit(YourKorzinaState(cards: cards));
    });
    on<KorzinaAddEvent>((event, emit) async {
      emit(KorzinaLoadingState());
      await korzinaAdd(
        id: event.id,
        name: event.name,
        category: event.category,
        currencyId: event.currencyId,
        currencyName: event.currencyName,
        price: event.price,
        residue: event.residue,
        size: event.size,
        image: event.image,
        blok: event.blok,
        dona: event.dona,
      );
      emit(YourKorzinaState(cards: cards));
    });
    on<KorzinaEditEvent>((event, emit) async {
      emit(KorzinaLoadingState());
      await korzinaUpdate(
        id: event.id,
        name: event.name,
        category: event.category,
        currencyId: event.currencyId,
        currencyName: event.currencyName,
        price: event.price,
        residue: event.residue,
        size: event.size,
        image: event.image,
        blok: event.blok,
        dona: event.dona,
      );
      emit(YourKorzinaState(cards: cards));
    });
    on<KorzinaDeleteEvent>((event, emit) async {
      emit(KorzinaLoadingState());
      await deleteCard(index: event.index);
      cards.sort((a, b) {
        var aData = a.name;
        var bData = b.name;
        return aData.compareTo(bData);
      });
      emit(YourKorzinaState(cards: cards));
    });
  }

  Future<void> getCard() async {
    await cardDatabase.getFullNote().then((value) => cards = value);
  }

  Future<void> deleteCard({required int index}) async {
    await cardDatabase.deleteElement(index);
    await getCard();
  }

  Future<void> korzinaAdd(
      {required int id,
      required String name,
      required String category,
      required int currencyId,
      required String currencyName,
      required String price,
      required int residue,
      required String size,
      required String image,
      required String dona,
      required String blok}) async {
    await cardDatabase.addElement(KorzinaCard(
        id: id,
        name: name,
        category: category,
        currencyId: currencyId,
        currencyName: currencyName,
        price: price,
        residue: residue,
        size: size,
        image: image,
        dona: dona,
        blok: blok));
    await getCard();
  }

  Future<void> korzinaUpdate(
      {required int id,
      required String name,
      required String category,
      required int currencyId,
      required String currencyName,
      required String price,
      required int residue,
      required String size,
      required String image,
      required String dona,
      required String blok}) async {
    await cardDatabase.updateElement(
        id,
        KorzinaCard(
            id: id,
            name: name,
            category: category,
            currencyId: currencyId,
            currencyName: currencyName,
            price: price,
            residue: residue,
            size: size,
            image: image,
            dona: dona,
            blok: blok));
    await getCard();
  }
}
