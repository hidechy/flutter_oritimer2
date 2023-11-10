class PrefectureTrain {
  PrefectureTrain({required this.trainNumber, required this.trainName, required this.pickup});

  factory PrefectureTrain.fromJson(Map<String, dynamic> json) =>
      PrefectureTrain(trainNumber: json['train_number'], trainName: json['train_name'], pickup: json['pickup']);
  final String trainNumber;
  final String trainName;
  final String pickup;

  PrefectureTrain copyWith({String? trainNumber, String? trainName, String? pickup}) => PrefectureTrain(
        trainNumber: trainNumber ?? this.trainNumber,
        trainName: trainName ?? this.trainName,
        pickup: pickup ?? this.pickup,
      );

  Map<String, dynamic> toJson() => {'train_number': trainNumber, 'train_name': trainName, 'pickup': pickup};
}
