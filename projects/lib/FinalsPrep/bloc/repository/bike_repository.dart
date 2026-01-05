import 'package:projects/FinalsPrep/bloc/model/bike.dart';

class BikeRepository{
  Future<List<Bike>> getBikes() async{
    return[
      Bike(id: 1, make: "Suzuki", variant: "CD 70"),
      Bike(id: 2, make: "Honda", variant: "CC 120"),
      Bike(id: 3, make: "Yamaha", variant: "YBR"),
    ];
  }
}