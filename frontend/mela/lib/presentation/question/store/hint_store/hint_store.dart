
import 'package:dio/dio.dart';
import 'package:mela/domain/usecase/question/generate_hint_usecase.dart';
import 'package:mobx/mobx.dart';
part 'hint_store.g.dart';

class HintStore = _HintStore with _$HintStore;

abstract class _HintStore with Store {

  final GenerateHintUseCase _generateHintUseCase;
  //Observable:-----------------------------------------------------------------

  @observable
  String hint = "";
  @observable
  String term = "";


  @observable
  bool isLoading = false;
  _HintStore(this._generateHintUseCase);


  //Action:---------------------------------------------------------------------
  @action
  void setHint(String hint) {
    this.hint = hint;
  }
  @action
  void setTerm(String term) {
    this.term = term;
  }
  @action
  void generateHint(String questionId) async {
    // Call the use case to generate a hint
    isLoading = true;
    try {
      String generatedHint = await _generateHintUseCase.call(params: questionId);
      setHint(generatedHint);
    } catch (e) {
      if (e is DioException){
        if (e.response?.statusCode == 401){
          rethrow;
          // Handle token refresh logic here
        } else {
          // Handle other errors
          print("Error: ${e.message}");
        }
      }

    }
    isLoading = false;
  }


  //Computed:-------------------------------------------------------------------

}

