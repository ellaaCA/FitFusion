import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DietPlanPage(),
    theme: ThemeData(
      primaryColor: Colors.blue,
      fontFamily: 'BonaNovaSC',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 24,fontFamily: 'BonaNovaSC', fontWeight: FontWeight.bold),
        bodySmall: TextStyle(fontSize: 16,fontFamily: 'BonaNovaSC',),
      ),
    ),
  ));
}

class DietPlanPage extends StatefulWidget {
  const DietPlanPage({super.key});

  @override
  _DietPlanPageState createState() => _DietPlanPageState();
}

class _DietPlanPageState extends State<DietPlanPage> {
  String selectedDay = 'Monday';
  Map<String, Map<String, String>> nutritionInfo = {
    'Monday': {'Calories': '2500 kcal', 'Proteins': '100 g', 'Carbs': '300 g', 'Fats': '80 g'},
    'Tuesday': {'Calories': '2300 kcal', 'Proteins': '90 g', 'Carbs': '320 g', 'Fats': '75 g'},
    'Wednesday': {'Calories': '2400 kcal', 'Proteins': '95 g', 'Carbs': '310 g', 'Fats': '78 g'},
    'Thursday': {'Calories': '2450 kcal', 'Proteins': '97 g', 'Carbs': '305 g', 'Fats': '77 g'},
    'Friday': {'Calories': '2550 kcal', 'Proteins': '102 g', 'Carbs': '295 g', 'Fats': '82 g'},
    'Saturday': {'Calories': '2600 kcal', 'Proteins': '105 g', 'Carbs': '290 g', 'Fats': '84 g'},
    'Sunday': {'Calories': '2350 kcal', 'Proteins': '92 g', 'Carbs': '315 g', 'Fats': '76 g'},
  };

  Map<String, Map<String, Map<String, String>>> mealPlans = {
    'Monday': {
      'Breakfast': {
        'description': '8:00 AM - Oatmeal with fruits',
        'imagePath': 'assets/meal/Oatmeal with fruits.jpg'
      },
      'Lunch': {
        'description': '12:30 PM - Grilled chicken salad',
        'imagePath': 'assets/meal/Grilled chicken salad.jpg'
      },
      'Dinner': {
        'description': '6:00 PM - Baked salmon with vegetables',
        'imagePath': 'assets/meal/Baked salmon with vegetables.jpg'
      },
    },
    'Tuesday': {
      'Breakfast': {
        'description': '8:00 AM - Greek yogurt with honey and nuts',
        'imagePath': 'assets/meal/Greek yogurt with honey and nuts.jpg'
      },
      'Lunch': {
        'description': '12:30 PM - Quinoa salad with mixed greens',
        'imagePath': 'assets/meal/Quinoa salad with mixed greens.jpg'
      },
      'Dinner': {
        'description': '6:00 PM - Stir-fried tofu with vegetables',
        'imagePath': 'assets/meal/Stir-fried tofu with vegetables.jpg'
      },
    },
    'Wednesday': {
      'Breakfast': {
        'description': '8:00 AM - Scrambled eggs with whole wheat toast',
        'imagePath': 'assets/meal/Scrambled eggs with whole wheat toast.jpg'
      },
      'Lunch': {
        'description': '12:30 PM - Lentil soup with whole grain bread',
        'imagePath': 'assets/meal/Lentil soup with whole grain bread.jpg'
      },
      'Dinner': {
        'description': '6:00 PM - Grilled shrimp with quinoa and steamed broccoli',
        'imagePath': 'assets/meal/Grilled shrimp with quinoa and steamed broccoli.jpg'
      },
    },
    'Thursday': {
      'Breakfast': {
        'description': '8:00 AM - Smoothie with spinach, banana, and almond milk',
        'imagePath': 'assets/meal/Smoothie with spinach, banana, and almond milk.jpg'
      },
      'Lunch': {
        'description': '12:30 PM - Chickpea salad with lemon tahini dressing',
        'imagePath': 'assets/meal/Chickpea salad with lemon tahini dressing.jpg'
      },
      'Dinner': {
        'description': '6:00 PM - Turkey chili with mixed vegetables',
        'imagePath': 'assets/meal/Turkey chili with mixed vegetables.jpg'
      },
    },
    'Friday': {
      'Breakfast': {
        'description': '8:00 AM - Whole grain cereal with berries and almond milk',
        'imagePath': 'assets/meal/Whole grain cereal with berries and almond milk.jpg'
      },
      'Lunch': {
        'description': '12:30 PM - Spinach and feta stuffed chicken breast',
        'imagePath': 'assets/meal/Spinach and feta stuffed chicken breast.jpg'
      },
      'Dinner': {
        'description': '6:00 PM - Baked cod with quinoa and roasted vegetables',
        'imagePath': 'assets/meal/Baked cod with quinoa and roasted vegetables.jpg'
      },
    },
    'Saturday': {
      'Breakfast': {
        'description': '8:00 AM - Avocado toast with poached egg',
        'imagePath': 'assets/meal/Avocado toast with poached egg.jpg'
      },
      'Lunch': {
        'description': '12:30 PM - Tuna salad with mixed greens and vinaigrette',
        'imagePath': 'assets/meal/Tuna salad with mixed greens and vinaigrette.jpg'
      },
      'Dinner': {
        'description': '6:00 PM - Grilled steak with sweet potato mash and green beans',
        'imagePath': 'assets/meal/Grilled steak with sweet potato mash and green beans.jpg'
      },
    },
    'Sunday': {
      'Breakfast': {
        'description': '8:00 AM - Whole wheat pancakes with berries and maple syrup',
        'imagePath': 'assets/meal/Whole wheat pancakes with berries and maple syrup.jpg'
      },
      'Lunch': {
        'description': '12:30 PM - Caprese salad with whole grain bread',
        'imagePath': 'assets/meal/Caprese salad with whole grain bread.jpg'
      },
      'Dinner': {
        'description': '6:00 PM - Roasted chicken with quinoa and sautéed spinach',
        'imagePath': 'assets/meal/Roasted chicken with quinoa and sautéed spinach.jpg'
      },
    },
  };

