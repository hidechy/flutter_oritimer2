enum APIPath {
  getTrainCompany,
  getTrainStation,
  getPrefecture,
  getPrefectureTrainCompany,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.getTrainCompany:
        return 'getTrainCompany';
      case APIPath.getTrainStation:
        return 'getTrainStation';
      case APIPath.getPrefecture:
        return 'getPrefecture';
      case APIPath.getPrefectureTrainCompany:
        return 'getPrefectureTrainCompany';
    }
  }
}
