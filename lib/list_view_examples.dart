import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'best_approach_demo.dart';

// Sample data models
class Person {
  final String name;
  final int age;
  final String email;
  
  Person(this.name, this.age, this.email);
}

class ListViewExamples extends StatelessWidget {
  // Sample data arrays
  final List<String> simpleItems = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew'
  ];
  
  final List<Person> people = [
    Person('Alice Johnson', 25, 'alice@example.com'),
    Person('Bob Smith', 30, 'bob@example.com'),
    Person('Charlie Brown', 28, 'charlie@example.com'),
    Person('Diana Wilson', 32, 'diana@example.com'),
    Person('Eve Davis', 27, 'eve@example.com'),
  ];
  
  // Generate a large list for performance testing
  final List<int> largeList = List.generate(10000, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Approaches'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildApproachCard(
            context,
            '⭐ BEST APPROACH: ListView.builder',
            'Complete implementation with real-world examples',
            () => context.go('/best-approach'),
          ),
          SizedBox(height: 8),
          _buildApproachCard(
            context,
            'Approach 1: ListView with children',
            'Best for: Small, static lists (< 20 items)',
            () => _navigateToExample(context, Approach1ListView()),
          ),
          _buildApproachCard(
            context,
            'Approach 2: ListView.builder',
            'Best for: Large lists, dynamic content',
            () => _navigateToExample(context, Approach2ListViewBuilder()),
          ),
          _buildApproachCard(
            context,
            'Approach 3: ListView.separated',
            'Best for: Lists with dividers/separators',
            () => _navigateToExample(context, Approach3ListViewSeparated()),
          ),
          _buildApproachCard(
            context,
            'Approach 4: ListView.custom',
            'Best for: Custom scroll behavior and delegates',
            () => _navigateToExample(context, Approach4ListViewCustom()),
          ),
          _buildApproachCard(
            context,
            'Approach 5: Slivers (CustomScrollView)',
            'Best for: Complex scrollable layouts',
            () => _navigateToExample(context, Approach5Slivers()),
          ),
          _buildApproachCard(
            context,
            'Approach 6: ReorderableListView',
            'Best for: User-reorderable lists',
            () => _navigateToExample(context, Approach6ReorderableListView()),
          ),
          SizedBox(height: 20),
          _buildBestPracticeCard(),
        ],
      ),
    );
  }

  Widget _buildApproachCard(BuildContext context, String title, String description, VoidCallback onTap) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildBestPracticeCard() {
    return Card(
      elevation: 6,
      color: Colors.green.shade50,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🏆 Best Approach Recommendation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'ListView.builder is generally the best choice for most scenarios because:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text('• Memory efficient (only builds visible items)'),
            Text('• Handles large datasets efficiently'),
            Text('• Smooth scrolling performance'),
            Text('• Flexible and customizable'),
            Text('• Works well with dynamic data'),
          ],
        ),
      ),
    );
  }

  void _navigateToExample(BuildContext context, Widget example) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => example),
    );
  }
}

