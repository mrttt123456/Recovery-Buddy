import 'package:RecoveryBuddy/widgets/recovery_tab.dart';
import "package:universal_html/html.dart" as html;
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:RecoveryBuddy/views/home_view.dart';
import 'package:RecoveryBuddy/views/profile_view.dart';
import 'package:RecoveryBuddy/views/settings_view.dart';
import 'dart:developer';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';
import 'package:RecoveryBuddy/widgets/feed_timeline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// instantiate a new client (server side)
  final client = StreamFeedClient('7wh7un6pmxew',
      secret:
          '3ezvnnntvzjph9qvf55mj4tjn5wjws2p8mdyhck42c6rfzpegg5qneuz2nq7u42d');

  runApp(StretchSafeApp(client: client));
}

/*class DemoUser {
  final User user;
  final Token token;

  const DemoUser({
    required this.user,
    required this.token,
  });
}
*/

class StretchSafeApp extends StatelessWidget {
  final StreamFeedClient client;

  const StretchSafeApp({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'StretchSafe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) => FeedProvider(
              bloc: FeedBloc(
                client: client,
              ),
              child: child!,
            ),
        home: LandingPage(),
        routes: {
          "/HomePage": (_) => new HomePage(pageIndex: 1),
        });
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  static List<Widget> _views = [
    HomeView(),
    RecoveryTab(),
/*    StretchListView(
      stretches: stretches,
    ),
*/
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      appBar: AppBar(
        title: const Text('StretchSafe'),
      ),
*/
      body: Center(
        child: _views.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement),
            label: 'Stretches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

/*const demoUsers = [
  DemoUser(
    user: User(
      id: 'sachaarbonel',
      data: {
        'handle': '@sachaarbonel',
        'first_name': 'Sacha',
        'last_name': 'Arbonel',
        'full_name': 'Sacha Arbonel',
        'profile_image': 'https://avatars.githubusercontent.com/u/18029834?v=4',
      },
    ),
    token: Token(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic2FjaGFhcmJvbmVsIn0._3cnXX-q8pRRcP_ErvqMjQnSbjiknBtSdWvfjtQ85gA'),
  ),
  DemoUser(
    user: User(
      id: 'GroovinChip',
      data: {
        'handle': '@GroovinChip',
        'first_name': 'Reuben',
        'last_name': 'Turner',
        'full_name': 'Reuben Turner',
        'profile_image': 'https://avatars.githubusercontent.com/u/4250470?v=4',
      },
    ),
    token: Token(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiR3Jvb3ZpbkNoaXAifQ.CUifllzvz7s41imbCnyoGyOsLpRyQk-MA5Zu0oUbIIk'),
  ),
  DemoUser(
    user: User(
      id: 'gordonhayes',
      data: {
        'handle': '@gordonphayes',
        'first_name': 'Gordon',
        'last_name': 'Hayes',
        'full_name': 'Gordon Hayes',
        'profile_image': 'https://avatars.githubusercontent.com/u/13705472?v=4',
      },
    ),
    token: Token(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ29yZG9ucGhheWVzIn0.4VaMAj8XkYMYt1JzeNxRZcuGwBSZ9gJ1Us5Jn7SImm0'),
  ),
];
*/

class HomePage extends StatefulWidget {
  final int pageIndex;

  const HomePage({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(pageIndex);
}

class _HomePageState extends State<HomePage> {
  final _pageController;
  int _currentIndex;

  _HomePageState(int initialPageIndex)
      : _currentIndex = initialPageIndex,
        _pageController = PageController(initialPage: initialPageIndex);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static List<Widget> _views = [
    TimelinePage(),
    RecoveryTab(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: _pageController, children: _views),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          _pageController.jumpToPage(value);
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_gymnastics), label: 'Recovery'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getFeed() async {
    final fUser = _auth.currentUser;
    try {
      if (context.feedClient.currentUser == null) {
        //Login to feedclient.
        //1. Obtain token
        final sUser =
            await _firestore.collection('stream_users').doc(fUser?.uid).get();

        //2. Set user
        if (sUser.data() == null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UpdateProfilePage()));
        } else {
          await context.feedClient.setUser(
            User(id: sUser.id, data: sUser.data()?["data"]),
            Token(sUser.data()?["streamUserToken"]),
          );

          //3. Follow everyone. Cause there might be new users.
          var users = await _firestore.collection('stream_users').get();
          for (var user1 in users.docs) {
            await context.feedClient
                .flatFeed('timeline')
                .follow(context.feedClient.flatFeed('user', '${user1.id}'));
          }

          // Connect user
          // Follow own user feed. This ensures the current user's
          // posts are visible on their "timeline" feed.
          await context.feedBloc.followFeed(
            followerFeedGroup: 'timeline',
            followeeFeedGroup: 'user',
            followeeId: fUser!.uid,
          );

          // Navigate to the home page if user connected successfully
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage(pageIndex: 1)));
        }
      }
    } on Exception catch (e, st) {
      log(
        'Could not connect user. See the tutorial for more details:',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getFeed();

    return Scaffold(
      body: Center(
        child: Text(
          "Recover Buddy",
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase.User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          firebase.User? user = snapshot.data;
          if (user == null) {
            return LoginPage();
          } else if (user.displayName == null) {
            return UpdateProfilePage();
          } else {
            return SplashScreen(); // Where the user sees the main content of your app
          }
        }
        return Scaffold(
          body: Center(
              child:
                  CircularProgressIndicator()), // Loading screen while connection is established
        );
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome!')),
      body: Center(
        child: ElevatedButton(
          child: Text("Get Started"),
          onPressed: () async {
            await _auth.signInAnonymously();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UpdateProfilePage()));
          },
        ),
      ),
    );
  }
}

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isUpdating = false;
  Uint8List? _imageData;

