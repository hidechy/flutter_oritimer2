import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/train_company.dart';

part 'train_company_response_state.freezed.dart';

@freezed
class TrainCompanyResponseState with _$TrainCompanyResponseState {
  const factory TrainCompanyResponseState({
    //
    @Default([]) List<TrainCompany> trainCompanyList,

    //
    @Default({}) Map<String, List<Train>> companyTrainMap,
  }) = _TrainCompanyResponseState;
}
