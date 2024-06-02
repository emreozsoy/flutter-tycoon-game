import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tycoon_game/Screens/researchScreen.dart';
import '../Scripts/player.dart';

class EntryScreen extends StatefulWidget {
  final Player player;

  EntryScreen({required this.player});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  Timer? _timer;
  GlobalKey _goldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _startGoldEarningTimer();
  }

   void _startGoldEarningTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        widget.player.earnGold(widget.player.goldEarningRate);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(phoneHeight * 0.03),
          child: Container(
            color: Colors.grey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ResourceWidget(
                      resourceName: 'Diamond',
                      imagePath: "lib/Environment/diamond.png",
                      amount: widget.player.diamonds,
                    ),
                    ResourceWidget(
                      resourceName: 'Gold',
                      imagePath: "lib/Environment/gold.png",
                      amount: widget.player.gold,
                      key: _goldKey,
                    ),
                    ResourceWidget(
                      resourceName: 'Production Power',
                      imagePath: "lib/Environment/ProductionPower.png",
                      amount: 0,
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTapDown: (details) {
          setState(() {
            widget.player.earnGold(10);
          });
        },
        child: Stack(
          children: [
            Container(
              color: Color.fromRGBO(0, 223, 0, 100),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        BuildingWidget(
                          buildingName: 'Town Center',
                          imagePath: "lib/Environment/Cave.png",
                          level: widget.player.townCenterLevel,
                        ),
                        BuildingWidget(
                          buildingName: 'Blacksmith Workshop',
                          imagePath: "lib/Environment/ProductionPower.png",
                          level: widget.player.blacksmithWorkshopLevel,
                        ),
                        BuildingWidget(
                          buildingName: 'Research Center',
                          imagePath: "lib/Environment/ProductionPower.png",
                          level: widget.player.researchCenterLevel,
                        ),
                        BuildingWidget(
                          buildingName: 'Mining Building',
                          imagePath: "lib/Environment/ProductionPower.png",
                          level: widget.player.miningBuildingLevel,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResearchScreen(player: widget.player)),
                        );
                      },
                      child: Text('Go to Upgrade Page'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResourceWidget extends StatelessWidget {
  final String resourceName;
  final String imagePath;
  final int amount;

  const ResourceWidget({required this.resourceName, required this.imagePath, required this.amount, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 32, height: 32),
        Text(
          resourceName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          amount.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class BuildingWidget extends StatelessWidget {
  final String buildingName;
  final String imagePath;
  final int level;

  const BuildingWidget({required this.buildingName, required this.imagePath, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset(imagePath, width: 64, height: 64),
          Text(buildingName),
          Text('Level $level'),
        ],
      ),
    );
  }
}
