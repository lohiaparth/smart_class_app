import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ResourcesPage(),
  ));
}

class ResourcesPage extends StatefulWidget {
  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  final List<String> resources = [
    'Mathematics.pdf',
    'Science.pdf',
    'History.pdf',
  ];

  final Set<String> favorites = {}; // Set to store favorite resources
  bool isDownloading = false;
  double downloadProgress = 0.0;
  int _selectedIndex = 0; // To track the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Resources' : 'Favorites'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildResourceList() : _buildFavoritesList(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
      // Display download progress indicator
      floatingActionButton: isDownloading ? _buildDownloadProgress() : null,
    );
  }

  Widget _buildResourceList() {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        final resourceName = resources[index];
        final isFavorite = favorites.contains(resourceName);
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            leading: Icon(Icons.picture_as_pdf, color: Colors.red),
            title: Text(
              resourceName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Tap for details'),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    favorites.remove(resourceName);
                  } else {
                    favorites.add(resourceName);
                  }
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(resourceName: resourceName),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFavoritesList() {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final resourceName = favorites.elementAt(index);
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            leading: Icon(Icons.picture_as_pdf, color: Colors.red),
            title: Text(
              resourceName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Tap for details'),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                setState(() {
                  favorites.remove(resourceName);
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(resourceName: resourceName),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDownloadProgress() {
    return Center(
      child: AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(value: downloadProgress),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'Downloading... ${(downloadProgress * 100).toStringAsFixed(0)}%',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startDownload(String resourceName) {
    setState(() {
      isDownloading = true;
      downloadProgress = 0.0;
    });

    // Simulate a download process
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        downloadProgress = 1.0;
        isDownloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$resourceName downloaded successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    });

    // Simulate incremental download progress
    for (int i = 1; i <= 5; i++) {
      Future.delayed(Duration(seconds: i), () {
        setState(() {
          downloadProgress = i * 0.2;
        });
      });
    }
  }
}

class DetailsPage extends StatelessWidget {
  final String resourceName;

  DetailsPage({required this.resourceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resourceName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example details (you can expand this with real data)
            Text(
              'Resource Name: $resourceName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Author: Example Author',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Description: This is a detailed description of the resource.',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement the download functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$resourceName is being downloaded!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Download'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

