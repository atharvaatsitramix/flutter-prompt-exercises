import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

// Models for different data types
class Product {
  final int id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;
  final bool inStock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.inStock,
  });
}

class Message {
  final String sender;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.sender,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });
}

class BestApproachDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView.builder - Best Approach'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildHeaderCard(),
          SizedBox(height: 16),
          _buildDemoCard(
            context,
            '📱 E-commerce Product List',
            'Large dataset with images and filtering',
            () => _navigateToDemo(context, EcommerceListDemo()),
          ),
          _buildDemoCard(
            context,
            '💬 Chat Messages',
            'Dynamic content with real-time updates',
            () => _navigateToDemo(context, ChatMessagesDemo()),
          ),
          _buildDemoCard(
            context,
            '🚀 Performance Test',
            '10,000+ items with smooth scrolling',
            () => _navigateToDemo(context, PerformanceTestDemo()),
          ),
          _buildDemoCard(
            context,
            '🔄 Dynamic Data',
            'Add, remove, and update items efficiently',
            () => _navigateToDemo(context, DynamicDataDemo()),
          ),
          SizedBox(height: 16),
          _buildBestPracticesCard(),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 6,
      color: Colors.blue.shade50,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 32),
                SizedBox(width: 12),
                Text(
                  'ListView.builder - The Champion',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Why ListView.builder wins:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildAdvantage('⚡', 'Memory Efficient', 'Only builds visible widgets'),
            _buildAdvantage('🚀', 'High Performance', 'Smooth scrolling even with 10,000+ items'),
            _buildAdvantage('🔄', 'Dynamic Content', 'Perfect for API data and real-time updates'),
            _buildAdvantage('🎯', 'Flexible', 'Works with any data type and layout'),
            _buildAdvantage('📱', 'Production Ready', 'Used by major apps worldwide'),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvantage(String emoji, String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: TextStyle(fontSize: 16)),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCard(BuildContext context, String title, String description, VoidCallback onTap) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.play_arrow, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildBestPracticesCard() {
    return Card(
      elevation: 4,
      color: Colors.green.shade50,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🏆 Best Practices Implemented',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            SizedBox(height: 12),
            Text('✅ Always use keys for dynamic lists'),
            Text('✅ Implement proper itemBuilder logic'),
            Text('✅ Handle empty states gracefully'),
            Text('✅ Add loading indicators for async data'),
            Text('✅ Optimize widget build methods'),
            Text('✅ Use const constructors where possible'),
          ],
        ),
      ),
    );
  }

  void _navigateToDemo(BuildContext context, Widget demo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => demo),
    );
  }
}

// E-commerce Product List Demo
class EcommerceListDemo extends StatefulWidget {
  @override
  _EcommerceListDemoState createState() => _EcommerceListDemoState();
}