// APPROACH 1: ListView with children
class Approach1ListView extends StatelessWidget {
  final List<String> items = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approach 1: ListView with children'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          _buildExplanationCard(
            'ListView with children',
            'Creates all widgets at once. Good for small, static lists.',
            'Use when: List has < 20 items and won\'t change frequently',
            Colors.red.shade50,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: items.map((item) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text(item[0]),
                  ),
                  title: Text(item),
                  subtitle: Text('Static item'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(String title, String description, String useCase, Color color) {
    return Card(
      color: color,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text(useCase, style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}

// APPROACH 2: ListView.builder
class Approach2ListViewBuilder extends StatelessWidget {
  final List<Person> people = List.generate(1000, (index) => 
    Person('Person ${index + 1}', 20 + (index % 50), 'person$index@example.com')
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approach 2: ListView.builder'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _buildExplanationCard(
            'ListView.builder',
            'Builds items on-demand. Memory efficient for large lists.',
            'Use when: List has many items or data changes frequently',
            Colors.blue.shade50,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: people.length,
              itemBuilder: (context, index) {
                final person = people[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('${person.age}'),
                    ),
                    title: Text(person.name),
                    subtitle: Text(person.email),
                    trailing: Icon(Icons.person),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(String title, String description, String useCase, Color color) {
    return Card(
      color: color,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text(useCase, style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}

// APPROACH 3: ListView.separated
class Approach3ListViewSeparated extends StatelessWidget {
  final List<String> categories = [
    'Electronics', 'Clothing', 'Books', 'Home & Garden', 'Sports',
    'Toys', 'Health', 'Beauty', 'Automotive', 'Food'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approach 3: ListView.separated'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          _buildExplanationCard(
            'ListView.separated',
            'Builds items with separators between them.',
            'Use when: You need dividers, borders, or spacing between items',
            Colors.green.shade50,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: categories.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.green,
                thickness: 2,
                height: 20,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.category, color: Colors.green),
                      SizedBox(width: 12),
                      Text(
                        categories[index],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text('${index + 1}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(String title, String description, String useCase, Color color) {
    return Card(
      color: color,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text(useCase, style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}

// APPROACH 4: ListView.custom
class Approach4ListViewCustom extends StatelessWidget {
  final List<String> items = List.generate(50, (index) => 'Custom Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approach 4: ListView.custom'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          _buildExplanationCard(
            'ListView.custom',
            'Uses custom SliverChildDelegate for advanced control.',
            'Use when: You need custom scrolling behavior or complex item management',
            Colors.purple.shade50,
          ),
          Expanded(
            child: ListView.custom(
              padding: EdgeInsets.all(16),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    color: Colors.purple.shade100,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(items[index]),
                      subtitle: Text('Custom delegate item'),
                      trailing: Icon(Icons.settings),
                    ),
                  );
                },
                childCount: items.length,
                // Custom delegate allows for more control
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(String title, String description, String useCase, Color color) {
    return Card(
      color: color,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text(useCase, style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}

// APPROACH 5: Slivers (CustomScrollView)
class Approach5Slivers extends StatelessWidget {
  final List<String> headers = ['Section A', 'Section B', 'Section C'];
  final List<List<String>> sections = [
    ['Item A1', 'Item A2', 'Item A3'],
    ['Item B1', 'Item B2', 'Item B3', 'Item B4'],
    ['Item C1', 'Item C2'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approach 5: Slivers'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          _buildExplanationCard(
            'Slivers (CustomScrollView)',
            'Combines multiple scrollable widgets with custom effects.',
            'Use when: You need complex scrollable layouts with headers, grids, lists',
            Colors.orange.shade50,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 100,
                  floating: true,
                  pinned: true,
                  backgroundColor: Colors.orange,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('Flexible Header'),
                  ),
                ),
                ...List.generate(headers.length, (sectionIndex) => [
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.orange.shade100,
                      child: Text(
                        headers[sectionIndex],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: ListTile(
                            title: Text(sections[sectionIndex][index]),
                            leading: Icon(Icons.circle, color: Colors.orange),
                          ),
                        );
                      },
                      childCount: sections[sectionIndex].length,
                    ),
                  ),
                ]).expand((x) => x),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(String title, String description, String useCase, Color color) {
    return Card(
      color: color,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text(useCase, style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}

// APPROACH 6: ReorderableListView
class Approach6ReorderableListView extends StatefulWidget {
  @override
  _Approach6ReorderableListViewState createState() => _Approach6ReorderableListViewState();
}

class _Approach6ReorderableListViewState extends State<Approach6ReorderableListView> {
  List<String> items = ['Task 1', 'Task 2', 'Task 3', 'Task 4', 'Task 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approach 6: ReorderableListView'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          _buildExplanationCard(
            'ReorderableListView',
            'Allows users to reorder items by dragging.',
            'Use when: Users need to change the order of items',
            Colors.teal.shade50,
          ),
          Expanded(
            child: ReorderableListView(
              padding: EdgeInsets.all(16),
              children: items.map((item) => Card(
                key: ValueKey(item),
                child: ListTile(
                  leading: Icon(Icons.drag_handle, color: Colors.teal),
                  title: Text(item),
                  subtitle: Text('Drag to reorder'),
                  trailing: Icon(Icons.reorder),
                ),
              )).toList(),
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = items.removeAt(oldIndex);
                  items.insert(newIndex, item);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(String title, String description, String useCase, Color color) {
    return Card(
      color: color,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text(useCase, style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
} 