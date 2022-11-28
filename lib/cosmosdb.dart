import 'package:azure_cosmosdb/azure_cosmosdb.dart' as cosmosdb;

class Temp extends cosmosdb.BaseDocumentWithEtag {
  Temp(
      this.id,
      this.label, {
        this.date,
        this.value=0,
      });

  @override
  final String id;

  String label;
  int value;
  DateTime? date;

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'value': value,
    'date': date?.toUtc().toIso8601String(),
  };

  static Temp fromJson(Map json) {
    var date = json['date'];
    if (date != null) {
      date = DateTime.parse(date).toLocal();
    }
    final temp = Temp(
      json['id'],
      json['label'],
      value: json['value'],
      date: date,
    );
    temp.setEtag(json);
    return temp;
  }
}

void main() async {
  // connect to the collection
  final cosmosDB = cosmosdb.Instance('https://hpcs.mongo.cosmos.azure.com:10255', masterKey: '*master key*');
  final database = await cosmosDB.databases.openOrCreate('sample');
  final tempCollection = await database.collections.openOrCreate('temp', partitionKeys: ['/id']);

  // register the builder for Temp items
  tempCollection.registerBuilder<Temp>(Temp.fromJson);

  // create a new item
  final task = Temp(
    DateTime.now().millisecondsSinceEpoch.toString(),
    'Improve tests',
    date: DateTime.now().add(Duration(days: 3)),
  );

  // save it to the collection
  await tempCollection.add(task);

  print('Added new task ${task.id} - ${task.label}');

  // query the collection
  final tasks = await tempCollection.query<Temp>(cosmosdb.Query(
      'SELECT * FROM c WHERE c.label = @improvetests',
      params: {'@improvetests': task.label}));

  print('Other tasks:');
  for (var t in tasks.where((_) => _.id != task.id)) {
    String status = 'still pending';
    final dueDate = t.date;
    print('* ${t.id} - ${t.label} - $status');
  }
}