import 'dart:math';
import 'package:flutter/material.dart';
import 'workout_page.dart';

class WorkoutPlanPage extends StatelessWidget {
  WorkoutPlanPage({super.key}) {
    _tabs = [
      WorkoutPage(
        icon: Icons.fitness_center,
        color: Colors.blue,
        workoutType: 'Push Day',
        exercises: const [
          'Chest Flyes',
          'Reverse Flyes',
          'Chest Press',
          'Decline Chest Press',
          'Front Raises',
          'Incline Dumbell Press',
          'Incline Chest \nPress (Machine)',
          'Lateral Raises',
          'Shoulder Press',
          'Face Pulls',
          'Reverse Tricep\n Extension',
          'Rope Extension',
          'Tricep Dips',
          'Single Rope\n Pushdown',
        ],
        imagePaths: const [
          'assets/chest/Cable Crossover.jpg',
          'assets/chest/Chest Flyes.jpg',
          'assets/chest/Chest Press.jpg',
          'assets/chest/Decline Chest Press.jpg',
          'assets/chest/Front Raises.jpg',
          'assets/chest/Incline Bench Press.jpg',
          'assets/chest/Incline Chest Press (Machine).jpg',
          'assets/chest/Lateral Raises.jpg',
          'assets/chest/Shoulder Press.jpg',
          'assets/chest/facepull.jpg',
          'assets/chest/reverse tricep extension.jpg',
          'assets/chest/rope extension.jpg',
          'assets/chest/tricepdips.jpg',
          'assets/chest/sigle rope pushdown.jpg',
        ],
        setsAndReps: List.generate(14, (index) => generateSetsAndReps()),
        descriptions: const [
          'Chest Flyes are an excellent exercise for targeting the chest muscles.',
          'Reverse Flyes work the posterior deltoids and upper back muscles.',
          'Chest Press is a fundamental exercise for building chest strength.',
          'Decline Chest Press targets the lower part of the chest muscles.',
          'Front Raises strengthen the front deltoid muscles.',
          'Incline Dumbell Press targets the upper chest and shoulders.',
          'Incline Chest Press (Machine) is great for upper chest development.',
          'Lateral Raises enhance shoulder width and strength.',
          'Shoulder Press is a key exercise for overall shoulder development.',
          'Face Pulls are effective for the rear deltoids and upper back.',
          'Reverse Tricep Extension targets the triceps, focusing on the long head.',
          'Rope Extension isolates the triceps and helps improve definition.',
          'Tricep Dips work the triceps, chest, and shoulders.',
          'Single Rope Pushdown focuses on the triceps, enhancing muscle separation.',
        ],
        gifPaths: const [ // Add GIF paths here
          'assets/gif/chest flys.gif',
          'assets/gif/reverse flys.gif',
          'assets/gif/chest press.gif',
          'assets/gif/decline chest press.gif',
          'assets/gif/front raise.gif',
          'assets/gif/incline dumbell.gif',
          'assets/gif/incline machine.gif',
          'assets/gif/lateral.gif',
          'assets/gif/shoulder press.gif',
          'assets/gif/face.gif',
          'assets/gif/reverse.gif',
          'assets/gif/rope.gif',
          'assets/gif/dips.gif',
          'assets/gif/single.gif',
        ],
      ),
      WorkoutPage(
        icon: Icons.fitness_center,
        color: Colors.blue,
        workoutType: 'Pull Day',
        exercises: const [
          'Pull-ups',
          'Close Grip Pulldown',
          'Lat Pulldown',
          'T-Bar Row',
          'Single Lat Pulldown',
          'Seated Lat Row',
          'Seated Back Row',
          'Seated Cable Row',
          'Single Bicep Curl',
          'Seated Bicep Curl',
          'Hammer Curl',
          'Wrist Curl',
          'Reverse Wrist Curl',
          'Shrugs',
        ],
        imagePaths: const [
          'assets/pull/pull ups.jpg',
          'assets/pull/close grip pulldown.jpg',
          'assets/pull/lat pulldown.jpg',
          'assets/pull/t-bar row.jpg',
          'assets/pull/single lat pulldown.jpg',
          'assets/pull/seated lat row.jpg',
          'assets/pull/seated back row.jpg',
          'assets/pull/seated cable row.jpg',
          'assets/pull/single bicep curl.jpg',
          'assets/pull/seated bicep curl.jpg',
          'assets/pull/hammer curl.jpg',
          'assets/pull/wrist curl.jpg',
          'assets/pull/reverse wrist curl.jpg',
          'assets/pull/shurgs.jpg',
        ],
        setsAndReps: List.generate(14, (index) => generateSetsAndReps()),
        descriptions: const [
          'Pull-ups are great for building back and bicep strength.',
          'Close Grip Pulldown targets the lower lats and biceps.',
          'Lat Pulldown helps in building a wider back by targeting the upper lats.',
          'T-Bar Row engages the middle back and helps in developing thickness.',
          'Single Lat Pulldown focuses on the lats and helps in improving symmetry.',
          'Seated Lat Row targets the middle back, improving overall back strength.',
          'Seated Back Row helps in building the lower and middle back muscles.',
          'Seated Cable Row is effective for targeting the entire back and biceps.',
          'Single Bicep Curl isolates each bicep for balanced development.',
          'Seated Bicep Curl targets the biceps while minimizing the involvement of other muscles.',
          'Hammer Curl works the biceps and the brachialis muscle for thicker arms.',
          'Wrist Curl strengthens the forearms and improves grip strength.',
          'Reverse Wrist Curl targets the forearms, focusing on the extensor muscles.',
          'Shrugs are great for building and strengthening the trapezius muscles.',
        ],
        gifPaths: const [ // Add GIF paths here
          'assets/gif/pullups.gif',
          'assets/gif/close.gif',
          'assets/gif/latdown.gif',
          'assets/gif/tbar.gif',
          'assets/gif/singlelat.gif',
          'assets/gif/latlat.gif',
          'assets/gif/latlat.gif',
          'assets/gif/cablecable.gif',
          'assets/gif/single biceps.gif',
          'assets/gif/seatedbicep.gif',
          'assets/gif/hammer.gif',
          'assets/gif/wrist curl.gif',
          'assets/gif/reverse ezbar.gif',
          'assets/gif/shrugs.gif',
        ],
      ),
      WorkoutPage(
        icon: Icons.directions_walk,
        color: Colors.blue,
        workoutType: 'Leg/Abs Day',
        exercises: const [
          'Squats',
          'Leg Press',
          'Hamstring Curls',
          'Cable Crunch',
          'Hanging Leg Raises',
          'Planks',
          'Lunges',
        ],
        imagePaths: const [
          'assets/squats.jpg',
          'assets/legpress.jpg',
          'assets/hamstringcurl.jpg',
          'assets/cablecrunch.jpg',
          'assets/legraises.jpg',
          'assets/planks.jpg',
          'assets/lunges.jpg',
        ],
        setsAndReps: List.generate(7, (index) => generateSetsAndReps()),
        descriptions: const [
          'Squats are a foundational exercise for leg strength and power.',
          'Leg Press targets the quads, hamstrings, and glutes.',
          'Hamstring Curls isolate and strengthen the hamstring muscles.',
          'Cable Crunch is effective for building strong abdominal muscles.',
          'Hanging Leg Raises target the lower abs and hip flexors.',
          'Planks are excellent for core stability and endurance.',
          'Lunges work the legs and glutes while improving balance.',
        ],
        gifPaths: const [ // Add GIF paths here
          'assets/gif/squat.gif',
          'assets/gif/legpress.gif',
          'assets/gif/hamstring.gif',
          'assets/gif/crunch.gif',
          'assets/gif/hangin.gif',
          'assets/gif/planks.gif',
          'assets/gif/lunges.gif',
        ],
      ),
    ];
  }

  // Function to generate randomized sets and reps format
  String generateSetsAndReps() {
    Random random = Random();
    int firstSetReps = random.nextInt(3) + 8; // Random number between 8 and 12
    int secondSetReps = 12; // Random number between 8 and 12
    return '1st set of $firstSetReps-$secondSetReps reps\n2nd set of $firstSetReps-$secondSetReps reps\n3rd set until failure';
  }

  late List<Widget> _tabs;

 @override
Widget build(BuildContext context) {
  return DefaultTabController(
    length: _tabs.length,
    child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).orientation == Orientation.portrait ? 85.0 : 85.0),
        child: AppBar(
          title: const Text(
            'Workout Plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'BonaNovaSC',
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(255, 161, 161, 161), // Color for the selected tab indicator
            labelColor: Color.fromARGB(255, 255, 255, 255), // Color for the selected tab text
            unselectedLabelColor: Color.fromARGB(255, 255, 255, 255), // Color for unselected tab text
            tabs: [
              Tab(text: 'Push Day'),
              Tab(text: 'Pull Day'),
              Tab(text: 'Leg/Abs Day'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        children: _tabs,
      ),
    ),
  );
}
}