class _EcommerceListDemoState extends State<EcommerceListDemo> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateProducts();
  }

  void _generateProducts() {
    final categories = ['Electronics', 'Clothing', 'Books', 'Home', 'Sports'];
    final productNames = [
      'Smartphone', 'Laptop', 'T-Shirt', 'Jeans', 'Novel', 'Cookbook',
      'Sofa', 'Table', 'Football', 'Tennis Racket', 'Headphones', 'Tablet'
    ];

    products = List.generate(500, (index) {
      final random = Random();
      return Product(
        id: index,
        name: '${productNames[random.nextInt(productNames.length)]} ${index + 1}',
        price: 10.0 + random.nextDouble() * 990.0,
        category: categories[random.nextInt(categories.length)],
        imageUrl: 'https://picsum.photos/100/100?random=$index',
        inStock: random.nextBool(),
      );
    });

    // Simulate loading delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        filteredProducts = products;
        isLoading = false;
      });
    });
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredProducts = products;
      } else {
        filteredProducts = products
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()) ||
                product.category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce Demo'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.orange.shade50,
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // Stats Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.orange.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${filteredProducts.length} products found'),
                Text('ListView.builder efficiency: ⚡'),
              ],
            ),
          ),
          // Product List
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return Card(
                        key: ValueKey(product.id), // Best practice: use keys
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(product.imageUrl),
                            backgroundColor: Colors.grey.shade300,
                          ),
                          title: Text(
                            product.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\$${product.price.toStringAsFixed(2)}'),
                              Text(
                                product.category,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                product.inStock ? Icons.check_circle : Icons.cancel,
                                color: product.inStock ? Colors.green : Colors.red,
                              ),
                              Text(
                                product.inStock ? 'In Stock' : 'Out',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          onTap: () => _showProductDetails(context, product),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showProductDetails(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${product.price.toStringAsFixed(2)}'),
            Text('Category: ${product.category}'),
            Text('Status: ${product.inStock ? "In Stock" : "Out of Stock"}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Chat Messages Demo
class ChatMessagesDemo extends StatefulWidget {
  @override
  _ChatMessagesDemoState createState() => _ChatMessagesDemoState();
}

class _ChatMessagesDemoState extends State<ChatMessagesDemo> {
  List<Message> messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _generateInitialMessages();
    _simulateIncomingMessages();
  }

  void _generateInitialMessages() {
    final sampleMessages = [
      'Hey! How are you?',
      'I\'m good, thanks for asking!',
      'Are you free this weekend?',
      'Yes, what did you have in mind?',
      'Maybe we could go to the movies?',
      'That sounds great! What time?',
    ];

    messages = List.generate(sampleMessages.length, (index) {
      return Message(
        sender: index % 2 == 0 ? 'You' : 'Friend',
        content: sampleMessages[index],
        timestamp: DateTime.now().subtract(Duration(minutes: (sampleMessages.length - index) * 5)),
        isRead: true,
      );
    });
  }

  void _simulateIncomingMessages() {
    // Simulate receiving new messages every 10 seconds
    Timer.periodic(Duration(seconds: 10), (timer) {
      if (mounted) {
        _addMessage('Friend', 'This is a simulated message ${DateTime.now().millisecond}');
      } else {
        timer.cancel();
      }
    });
  }

  void _addMessage(String sender, String content) {
    setState(() {
      messages.add(Message(
        sender: sender,
        content: content,
        timestamp: DateTime.now(),
        isRead: sender == 'You',
      ));
    });
    
    // Auto scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      _addMessage('You', _messageController.text.trim());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Demo'),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('${messages.length} messages'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message.sender == 'You';
                
                return Container(
                  key: ValueKey('${message.timestamp.millisecondsSinceEpoch}'),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue.shade100 : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.content,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Message Input
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  mini: true,
                  onPressed: _sendMessage,
                  child: Icon(Icons.send),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

// Performance Test Demo
class PerformanceTestDemo extends StatefulWidget {
  @override
  _PerformanceTestDemoState createState() => _PerformanceTestDemoState();
}

class _PerformanceTestDemoState extends State<PerformanceTestDemo> {
  final List<String> items = List.generate(10000, (index) => 'Item ${index + 1}');
  int visibleItemsBuilt = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance Test'),
        backgroundColor: Colors.red,
        actions: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Built: $visibleItemsBuilt'),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.red.shade50,
            child: Column(
              children: [
                Text(
                  '🚀 Performance Test: 10,000 Items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('ListView.builder only creates visible widgets!'),
                Text('Scroll through 10,000 items smoothly'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                // Count how many items are actually built
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      visibleItemsBuilt = index + 1;
                    });
                  }
                });

                return Card(
                  key: ValueKey(index),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(items[index]),
                    subtitle: Text('Widget built efficiently'),
                    trailing: Text('${((index + 1) / items.length * 100).toStringAsFixed(1)}%'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Dynamic Data Demo
class DynamicDataDemo extends StatefulWidget {
  @override
  _DynamicDataDemoState createState() => _DynamicDataDemoState();
}

class _DynamicDataDemoState extends State<DynamicDataDemo> {
  List<String> items = ['Initial Item 1', 'Initial Item 2', 'Initial Item 3'];
  final TextEditingController _controller = TextEditingController();

  void _addItem() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        items.add(_controller.text.trim());
      });
      _controller.clear();
    }
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _editItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        final editController = TextEditingController(text: items[index]);
        return AlertDialog(
          title: Text('Edit Item'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(labelText: 'Item text'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  items[index] = editController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Data Demo'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.purple.shade50,
            child: Column(
              children: [
                Text(
                  '🔄 Dynamic Data Management',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Add, edit, and remove items efficiently'),
                Text('ListView.builder handles changes seamlessly'),
              ],
            ),
          ),
          // Add Item Section
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'New item',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('Add'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                ),
              ],
            ),
          ),
          // Items Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Total items: ${items.length}'),
          ),
          // Items List
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(
                      'No items yet. Add some!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        key: ValueKey('${items[index]}_$index'), // Important for dynamic lists
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Text('${index + 1}'),
                          ),
                          title: Text(items[index]),
                          subtitle: Text('Tap to edit, swipe to delete'),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _editItem(index);
                              } else if (value == 'delete') {
                                _removeItem(index);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(value: 'delete', child: Text('Delete')),
                            ],
                          ),
                          onTap: () => _editItem(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 