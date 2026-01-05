import 'package:flutter/material.dart';
import 'package:projects/FinalsPrep/SQFLite/model/Car.dart';
import 'package:projects/FinalsPrep/SQFLite/dbHelper/dbhelper.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  bool isEditing = false;
  bool isLoading = true;

  final TextEditingController idC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController makeC = TextEditingController();
  final TextEditingController modelC = TextEditingController();

  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
    getCars();
  }

  Future<void> getCars() async {
    setState(() => isLoading = true);

    final result = await DbHelper.instance.getAll();
    cars = result;

    setState(() => isLoading = false);
  }

  void clearFields() {
    idC.clear();
    nameC.clear();
    makeC.clear();
    modelC.clear();

    setState(() {
      isEditing = false;
    });
  }

  void addHandler() async {
    Car car = Car(
      id: 0,
      name: nameC.text,
      make: makeC.text,
      model: modelC.text,
    );

    int res = await DbHelper.instance.insertCar(car);

    if (res > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Car Saved Successfully")),
      );
      clearFields();
      getCars();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error Failed")),
      );
    }
  }

  void updateHandler(int id) async {
    Car car = Car(
      id: id,
      name: nameC.text,
      make: makeC.text,
      model: modelC.text,
    );

    int res = await DbHelper.instance.updateCar(id, car);

    if (res > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Car Updated Successfully")),
      );
      clearFields();
      getCars();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error Failed")),
      );
    }
  }

  void deleteHandler(int id) async {
    await DbHelper.instance.deleteCar(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Car Deleted Successfully")),
    );

    clearFields();
    getCars();
  }

  void getCar(Car car) {
    idC.text = car.id.toString();
    nameC.text = car.name;
    makeC.text = car.make;
    modelC.text = car.model;

    setState(() {
      isEditing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextFormField(
            controller: nameC,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Car Name",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: makeC,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Make",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: modelC,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Model",
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: clearFields,
                child: const Text("Clear"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: isEditing
                    ? () => updateHandler(int.parse(idC.text))
                    : addHandler,
                child: Text(isEditing ? "Update" : "Add"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          cars.isNotEmpty
              ? Expanded(
            child: ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return ListTile(
                  title: Text("${car.id}: ${car.name}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Make: ${car.make}"),
                      Text("Model: ${car.model}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => getCar(car),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteHandler(car.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
              : const Center(child: Text("No Cars Exist...")),
        ],
      ),
    );
  }
}
