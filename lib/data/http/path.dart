enum APIPath {
  getTrainCompany,
  getTrainStation,
  getPrefecture,
  getPrefectureTrain,
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
      case APIPath.getPrefectureTrain:
        return 'getPrefectureTrain';
    }
  }
}
