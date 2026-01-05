import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/FinalsPrep/bloc/bloc/bike_bloc.dart';
import 'package:projects/FinalsPrep/bloc/bloc/bloc_event.dart';
import 'package:projects/FinalsPrep/bloc/bloc/bloc_state.dart';

class BikeScreen extends StatelessWidget {
  const BikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<BikeBloc>().add(FetchBikesEvent());
              },
              child: const Text("Load Bikes"),
            ),
            Expanded(
              child: BlocBuilder<BikeBloc, BikeState>(
                builder: (context, state) {
                  if (state is BikeLoading) {
                    return const Center(child: Text("Loading..."));
                  }

                  if (state is BikeLoaded) {
                    return ListView.builder(
                      itemCount: state.bikes.length,
                      itemBuilder: (context, index) {
                        final bike = state.bikes[index];
                        return ListTile(
                          title: Text(bike.make),
                          subtitle: Text(bike.variant),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: Text("Press 'Load Bikes' to fetch data"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
