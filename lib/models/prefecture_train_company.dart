class TrainCompany {
  TrainCompany({required this.companyId, required this.companyName, required this.flag});

  factory TrainCompany.fromJson(Map<String, dynamic> json) =>
      TrainCompany(companyId: json['company_id'], companyName: json['company_name'], flag: json['flag']);

  final int companyId;
  final String companyName;
  final String flag;

  TrainCompany copyWith({int? companyId, String? companyName, String? flag}) => TrainCompany(
        companyId: companyId ?? this.companyId,
        companyName: companyName ?? this.companyName,
        flag: flag ?? this.flag,
      );

  Map<String, dynamic> toJson() => {'company_id': companyId, 'company_name': companyName, 'flag': flag};
}