  final Map<String, String> breakfastOptions = {
    'Oatmeal with fruits': 'assets/meal/Oatmeal with fruits.jpg',
    'Greek yogurt with honey and nuts': 'assets/meal/Greek yogurt with honey and nuts.jpg',
    'Scrambled eggs with whole wheat toast': 'assets/meal/Scrambled eggs with whole wheat toast.jpg',
    'Smoothie with spinach, banana, and almond milk': 'assets/meal/Smoothie with spinach, banana, and almond milk.jpg',
    'Whole grain cereal with berries and almond milk': 'assets/meal/Whole grain cereal with berries and almond milk.jpg',
    'Avocado toast with poached egg': 'assets/meal/Avocado toast with poached egg.jpg',
    'Whole wheat pancakes with berries and maple syrup': 'assets/meal/Whole wheat pancakes with berries and maple syrup.jpg',
    
    'Fruit salad with nuts': 'assets/meal/Fruit salad with nuts.jpg',
    'Chia seed pudding with berries': 'assets/meal/Chia seed pudding with berries.jpg',
    'Egg white omelette with vegetables': 'assets/meal/Egg white omelette with vegetables.jpg',
    
    'Banana and almond butter smoothie': 'assets/meal/Banana and almond butter smoothi.jpg',
    'Breakfast burrito with scrambled eggs and veggies': 'assets/meal/Breakfast burrito with scrambled eggs and veggies.jpg',
    'Cottage cheese with pineapple': 'assets/meal/Cottage cheese with pineapple.jpg',
    'Whole grain waffles with fresh fruit': 'assets/meal/Whole grain waffles with fresh fruit.jpg',
    'Avocado and tomato salad': 'assets/meal/Avocado and tomato salad.jpg',
    'Green smoothie with kale and apple': 'assets/meal/Green smoothie with kale and apple.jpg',
    'Greek yogurt parfait with granola': 'assets/meal/Greek yogurt parfait with granola.jpg',
  };

