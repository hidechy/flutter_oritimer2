enum APIPath {
  getTrainCompany,
  getTrainStation,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.getTrainCompany:
        return 'getTrainCompany';
      case APIPath.getTrainStation:
        return 'getTrainStation';
    }
  }
}
