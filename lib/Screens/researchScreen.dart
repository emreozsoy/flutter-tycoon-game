
import 'package:flutter/material.dart';
import 'package:tycoon_game/CustomWidgets/customSliderWidget.dart';
import '../Scripts/player.dart';
import 'entry.dart';
class ResearchScreen extends StatelessWidget {
  final Player player;

  ResearchScreen({required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ResourceWidget(resourceName: 'Gold', amount: player.gold, imagePath: 'lib/Environment/gold.png'),
                ResourceWidget(resourceName: 'Diamond', amount: player.diamonds,imagePath:'lib/Environment/diamond.png'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Item(
                  name: 'Item Name',
                  level: 1,
                  count: 0,
                  image: 'lib/Environment/diamond.png',
                  onBuyPressed: () {
                    // add buy func
                  },
                  onUpgradePressed: () {
                    // add upgrade func
                    /* level, image will be changed*/
                  },
                ),
                SizedBox(height: 16.0),
                Item(
                  name: 'Item Name',
                  level: 2,
                  count: 0,
                  image: 'lib/Environment/diamond.png',
                  onBuyPressed: () {
                    // Implement buy functionality
                  },
                  onUpgradePressed: () {
                    // Implement upgrade functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Item extends StatefulWidget {
  final String name;
  final int level;
  final String image;
  final int count;
  final VoidCallback? onBuyPressed;
  final VoidCallback? onUpgradePressed;

  const Item({
    required this.name,
    required this.level,
    required this.image,
    required this.count,
    this.onBuyPressed,
    this.onUpgradePressed,
  });

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  late String _image;
  late int _level;
  late int _count=0;

  TextEditingController _quantityController = TextEditingController();
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
    _level = widget.level;
    _count = widget.count;

  }
  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
  void _upgrade() {
    setState(() {
      _image = 'lib/Environment/Cave.png';
      _level += 1;
    });
  }

  void _buy() {
    setState(() {
      _count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Level ${widget.level}'),
          Text('Count: $_count'),
          SizedBox(height: 8.0),
          Row(
            children: [
              Image.asset(
                widget.image,
                width: 64,
                height: 64,
              ),
              SizedBox(width: 8.0),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: widget.onBuyPressed,
                    child: Text('Buy'),
                  ),
                  ElevatedButton(
                    onPressed: widget.onUpgradePressed,
                    child: Text('Sell'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.0),
          QuantityInputSlider(
            minValue: 0,
            maxValue: 100,  // Adjust max value as needed
            initialValue: _quantity,
            onChanged: (value) {
              setState(() {
                _quantity = value;
              });
            },
          ),
        ],
      ),
    );
  }
}