  final Map<String, String> lunchOptions = {
    'Grilled chicken salad': 'assets/meal/Grilled chicken salad.jpg',
    'Quinoa salad with mixed greens': 'assets/meal/Quinoa salad with mixed greens.jpg',
    'Lentil soup with whole grain bread': 'assets/meal/Lentil soup with whole grain bread.jpg',
    'Chickpea salad with lemon tahini dressing': 'assets/meal/Chickpea salad with lemon tahini dressing.jpg',
    'Spinach and feta stuffed chicken breast': 'assets/meal/Spinach and feta stuffed chicken breast.jpg',
    'Tuna salad with mixed greens and vinaigrette': 'assets/meal/Tuna salad with mixed greens and vinaigrette.jpg',
    'Caprese salad with whole grain bread': 'assets/meal/Caprese salad with whole grain bread.jpg',

    'Vegetable stir-fry with tofu': 'assets/meal/Vegetable stir-fry with tofu.jpg',
  'Chicken Caesar wrap': 'assets/meal/Chicken Caesar wrap.jpg',
  'Roasted vegetable and hummus sandwich': 'assets/meal/Roasted vegetable and hummus sandwich.jpg',
  'Greek salad with olives and feta': 'assets/meal/Greek salad with olives and feta.jpg',
  'Turkey and avocado club sandwich': 'assets/meal/Turkey and avocado club sandwich.jpg',
  'Minestrone soup with a side salad': 'assets/meal/Minestrone soup with a side salad.jpg',
  'Stuffed bell peppers with quinoa and black beans': 'assets/meal/Stuffed bell peppers with quinoa and black beans.jpg',
  'Grilled vegetable and quinoa bowl': 'assets/meal/Grilled vegetable and quinoa bowl.jpg',
  'Chicken and vegetable skewers': 'assets/meal/Chicken and vegetable skewers.jpg',
  'Black bean and corn salad': 'assets/meal/Black bean and corn salad.jpg',
  };

  final Map<String, String> dinnerOptions = {
    'Baked salmon with vegetables': 'assets/meal/Baked salmon with vegetables.jpg',
    'Stir-fried tofu with vegetables': 'assets/meal/Stir-fried tofu with vegetables.jpg',
    'Grilled shrimp with quinoa and steamed broccoli': 'assets/meal/Grilled shrimp with quinoa and steamed broccoli.jpg',
    'Turkey chili with mixed vegetables': 'assets/meal/Turkey chili with mixed vegetables.jpg',
    'Baked cod with quinoa and roasted vegetables': 'assets/meal/Baked cod with quinoa and roasted vegetables.jpg',
    'Grilled steak with sweet potato mash and green beans': 'assets/meal/Grilled steak with sweet potato mash and green beans.jpg',
    'Roasted chicken with quinoa and sautéed spinach': 'assets/meal/Roasted chicken with quinoa and sautéed spinach.jpg',

    'Vegetarian lasagna with spinach and ricotta': 'assets/meal/Vegetarian lasagna with spinach and ricotta.jpg',
  'Lemon herb chicken with roasted Brussels sprouts': 'assets/meal/Lemon herb chicken with roasted Brussels sprouts.jpg',
  'Miso-glazed salmon with jasmine rice': 'assets/meal/Miso-glazed salmon with jasmine rice.jpg',
  'Beef and vegetable stir-fry': 'assets/meal/Beef and vegetable stir-fry.jpg',
  'Stuffed zucchini boats with ground turkey': 'assets/meal/Stuffed zucchini boats with ground turkey.jpg',
  'Chicken curry with cauliflower rice': 'assets/meal/Chicken curry with cauliflower rice.jpg',
  'Pasta primavera with fresh vegetables': 'assets/meal/Pasta primavera with fresh vegetables.jpg',
  'Garlic and herb roasted pork tenderloin': 'assets/meal/Garlic and herb roasted pork tenderloin.jpg',
  'Sweet and sour chicken with brown rice': 'assets/meal/Sweet and sour chicken with brown rice.jpg',
  'Spaghetti squash with marinara sauce': 'assets/meal/Spaghetti squash with marinara sauce.jpg',
  };

