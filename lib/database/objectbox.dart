import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';

import '../models/milk.dart';
import '../objectbox.g.dart';

class ObjectBox{
  late final Store store;
  late final Box<Milk> milk;

  ObjectBox._create(this.store){
    milk = Box<Milk>(store);
  }

  static Future<ObjectBox> create()async{
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory:'${dir.path}/milk');
    return ObjectBox._create(store);
  }
  int addData(Milk milkRecord){
   int id =  milk.put(milkRecord);
   print(milkRecord.id);

   return id;
  }
  Milk getMilkByDate( String date){
    Query query =milk.query(Milk_.date.equals(date)).build();
    Milk storedMilk =query.findFirst()??Milk.create(0, 0, "",0);
    query.close();
    return storedMilk;
  }
  void deleteObject(Milk milkRecord){
    milk.remove(milkRecord.id);
  }

  Stream<List<Milk>> getAllRecord(){
    return milk.query().watch(triggerImmediately: true).map((record){
      return record.find();
    });
  }
  Future <List<Milk>>  getAllRecordAtOnce() async{
    List<Milk> data = milk.getAll();
    return data;
  }


}