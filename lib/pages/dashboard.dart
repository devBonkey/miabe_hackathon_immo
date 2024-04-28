import 'package:dio/dio.dart';
import 'package:fast_immo/models/room.dart';
import 'package:fast_immo/themes/colors.dart';
import 'package:flutter/material.dart';

class DashoardPage extends StatefulWidget {
  const DashoardPage({super.key});

  @override
  State<DashoardPage> createState() => _DashoardPageState();
}

class _DashoardPageState extends State<DashoardPage> {
  List<Room> roomsList = [];
  bool isLoading = true;
  Future<void> getData() async {
    final response =
        await Dio().get("https://kofhotel.kofcorporation.com/old/api/rooms");

    for (var element in response.data) {
      roomsList.add(Room.fromJson(element));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FastImmo"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: roomsList
                  .map((room) => Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(room.image))),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          "${room.price} XOF",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                room.label,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(room.description),
                            )
                          ],
                        ),
                      ))
                  .toList()),
    );
  }
}
