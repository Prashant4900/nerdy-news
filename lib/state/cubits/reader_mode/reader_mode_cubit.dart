import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/utils/app_pref.dart';

part 'reader_mode_state.dart';

class ReaderModeCubit extends Cubit<ReaderModeState> {
  ReaderModeCubit() : super(const ReaderModeInitial(status: false));

  Future<void> changeMode({required bool flag}) async {
    await CacheHelper.saveReaderMode(
      key: PreferenceKey.readerMode,
      readerMode: flag,
    );
    emit(ReaderModeChanged(status: flag));
  }

  Future<void> getReaderMode() async {
    final flag = await CacheHelper.getReaderMode();
    emit(ReaderModeChanged(status: flag));
  }
}
