import 'package:objectbox/objectbox.dart';

@Entity()
class Milk{
@Id()
  int id = 0;
  int morningMilk = 0;
  int eveningMilk = 0;
  String? date;
  int pricePerLiter = 0;
  Milk();

Milk.create(this.morningMilk, this.eveningMilk, this.date, this.pricePerLiter);
}