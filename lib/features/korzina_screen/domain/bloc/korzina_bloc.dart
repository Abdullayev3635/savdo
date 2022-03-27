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

  KorzinaBloc(this.cardDatabase) : super(KorzinaInitial()) {
    on<KorzinaInitialEvent>((event, emit) async {
      emit(KorzinaLoadingState());
      await getCard();
      emit(YourKorzinaState(cards: cards));
    });
    on<KorzinaAddEvent>((event, emit) async {
      emit(KorzinaLoadingState());
      await korzinaAdd(
        rating: event.rating,
        carType: event.carType,
        hajmi: event.hajmi,
        price: event.price,
        image: event.image,
        title: event.title,
        id: event.id,
        number: event.number,
        valyuta: event.valyuta,
      );
      emit(YourKorzinaState(cards: cards));
    });
    on<KorzinaEditEvent>((event, emit) async {
      emit(KorzinaLoadingState());
      await korzinaUpdate(
        rating: event.rating,
        carType: event.carType,
        hajmi: event.hajmi,
        price: event.price,
        image: event.image,
        title: event.title,
        id: event.id,
        number: event.number,
        valyuta: event.valyuta,
      );
      emit(YourKorzinaState(cards: cards));
    });
    on<KorzinaDeleteEvent>((event, emit) async {
      emit(KorzinaLoadingState());
      await deleteCard(index: event.index);
      cards.sort((a, b) {
        var aData = a.title;
        var bData = b.title;
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
      {required String title,
      required String image,
      required int price,
      required String hajmi,
      required String carType,
      required int id,
      required int rating,
      required String valyuta,
      required int number}) async {
    await cardDatabase.addElement(KorzinaCard(
        hajmi: hajmi,
        price: price,
        image: image,
        title: title,
        id: id,
        number: number,
        carType: carType,
        rating: rating,
        valyuta: valyuta));
    await getCard();
  }

  Future<void> korzinaUpdate(
      {required String title,
        required String image,
        required int price,
        required String hajmi,
        required String carType,
        required int id,
        required int rating,
        required String valyuta,
        required int number}) async {
    await cardDatabase.updateElement(
        id,
        KorzinaCard(
            hajmi: hajmi,
            price: price,
            image: image,
            title: title,
            id: id,
            number: number,
            carType: carType,
            rating: rating,
            valyuta: valyuta));
    await getCard();
  }
}
