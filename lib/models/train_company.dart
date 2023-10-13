// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

/*
http://toyohide.work/BrainLog/api/getTrainCompany

{
    'data': [
        {
            'company_id': 1,
            'company_name': 'JR北海道',
            'flag': '0',
            'train': [
                {
                    'train_number': '11101',
                    'train_name': 'JR函館本線(函館～長万部)',
                    'pickup': '0'
                },

*/

class TrainCompany {
  TrainCompany({required this.companyId, required this.companyName, required this.flag, required this.train});

  factory TrainCompany.fromJson(Map<String, dynamic> json) => TrainCompany(
        companyId: json['company_id'],
        companyName: json['company_name'],
        flag: json['flag'],
        // ignore: unnecessary_lambdas
        train: List<Train>.from(json['train'].map((x) => Train.fromJson(x))),
      );
  int companyId;
  String companyName;
  String flag;
  List<Train> train;

  Map<String, dynamic> toJson() => {
        'company_id': companyId,
        'company_name': companyName,
        'flag': flag,
        'train': List<dynamic>.from(train.map((x) => x.toJson()))
      };
}

class Train {
  Train({required this.trainNumber, required this.trainName, required this.pickup});

  factory Train.fromJson(Map<String, dynamic> json) =>
      Train(trainNumber: json['train_number'], trainName: json['train_name'], pickup: json['pickup']);
  String trainNumber;
  String trainName;
  String pickup;

  Map<String, dynamic> toJson() => {'train_number': trainNumber, 'train_name': trainName, 'pickup': pickup};
}
