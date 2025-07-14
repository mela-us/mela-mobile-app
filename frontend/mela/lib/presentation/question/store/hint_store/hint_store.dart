
import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/question/question.dart';
import 'package:mela/domain/usecase/question/generate_hint_usecase.dart';
import 'package:mela/domain/usecase/question/generate_term_usecase.dart';
import 'package:mobx/mobx.dart';
part 'hint_store.g.dart';

class HintStore = _HintStore with _$HintStore;

abstract class _HintStore with Store {

  final GenerateHintUseCase _generateHintUseCase;
  final GenerateTermUseCase _generateTermUseCase;
  //Observable:-----------------------------------------------------------------

  @observable
  String? hint;
  @observable
  String? term;

  @observable
  bool pressHint = false;

  @observable
  bool pressTerm = false;

  @observable
  Question? question;

  @observable
  bool isHintLoading = false;

  @observable
  bool isTermLoading = false;

  _HintStore(this._generateHintUseCase, this._generateTermUseCase);


  //Action:---------------------------------------------------------------------
  @action
  void setHint(String? hint) {
    this.hint = hint;
  }
  @action
  void setTerm(String? term) {
    this.term = term;
  }

  @action
  void toggleHint() {
    pressHint = !pressHint;
  }

  @action
  void toggleTerm() {
    pressTerm = !pressTerm;
  }

  @action
  void reset(){
    hint = null;
    term = null;
    pressHint = false;
    pressTerm = false;
  }

  @action
  Future<void> generateHint(String questionId) async {
    // Call the use case to generate a hint
    isHintLoading = true;
    try {
      String generatedHint = await _generateHintUseCase.call(params: questionId);
      setHint(generatedHint);
    } catch (e) {
      if (e is DioException){
        if (e.response?.statusCode == 401){
          throw ResponseStatus.UNAUTHORIZED;
          // Handle token refresh logic here
        } else {
          // Handle other errors
          throw ResponseStatus.UNKNOWN;
        }
      } else {
        throw ResponseStatus.ERROR;
      }
    } finally {
      isHintLoading = false;
    }

  }

  @action
  Future<void> generateTerm(String questionId) async {
    // Call the use case to generate a hint
    isTermLoading = true;
    try {
      String generatedTerm = await _generateTermUseCase.call(params: questionId);
      setTerm(generatedTerm);
    } catch (e) {
      if (e is DioException){
        if (e.response?.statusCode == 401){
          throw ResponseStatus.UNAUTHORIZED;
          // Handle token refresh logic here
        } else {
          // Handle other errors
          throw ResponseStatus.UNKNOWN;
        }
      } else {
        throw ResponseStatus.ERROR;
      }
    } finally {
      isTermLoading = false;
    }

  }
  //Computed:-------------------------------------------------------------------

}

