import 'package:flutter/material.dart';

class CardioPage extends StatefulWidget {
  const CardioPage({super.key});

  @override
  _CardioPageState createState() => _CardioPageState();
}

class _CardioPageState extends State<CardioPage> with SingleTickerProviderStateMixin {
  String selectedExercise = 'Walk';
  final List<String> exercises = ['Walk', 'Treadmill', 'Jogging', 'Running', 'Cycling'];
  final Map<String, int> caloriesBurned = {
    'Walk': 100,
    'Treadmill': 300,
    'Jogging': 200,
    'Running': 400,
    'Cycling': 250,
  };
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: caloriesBurned[selectedExercise]!.toDouble()).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateCaloriesBurned() {
    _controller.reset();
    _animation = Tween<double>(begin: 0, end: caloriesBurned[selectedExercise]!.toDouble()).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Summary'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step counter
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color.fromARGB(91, 0, 134, 85), Color.fromARGB(147, 1, 134, 116)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '4270',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'steps',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Activity section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildActivityCard('Water', '24 cup', Icons.local_drink, Colors.blue),
                buildActivityCard('Heart Rate', '74 bpm', Icons.favorite, Colors.red),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildActivityCard('Calories', '200 kcal', Icons.local_fire_department, Colors.orange),
                buildActivityCard('Exercise', '1 h 30 m', Icons.fitness_center, Colors.lightBlue),
              ],
            ),
            const SizedBox(height: 24),
            // Cardio exercise selection
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Exercise',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: selectedExercise,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedExercise = newValue!;
                          updateCaloriesBurned();
                        });
                      },
                      items: exercises.map<DropdownMenuItem<String>>((String exercise) {
                        return DropdownMenuItem<String>(
                          value: exercise,
                          child: Text(exercise),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Text(
                          'Calories Burned: ${_animation.value.toStringAsFixed(0)} kcal',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Additional Fitness Elements
            const Text(
              'Fitness Tips',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            buildTipCard(
              'Stay Hydrated',
              'Drinking water helps maintain the balance of body fluids and is essential for optimal performance.',
              Icons.opacity,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            buildTipCard(
              'Warm Up',
              'Always start your workout with a proper warm-up to prevent injuries and improve performance.',
              Icons.run_circle,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActivityCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 20, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTipCard(String title, String description, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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


class SplitWorkoutPage extends StatefulWidget {
  const SplitWorkoutPage({super.key});

  @override
  _SplitWorkoutPageState createState() => _SplitWorkoutPageState();
}

class _SplitWorkoutPageState extends State<SplitWorkoutPage> {
  String _status = 'Active'; // Default status
  final List<Map<String, dynamic>> _popularUsers = [
    {'name': 'Kenedy_09', 'image': 'assets/user1.jpg', 'bio': 'Lives in New York, loves running and exploring new places.', 'goal': 'Complete a marathon'},
    {'name': 'Marites', 'image': 'assets/user2.jpg', 'bio': 'A yoga instructor from California, enjoys the beach.', 'goal': 'Promote mindfulness'},
    {'name': 'My Aiah', 'image': 'assets/user3.jpg', 'bio': 'Weight lifter from Texas, loves barbecues.', 'goal': 'Break personal records'},
    {'name': 'Tricias', 'image': 'assets/user4.jpg', 'bio': 'Cyclist from Oregon, enjoys mountain biking.', 'goal': 'Cycle across the country'},
    {'name': 'Gelo', 'image': 'assets/user5.jpg', 'bio': 'Fitness coach from Florida, enjoys helping others.', 'goal': 'Help clients reach their goals'},
    {'name': 'With BEstie', 'image': 'assets/user6.jpg', 'bio': 'Gym enthusiast from Nevada, loves hiking.', 'goal': 'Maintain a healthy lifestyle'},
    {'name': 'LoverBird', 'image': 'assets/user7.jpg', 'bio': 'Fitness blogger from Washington, loves writing.', 'goal': 'Inspire others'},
    {'name': 'Cutiepie', 'image': 'assets/user8.jpg', 'bio': 'Dancer from Chicago, enjoys performing.', 'goal': 'Stay fit through dance'},
    {'name': 'Righour', 'image': 'assets/user9.jpg', 'bio': 'Martial artist from Colorado, loves training.', 'goal': 'Master new techniques'},
    {'name': 'John Weeds', 'image': 'assets/user10.jpg', 'bio': 'Swimmer from Hawaii, loves the ocean.', 'goal': 'Swim the English Channel'},
  ];

  late List<Map<String, dynamic>> _filteredUsers;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _posts = [
    {
      'title': 'Completed a 5K run!',
      'image': 'assets/user1.jpg',
      'comments': [
        {'text': 'Great job!', 'user': 'assets/user2.jpg'},
        {'text': 'Incredible!', 'user': 'assets/user3.jpg'},
      ],
      'likes': 4,
      'date': 'Jul 18',
      'progress': 0.8,
      'users': ['assets/user4.jpg', 'assets/user5.jpg', 'assets/user6.jpg', 'assets/user7.jpg']
    },
    {
      'title': 'Achieved new personal record in bench press!',
      'image': 'assets/user2.jpg',
      'comments': [],
      'likes': 2,
      'date': 'Jul 20',
      'progress': 0.5,
      'users': ['assets/user9.jpg', 'assets/user8.jpg']
    },
    {
      'title': 'Weekly yoga session completed',
      'image': 'assets/user9.jpg',
      'comments': [
        {'text': 'Nice session!', 'user': 'assets/user4.jpg'},
      ],
      'likes': 3,
      'date': 'Jul 22',
      'progress': 0.7,
      'users': ['assets/user10.jpg', 'assets/user5.jpg', 'assets/user6.jpg']
    },
  ];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredUsers = _popularUsers;
    _searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    setState(() {
      _filteredUsers = _popularUsers
          .where((user) => user['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _showUserDetails(Map<String, dynamic> user) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation(),
          child: ScaleTransition(
            scale: _scaleAnimation(),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFB2DFDB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(user['image']),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bio: ${user['bio']}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text('Fitness Goal: ${user['goal']}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text('Close', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}


  Animation<double> _fadeAnimation() {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeIn,
      ),
    );
  }

  Animation<double> _scaleAnimation() {
    return Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engagement Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search people...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildPopularUsers(),
          const SizedBox(height: 20),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 16, 97, 88),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              'Current Status: $_status',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    margin: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Set Status',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          _buildStatusOption(
                            'Active',
                            Icons.directions_run,
                            'Being healthy and active.',
                          ),
                          _buildStatusOption(
                            'On a break',
                            Icons.self_improvement,
                            'Taking a few days off to recover.',
                          ),
                          _buildStatusOption(
                            'Sick',
                            Icons.local_hospital,
                            'Needing rest to get well.',
                          ),
                          _buildStatusOption(
                            'Injured',
                            Icons.accessibility,
                            'Needing time to heal.',
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text('Done'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      return _buildPostCard(index, _posts[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularUsers() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.offset - 100,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showUserDetails(_filteredUsers[index]),
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB2DFDB),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage(_filteredUsers[index]['image']),
                          ),
                          const SizedBox(height: 8),
                          Text(_filteredUsers[index]['name']),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.offset + 100,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    ],
  );
}


  Widget _buildPostCard(int index, Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(post['image']),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    post['title'],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: post['progress'],
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: post['users'].map<Widget>((user) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage(user),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    const Icon(Icons.comment, size: 16),
                    const SizedBox(width: 4),
                    Text(post['comments'].length.toString()),
                    const SizedBox(width: 16),
                    const Icon(Icons.thumb_up, size: 16),
                    const SizedBox(width: 4),
                    Text(post['likes'].toString()),
                    const SizedBox(width: 16),
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 4),
                    Text(post['date']),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    onPressed: () => _showCommentDialog(index),
                    child: const Row(
                      children: [
                        Icon(Icons.comment),
                        SizedBox(width: 4),
                        Text('Comment'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _posts[index]['likes']++;
                      });
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.thumb_up),
                        SizedBox(width: 4),
                        Text('Like'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: post['comments'].map<Widget>((comment) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage(comment['user']),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(comment['text']),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

 void _showCommentDialog(int postIndex) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFE0F2F1), // Light teal color for the dialog background
        title: const Text(
          'Add a Comment',
          style: TextStyle(
            color: Color(0xFF004D40), // Dark teal color for the title
          ),
        ),
        content: Container(
          color: const Color.fromARGB(255, 111, 208, 203), // Matching container color
          child: TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              hintText: 'Write your comment here...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.0),
              hintStyle: TextStyle(color: Color(0xFF004D40)), // Dark teal for hint text
            ),
            style: const TextStyle(color: Color(0xFF004D40)), // Dark teal for input text
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF004D40))), // Dark teal color for "Cancel"
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Post', style: TextStyle(color: Color(0xFF004D40))), // Dark teal color for "Post"
            onPressed: () {
              setState(() {
                _posts[postIndex]['comments'].add({
                  'text': _commentController.text,
                  'user': 'assets/user5.jpg',
                });
              });
              _commentController.clear();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  Widget _buildStatusOption(String status, IconData icon, String description) {
    return RadioListTile<String>(
      value: status,
      groupValue: _status,
      title: Text(status),
      subtitle: Text(description),
      secondary: Icon(icon),
      onChanged: (value) {
        setState(() {
          _status = value!;
        });
      },
      activeColor: const Color.fromARGB(255, 3, 76, 72),
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}
class FitnessSessionsPage extends StatefulWidget {
  const FitnessSessionsPage({super.key});

  @override
  _FitnessSessionsPageState createState() => _FitnessSessionsPageState();
}

class _FitnessSessionsPageState extends State<FitnessSessionsPage> {
  String selectedTab = 'Full body';

  final List<Session> sessions = [
    Session(
      imagePath: 'assets/FBW.jpg',
      title: 'FULL BODY WORKOUT: 3 SESSIONS EVERY WEEK',
      instructor: 'Laura J.',
      duration: '2 HRS',
      avatarPath: 'assets/FBW.jpg',
      enrollees: 15,
      intensity: 'High',
    ),
    Session(
      imagePath: 'assets/UPW.jpg',
      title: 'UPPER BODY STRENGTH WORKOUT: M-W-F SESSIONS',
      instructor: 'John Q.',
      duration: '1 HR AND 30 MINS',
      avatarPath: 'assets/UPW.jpg',
      enrollees: 20,
      intensity: 'Medium',
    ),
    Session(
      imagePath: 'assets/LBW.jpg',
      title: 'INTENSE ABS AND LOWER BODY WORKOUT: 2 SESSIONS EVERY WEEK',
      instructor: 'Lucifer M.',
      duration: '1 HR',
      avatarPath: 'assets/LBW.jpg',
      enrollees: 25,
      intensity: 'Low',
    ),
  ];

  @override
Widget build(BuildContext context) {
  // Obtain media query data
  final mediaQuery = MediaQuery.of(context);
  final screenWidth = mediaQuery.size.width;

  // Determine padding and button size based on screen width
  final buttonPadding = screenWidth < 600 ? 8.0 : 19.0;
  final buttonFontSize = screenWidth < 600 ? 10.0 : 17.0;
  final cardPadding = screenWidth < 600 ? 8.0 : 19.0;

  return Scaffold(
    appBar: AppBar(
      title: const Text('ENROLL NOW!'),
      backgroundColor: Colors.teal[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: Column(
      children: [
        _buildTabSelector(buttonPadding, buttonFontSize),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(cardPadding),
            children: [
              if (selectedTab == 'Full body') ...[
                _buildSessionCard(context, sessions[0]),
              ],
              if (selectedTab == 'Upper body') ...[
                _buildSessionCard(context, sessions[1]),
              ],
              if (selectedTab == 'Lower body') ...[
                _buildSessionCard(context, sessions[2]),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTabSelector(double buttonPadding, double buttonFontSize) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: buttonPadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTabButton('Full body', selectedTab == 'Full body', buttonFontSize),
        _buildTabButton('Upper body', selectedTab == 'Upper body', buttonFontSize),
        _buildTabButton('Lower body', selectedTab == 'Lower body', buttonFontSize),
      ],
    ),
  );
}

Widget _buildTabButton(String text, bool isSelected, double fontSize) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal[700] : Colors.teal[100],
        foregroundColor: isSelected ? Colors.white : Colors.teal[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: () {
        setState(() {
          selectedTab = text;
        });
      },
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
    ),
  );
}

  Widget _buildSessionCard(BuildContext context, Session session) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          _showDetailDialog(context, session);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: session.imagePath,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                child: Image.asset(session.imagePath, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.title,
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(session.avatarPath),
                        radius: 15,
                      ),
                      const SizedBox(width: 8.0),
                      Text(session.instructor),
                      const Spacer(),
                      Text(session.duration),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.group, color: Colors.teal[700]),
                      const SizedBox(width: 4.0),
                      Text('${session.enrollees} enrollees'),
                      const Spacer(),
                      Text('Intensity: ${session.intensity}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, Session session) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Determine the screen size
      var mediaQuery = MediaQuery.of(context);
      bool isLandscape = mediaQuery.orientation == Orientation.landscape;
      double dialogWidth = isLandscape ? mediaQuery.size.width * 0.7 : mediaQuery.size.width * 0.9;
      double dialogHeight = isLandscape ? mediaQuery.size.height * 10 : mediaQuery.size.height * 10;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: dialogWidth,
          height: dialogHeight,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.teal[50], // Set the background color related to the theme
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: session.imagePath,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(session.imagePath, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  session.title,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                ),
                const SizedBox(height: 16.0),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: isLandscape ? 2 : 1, // Adjust the number of columns based on orientation
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: isLandscape ? 4 : 6,
                  children: [
                    _buildDetailTile('Instructor: ${session.instructor}', Colors.teal),
                    _buildDetailTile('Duration: ${session.duration}', Colors.teal),
                    _buildDetailTile('Enrollees: ${session.enrollees}', Colors.teal),
                    _buildDetailTile('Intensity: ${session.intensity}', Colors.teal),
                  ],
                ),
               Column(
  children: [
    const SizedBox(height: 16.0),
    SizedBox(
      width: 250, // Specify the desired width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal[700],
        ),
        child: const Text('Join', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.of(context).pop();
          _showJoinDialog(context, session);
        },
      ),
    ),
    const SizedBox(height: 8.0),
    SizedBox(
      width: 250, // Specify the same width for consistency
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal[900],
        ),
        child: const Text('Close', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
  ],
)

              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildDetailTile(String text, Color color) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.teal[50],
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 16.0, color: color),
      textAlign: TextAlign.center,
    ),
  );
}

  void _showJoinDialog(BuildContext context, Session session) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.teal[50], // Set the background color related to the theme
          title: Text('Join Session', style: TextStyle(color: Colors.teal[900])),
          content: Text('Do you want to enroll in "${session.title}"?', style: TextStyle(color: Colors.teal[700])),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.teal[900])),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
              ),
              child: const Text('Join', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  session.enrollees++;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You have joined "${session.title}" session!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class Session {
  final String imagePath;
  final String title;
  final String instructor;
  final String duration;
  final String avatarPath;
  int enrollees; // Changed to mutable
  final String intensity;

  Session({
    required this.imagePath,
    required this.title,
    required this.instructor,
    required this.duration,
    required this.avatarPath,
    required this.enrollees,
    required this.intensity,
  });
}



