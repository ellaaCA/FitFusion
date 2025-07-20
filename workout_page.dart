import 'dart:math';

import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String workoutType;
  final List<String> exercises;
  final List<String> imagePaths;
  final List<String> setsAndReps;
  final List<String> descriptions;
  final List<String> gifPaths; // Add this field

  const WorkoutPage({super.key, 
    required this.icon,
    required this.color,
    required this.workoutType,
    required this.exercises,
    required this.imagePaths,
    required this.setsAndReps,
    required this.descriptions,
    required this.gifPaths, // Initialize in constructor and use in _flipCard method
  });

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedCardIndex = -1;
  late List<bool> _isFlipped;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
    _isFlipped = List<bool>.filled(widget.exercises.length, false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flipCard(int index) {
    setState(() {
      if (_selectedCardIndex == index) {
        // Clicked on the same card that is already flipped, flip it back
        _isFlipped[index] = false;
        _selectedCardIndex = -1;
      } else if (_selectedCardIndex != -1) {
        // Clicked on a different card, flip the previously flipped card back
        _isFlipped[_selectedCardIndex] = false;
        _isFlipped[index] = true;
        _selectedCardIndex = index;
      } else {
        // No card flipped, flip the clicked card
        _isFlipped[index] = true;
        _selectedCardIndex = index;
      }
    });

    if (_isFlipped[index]) {
      // Show the GIF in AlertDialog
   showDialog(
  context: context,
  builder: (context) => AlertDialog(
    backgroundColor: Colors.transparent, // Make the background transparent
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // Rounded corners for the dialog
    ),
    content: ClipRRect(
      borderRadius: BorderRadius.circular(20), // Add rounded corners to content
      child: SizedBox(
        width: 500,
        height: 300,
        child: Image.asset(
          widget.gifPaths[index], // Use GIF path here
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
);



    }
  }

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust cross axis count based on orientation and screen size
    int crossAxisCount = (screenWidth > 600) ? 4 : 2;

    final cardWidth = screenWidth / crossAxisCount - 15;
    final cardHeight = cardWidth * 1.3;

    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: cardWidth / cardHeight,
        ),
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _flipCard(index),
            onLongPress: () {
              _flipCard(index); // Trigger flip action on long press
            },
            child: SlideTransition(
              position: _slideAnimation,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                  return AnimatedBuilder(
                    animation: rotate,
                    child: child,
                    builder: (context, child) {
                      final isUnder = (ValueKey(_isFlipped[index]) != child?.key);
                      var tilt = (animation.value - 0.5).abs() - 0.5;
                      tilt *= isUnder ? -0.003 : 0.003;
                      return Transform(
                        transform: Matrix4.rotationY(rotate.value)..setEntry(3, 0, tilt),
                        alignment: Alignment.center,
                        child: Material(
                          elevation: _isFlipped[index] ? 10 : 3,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: _isFlipped[index]
                                  ? const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Color.fromARGB(255, 0, 3, 35), Color.fromARGB(255, 2, 36, 190)],
                                    )
                                  : null,
                            ),
                            child: child,
                          ),
                        ),
                      );
                    },
                  );
                },
                layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                  return Stack(
                    children: <Widget>[
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
                child: _isFlipped[index]
                    ? _buildBackCard(context, index, cardWidth, cardHeight)
                    : _buildFrontCard(context, index, cardWidth, cardHeight),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard(BuildContext context, int index, double cardWidth, double cardHeight) {
    return Card(
      key: const ValueKey(false),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              widget.imagePaths[index],
              width: cardWidth,
              height: cardHeight * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  widget.exercises[index],
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.setsAndReps[index],
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(BuildContext context, int index, double cardWidth, double cardHeight) {
    return Card(
      key: const ValueKey(true),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.exercises[index],
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.descriptions[index],
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