  bool isHovered = false;
  Key _switcherKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diet Plan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MouseRegion(
              onEnter: (_) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  isHovered = false;
                });
              },
              child: DropdownButton<String>(
                value: selectedDay,
                onChanged: (String? day) {
                  setState(() {
                    selectedDay = day!;
                    _switcherKey = UniqueKey();
                  });
                },
                items: <String>[
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: isHovered ? Colors.blue : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                style: TextStyle(
                  color: isHovered ? Colors.blue : Colors.black,
                  fontSize: 16,
                ),
                dropdownColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              key: _switcherKey,
              child: _buildDayContent(selectedDay),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(context, 'Weekly Summary'),
            const SizedBox(height: 10),
            _buildWeeklySummary(),
            const SizedBox(height: 20),
            _buildSectionHeader(context, 'Tips for a Healthy Diet'),
            const SizedBox(height: 10),
            _buildTips(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }

  Widget _buildDayContent(String day) {
    return Column(
      key: ValueKey(day),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildDailyPlan(context, day, 'Breakfast'),
        _buildDailyPlan(context, day, 'Lunch'),
        _buildDailyPlan(context, day, 'Dinner'),
        const SizedBox(height: 20),
        _buildNutritionalInfo(day),
      ],
    );
  }

  Widget _buildDailyPlan(BuildContext context, String day, String mealType) {
    final mealData = mealPlans[day]?[mealType];
    final mealDescription = mealData?['description'] ?? 'No data available';
    final mealImagePath = mealData?['imagePath'] ?? '';

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  mealType,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _editMealPlan(context, mealType);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                if (mealImagePath.isNotEmpty)
                  Image.asset(
                    mealImagePath,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    mealDescription,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editMealPlan(BuildContext context, String mealType) {
    _searchAndSelectMeal(context, mealType);
  }
void _searchAndSelectMeal(BuildContext context, String mealType) {
  Map<String, String> options = {};
  switch (mealType) {
    case 'Breakfast':
      options = Map.from(breakfastOptions);
      break;
    case 'Lunch':
      options = Map.from(lunchOptions);
      break;
    case 'Dinner':
      options = Map.from(dinnerOptions);
      break;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      Map<String, String> filteredOptions = Map.from(options);

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Select a new $mealType'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Search'),
                  onChanged: (query) {
                    setState(() {
                      filteredOptions = {
                        for (var entry in options.entries)
                          if (entry.key.toLowerCase().contains(query.toLowerCase())) entry.key: entry.value
                      };
                    });
                  },
                ),
                Expanded(
                  child: ListView(
                    children: filteredOptions.entries.map((entry) {
                      return ListTile(
                        leading: Image.asset(
                          entry.value,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(entry.key),
                        onTap: () {
                          setState(() {
                            mealPlans[selectedDay]![mealType] = {
                              'description': entry.key,
                              'imagePath': entry.value,
                            };
                          });
                          Navigator.of(context).pop(); // Close dialog after selection
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}



  Widget _buildNutritionalInfo(String day) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nutritional Info',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildNutritionItem(Icons.local_fire_department, 'Calories', nutritionInfo[day]!['Calories']!),
                _buildNutritionItem(Icons.local_dining, 'Proteins', nutritionInfo[day]!['Proteins']!),
                _buildNutritionItem(Icons.local_pizza, 'Carbs', nutritionInfo[day]!['Carbs']!),
                _buildNutritionItem(Icons.local_drink, 'Fats', nutritionInfo[day]!['Fats']!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(IconData icon, String label, String value) {
    return Column(
      children: <Widget>[
        Icon(icon, size: 30, color: Theme.of(context).primaryColor),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklySummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSummaryItem('Total Calories', '17000 kcal'),
        _buildSummaryItem('Average Proteins', '98 g'),
        _buildSummaryItem('Average Carbs', '310 g'),
        _buildSummaryItem('Average Fats', '78 g'),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTips() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF008080),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nutritional Tips',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildTipItem('Eat a variety of foods, including vegetables, fruits, and whole grains.'),
          _buildTipItem('Drink plenty of fluids throughout the day.'),
          _buildTipItem('Limit intake of added sugars in your diet.'),
          _buildTipItem('Reduce consumption of salt and salty foods.'),
          _buildTipItem('Choose lean protein sources such as fish, poultry, or legumes.'),
          _buildTipItem('Opt for healthy fats like those found in nuts, seeds, and olive oil.'),
          const SizedBox(height: 16.0),
          const Text(
            'These habits promote good health and well-being. Consult a nutritionist for personalized advice.',
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.lime, size: 20),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
