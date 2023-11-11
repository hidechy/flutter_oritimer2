class AreaPrefecture {
  AreaPrefecture({required this.areaNo, required this.area, required this.prefecture, required this.prefNo});

  factory AreaPrefecture.fromJson(Map<String, dynamic> json) => AreaPrefecture(
        areaNo: json['areaNo'],
        area: json['area'],
        prefecture: json['prefecture'],
        prefNo: json['prefNo'],
      );

  final int areaNo;
  final String area;
  final String prefecture;
  final int prefNo;

  AreaPrefecture copyWith({int? areaNo, String? area, String? prefecture, int? prefNo}) => AreaPrefecture(
        areaNo: areaNo ?? this.areaNo,
        area: area ?? this.area,
        prefecture: prefecture ?? this.prefecture,
        prefNo: prefNo ?? this.prefNo,
      );

  Map<String, dynamic> toJson() => {'areaNo': areaNo, 'area': area, 'prefecture': prefecture, 'prefNo': prefNo};
}
