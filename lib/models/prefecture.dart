class Prefecture {
  Prefecture({required this.areaNo, required this.area, required this.prefecture, required this.prefNo});

  factory Prefecture.fromJson(Map<String, dynamic> json) => Prefecture(
        areaNo: json['areaNo'],
        area: json['area'],
        prefecture: json['prefecture'],
        prefNo: json['prefNo'],
      );
  final int areaNo;
  final String area;
  final String prefecture;
  final int prefNo;

  Prefecture copyWith({int? areaNo, String? area, String? prefecture, int? prefNo}) => Prefecture(
      areaNo: areaNo ?? this.areaNo,
      area: area ?? this.area,
      prefecture: prefecture ?? this.prefecture,
      prefNo: prefNo ?? this.prefNo);

  Map<String, dynamic> toJson() => {'areaNo': areaNo, 'area': area, 'prefecture': prefecture, 'prefNo': prefNo};
}
