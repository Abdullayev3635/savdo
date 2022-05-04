import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'kozina_state.dart';

class KozinaCubit extends Cubit<KozinaState> {
  KozinaCubit() : super(KozinaInitial());
}