  TextEditingController _nameController = TextEditingController();

  void _pickImage() async {
    if (kIsWeb) {
      final input = html.FileUploadInputElement()..accept = 'image/*';
      input.click(); // This will open file picker

      input.onChange.listen((event) {
        final file = input.files!.first;
        final reader = html.FileReader();
        reader.readAsDataUrl(file);

        reader.onLoadEnd.listen((event) {
          setState(() {
            _imageData =
                base64.decode(reader.result.toString().split(",").last);
          });
        });
      });
    } else {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _imageData = await pickedFile.readAsBytes();
        setState(() {}); // Refresh the UI
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete Your Profile')),
      body: Center(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 100, // Size of profile rectangle
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                  image: _imageData != null
                      ? DecorationImage(
                          image: MemoryImage(_imageData!), fit: BoxFit.cover)
                      : null,
                ),
                child: _imageData == null
                    ? Icon(Icons.person, size: 50)
                    : null, // Default icon when no image is selected
              ),
            ),
            Text("Tap to select profile picture",
                style: TextStyle(color: Colors.grey[600])),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Enter your name"),
              onChanged: (value) {
                setState(() {}); // To update the state for the Save button
              },
            ),
            ElevatedButton(
              child: Text(isUpdating ? "Saving..." : "Save"),
              onPressed: (_imageData != null && _nameController.text.isNotEmpty)
                  ? () async {
                      final user = _auth.currentUser;
                      var photoURL;
                      setState(() {
                        isUpdating =
                            true; // <-- Set to true when the updating process starts
                      });

                      // Upload image to Firebase Storage
                      if (user != null) {
                        final ref = FirebaseStorage.instance
                            .ref()
                            .child(user.uid)
                            .child("profile_pic.jpg");
                        await ref.putData(_imageData!,
                            SettableMetadata(contentType: 'image/jpg'));
                        photoURL = await ref.getDownloadURL();

                        // Update user profile
                        await user.updateDisplayName(_nameController.text);
                        await user.updatePhotoURL(photoURL);
                      }

                      final token = context.feedClient.frontendToken(user!.uid);
                      final uData = {
                        "handle": '@' +
                            _nameController.text
                                .toLowerCase()
                                .replaceAll(RegExp(r'\W+'), '_'),
                        "full_name": _nameController.text,
                        "profile_image": photoURL,
                      };

                      // Set/Create Stream user using the firebaseUser UID and generated token
                      await context.feedClient.setUser(
                        User(id: user.uid, data: uData),
                        token,
                      );

                      // Add Stream user info to Firestore
                      await _firestore
                          .collection('stream_users')
                          .doc(user.uid)
                          .set({
                        'streamUserToken': token.toString(),
                        "data": uData,
                      });

                      // Follow other users on Stream
                      var users =
                          await _firestore.collection('stream_users').get();
                      for (var user1 in users.docs) {
                        await context.feedClient.flatFeed('timeline').follow(
                            context.feedClient.flatFeed('user', '${user1.id}'));
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(pageIndex: 1)));
                    }
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
