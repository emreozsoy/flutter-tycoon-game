import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore örneği için


class PlayerRepository {
  final FirebaseFirestore _firestore;

  PlayerRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<Player> getPlayer(String username) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('players').doc(username).get();
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        return Player(
          username: data['username'],
          gold: data['gold'],
          diamonds: data['diamonds'],
          wood: data['wood'],
          stone: data['stone'],
          iron: data['iron'],
          sulfur: data['sulfur'],
          townCenterLevel: data['townCenterLevel'],
          blacksmithWorkshopLevel: data['blacksmithWorkshopLevel'],
          researchCenterLevel: data['researchCenterLevel'],
          miningBuildingLevel: data['miningBuildingLevel'],
          currentEra: data['currentEra'],
          goldEarningRate: data['goldEarningRate'],
        );
      } else {
        throw Exception('Player not found');
      }
    } catch (e) {
      throw Exception('Error getting player: $e');
    }
  }

  Future<void> updatePlayer(Player player) async {
    try {
      await _firestore.collection('players').doc(player.username).update({
        'gold': player.gold,
        'diamonds': player.diamonds,
        'wood': player.wood,
        'stone': player.stone,
        'iron': player.iron,
        'sulfur': player.sulfur,
        'townCenterLevel': player.townCenterLevel,
        'blacksmithWorkshopLevel': player.blacksmithWorkshopLevel,
        'researchCenterLevel': player.researchCenterLevel,
        'miningBuildingLevel': player.miningBuildingLevel,
        'currentEra': player.currentEra,
        'goldEarningRate': player.goldEarningRate,
      });
    } catch (e) {
      throw Exception('Error updating player: $e');
    }
  }
}
class Player {

  // Player details
  String username;
  int gold;
  int diamonds;

  // Resources
  int wood;
  int stone;
  int iron;
  int sulfur;

  // Buildings levels
  int townCenterLevel;
  int blacksmithWorkshopLevel;
  int researchCenterLevel;
  int miningBuildingLevel;

  String currentEra;
  double goldEarningRate;

  Player({
    required this.username,
    this.gold = 0,
    this.diamonds = 0,
    this.wood = 0,
    this.stone = 0,
    this.iron = 0,
    this.sulfur = 0,
    this.townCenterLevel = 1,
    this.blacksmithWorkshopLevel = 1,
    this.researchCenterLevel = 0,
    this.miningBuildingLevel = 1,
    this.currentEra = 'Stone Age',
    this.goldEarningRate = 1.0,
  });

  // Method to display player's resources
  String resourcesSummary() {
    return 'Gold: $gold, Diamonds: $diamonds, Wood: $wood, Stone: $stone, Iron: $iron, Sulfur: $sulfur';
  }

  // Method to display player's building levels
  String buildingsSummary() {
    return 'Town Center Level: $townCenterLevel, Blacksmith Workshop Level: $blacksmithWorkshopLevel, '
        'Research Center Level: $researchCenterLevel, Mining Building Level: $miningBuildingLevel';
  }

  // Method to display player's current era
  String currentEraSummary() {
    return 'Current Era: $currentEra';
  }

  // Method to display player's overall summary
  String playerSummary() {
    return 'Player: $username\n'
        '${resourcesSummary()}\n'
        '${buildingsSummary()}\n'
        '${currentEraSummary()}';
  }

  // Method to increase gold by a certain amount
  void earnGold(double amount) {
    gold += amount.toInt();
  }
}


