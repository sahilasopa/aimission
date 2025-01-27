import 'package:carbonix/theme/theme.dart';
import 'package:flutter/material.dart';

const double NUMBER_BUBBLE_WIDTH = 0.185;

class LeaderboardPosition extends StatelessWidget {
  final int position;
  final String name;
  final double savedEmissions;
  final bool active;

  const LeaderboardPosition({
    super.key,
    required this.position,
    required this.name,
    required this.savedEmissions,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * NUMBER_BUBBLE_WIDTH,
          height: screenWidth * NUMBER_BUBBLE_WIDTH,
          decoration: BoxDecoration(
            color: ThemeColors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(screenWidth * NUMBER_BUBBLE_WIDTH / 2),
            ),
          ),
          child: Center(
            child: Text(
              '${savedEmissions.toString()}kg',
              style: const TextStyle(
                  fontSize: 15.555,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                color: active ? ThemeColors.darkGreen : ThemeColors.text,
              ),
            ),
            active
                ? const Text(
                    'Congrats! You\'re on the leaderboard!',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        LeaderboardPosition(
          position: 1,
          name: 'Sahil Asopa (you)',
          savedEmissions: 72.1,
          active: true,
        ),
        SizedBox(height: 10.0),
        LeaderboardPosition(
          position: 2,
          name: 'Manomay Gadiyar',
          savedEmissions: 52.5,
        ),
        SizedBox(height: 10.0),
        LeaderboardPosition(
          position: 3,
          name: 'Krish Shah',
          savedEmissions: 49.9,
        ),
        SizedBox(height: 10.0),
        LeaderboardPosition(
          position: 4,
          name: 'Manayata Kothari',
          savedEmissions: 9.9,
        ),
      ],
    );
  }
}
