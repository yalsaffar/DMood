import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MoodTrackerPage extends StatefulWidget {
  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage>
    with SingleTickerProviderStateMixin {
  int upVotes = 0;
  int downVotes = 0;
  bool? votedUp;
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _feedbackController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<Color?> _backgroundColor;

  @override
  void initState() {
    super.initState();
    _speak('Welcome to the Mood Tracker. How are you feeling today?');

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: true);

    _backgroundColor = ColorTween(
      begin: Colors.lightBlue,
      end: Colors.purple,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _speak(String message) async {
    await flutterTts.speak(message);
  }

  Widget _buildMoodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.sentiment_very_satisfied),
          onPressed: () => _vote(true),
          color: const Color.fromARGB(255, 36, 75, 37),
        ),
        IconButton(
          icon: Icon(Icons.sentiment_very_dissatisfied),
          onPressed: () => _vote(false),
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _feedbackTextField() {
    return FadeTransition(
      opacity: AlwaysStoppedAnimation(1.0),
      child: TextField(
        controller: _feedbackController,
        decoration: InputDecoration(
          hintText: 'Share your thoughts...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        maxLines: 3,
      ),
    );
  }

  String _getPersonalizedGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning! How are you feeling today?';
    } else if (hour < 17) {
      return 'Good Afternoon! How are you feeling today?';
    } else {
      return 'Good Evening! How are you feeling today?';
    }
  }

  void _vote(bool upvote) {
    setState(() {
      if (votedUp == null || votedUp != upvote) {
        if (upvote) {
          if (votedUp == false) downVotes--;
          upVotes++;
        } else {
          if (votedUp == true) upVotes--;
          downVotes++;
        }
        votedUp = upvote;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _backgroundColor.value,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenSize.height),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/assets/profile_image.png'),
                        radius: screenSize.width * 0.1,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            _getPersonalizedGreeting(),
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color:
                                      const Color.fromARGB(255, 233, 225, 225),
                                  fontSize: 24,
                                ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        totalRepeatCount: 1,
                        pause: const Duration(milliseconds: 1000),
                      ),
                      SizedBox(height: 20),
                      _buildMoodSelector(),
                      SizedBox(height: 10),
                      Text(
                        'Date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Text(
                        '$upVotes people UPVOTED, $downVotes DOWNVOTED Today',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (votedUp != null) ...[
                        SizedBox(height: screenSize.height * 0.02),
                        _feedbackTextField(),
                        SizedBox(height: screenSize.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            final XFile? pickedImage = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedImage != null) {
                              setState(() {
                                image = pickedImage;
                              });
                            }
                          },
                          child: Text('Share a Photo'),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        ElevatedButton(
                          onPressed: () {
                            // Handle feedback submission logic
                          },
                          child: Text('Share How You Feel'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
