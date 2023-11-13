/*
http://toyohide.work/BrainLog/api/getTrainStation
{"train_number":"11101"}

{
    "data": [
        {
            "id": 2,
            "station_name": "函館",
            "address": "北海道函館市若松町１２-１３",
            "lat": "41.773709",
            "lng": "140.726413",
            "line_number": "11101",
            "line_name": "JR函館本線(函館～長万部)"
        },

*/

///
class TrainStation {
  TrainStation({
    required this.id,
    required this.stationName,
    required this.address,
    required this.lat,
    required this.lng,
    required this.lineNumber,
    required this.lineName,
    required this.prefecture,
  });

  factory TrainStation.fromJson(Map<String, dynamic> json) => TrainStation(
        id: json['id'],
        stationName: json['station_name'],
        address: json['address'],
        lat: json['lat'],
        lng: json['lng'],
        lineNumber: json['line_number'],
        lineName: json['line_name'],
        prefecture: json['prefecture'],
      );
  int id;
  String stationName;
  String address;
  String lat;
  String lng;
  String lineNumber;
  String lineName;
  String prefecture;

  Map<String, dynamic> toJson() => {
        'id': id,
        'station_name': stationName,
        'address': address,
        'lat': lat,
        'lng': lng,
        'line_number': lineNumber,
        'line_name': lineName,
        'prefecture': prefecture,
      };
}
