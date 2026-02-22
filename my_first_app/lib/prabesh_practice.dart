import 'package:flutter/material.dart';
import 'package:my_first_app/dice_roller.dart';

// Using variables to store the alignment values for the gradient
var startAlignment = Alignment.topLeft;
var endAlignment = Alignment.bottomRight;

class PrabeshPractice extends StatelessWidget {
  const PrabeshPractice(this.color1, this.color2, {super.key});

  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2], // using the colors variable
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: const Center(
        // Just place the DiceRoller here; it handles its own image and button
        child: DiceRoller(),
      ),
    );
  }
}

// class PrabeshPractice extends StatelessWidget {
//   const PrabeshPractice({super.key, required this.colors});

//   final List<Color> colors;

//   @override
//   Widget build(context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: colors, //using the colors variable to set the colors of the gradient
//           begin: startAlignment, //using the variables for the alignment values
//           end: endAlignment,
//         ),
//       ),
//       child: Center(
//         child: StyledText('Hello World'),
//       ),
//     );
//   }
// }
