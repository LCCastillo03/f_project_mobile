import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/feedback_controllers.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/domain/models/feedback_model.dart';
import 'package:project/presentation/pages/event_detail_page.dart';
import 'package:project/presentation/widgets/feedback_item.dart';
import 'package:project/presentation/widgets/search_item.dart';
import 'package:project/presentation/widgets/star_rating_form.dart';
import 'package:project/utils.dart';

// Mock data setup
void setUpMockData() {
  // Initialize GetX or reset if already initialized
  Get.testMode = true; // Ensure GetX is in test mode
  Get.reset(); // Reset bindings

  // Set up EventsController with mock data
  final eventsController = EventsController();
  eventsController.events.value = [
    EventModel(
      id: "1",
      category:
          "Test Category", // Provide a category for eventDecorationImagePath()
      name: 'Test Event',
      author: 'Test Author',
      location: 'Test Location',
      description: 'This is a test event.',
      // Ensure the date is in the future so the Subscribe button appears
      date: DateTime.now().add(const Duration(days: 5)),
      maxParticipants: 100,
      subscribedParticipants: 50,
      subscribed: false,
      avgRating: 4.5,
      // Add any other required properties used by eventDecorationImagePath() if needed
    )
  ];
  // Use Get.put to make it available for Get.find()
  Get.put<EventsController>(eventsController);

  // Set up FeedbackController with mock data
  final feedbackController = FeedbackController();
  feedbackController.feedbackList.value = [
    FeedbackModel(
      username: 'Test User',
      content: 'This is a test feedback.',
      rating: 4,
      profilePic:
          'assets/images/avatars/avatar-1.jpg', // <-- Use the correct path to an existing, declared image
      date: DateTime.now().subtract(const Duration(hours: 1)),
      votes: 10,
      upvoted: false,
      downvoted: false,
    )
  ];
  Get.put<FeedbackController>(feedbackController);
}

void main() {
  // Ensure Flutter bindings are initialized for testing
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up mock data before each test
  setUp(() {
    setUpMockData();
  });

  group('Widget Tests', () {
    testWidgets('EventDetailPage displays event details',
        (WidgetTester tester) async {
      // Pump the widget using GetMaterialApp
      await tester.pumpWidget(
        GetMaterialApp(
          home: EventDetailPage(index: 0),
        ),
      );

      // Allow time for widgets relying on controllers/Obx to build
      await tester.pumpAndSettle(); // Use pumpAndSettle for async rebuilds

      // Verify event details are displayed
      expect(find.textContaining('Test Event'), findsOneWidget);
      expect(find.textContaining('By Test Author'), findsOneWidget);
      expect(find.textContaining('Test Location'), findsOneWidget);
      expect(find.text('This is a test event.'),
          findsOneWidget); // Description likely not clipped
      expect(find.text('50/100'), findsOneWidget); // Check participant count
    });

    testWidgets('EventDetailPage Subscribe button works',
        (WidgetTester tester) async {
      // Pump the widget using GetMaterialApp
      await tester.pumpWidget(
        GetMaterialApp(
          home: EventDetailPage(index: 0),
        ),
      );

      // Allow time for widgets and state updates
      await tester.pumpAndSettle();

      final subscribeButtonFinder =
          find.widgetWithText(ElevatedButton, 'Subscribe');

      expect(subscribeButtonFinder, findsOneWidget,
          reason: 'Could not find Subscribe button');

      await tester.tap(subscribeButtonFinder);

      await tester.pumpAndSettle();

      final unsubscribeButtonFinder =
          find.widgetWithText(ElevatedButton, 'Unsubscribe');
      expect(unsubscribeButtonFinder, findsOneWidget,
          reason: 'Button did not change to Unsubscribe');

      // Optional: Verify controller state changed
      final controller = Get.find<EventsController>();
      expect(controller.events[0].subscribed, true);
    });

    testWidgets('FeedbackItem displays feedback content and username',
        (WidgetTester tester) async {
      // Ensure controller has data
      final controller = Get.find<FeedbackController>();
      expect(controller.feedbackList.isNotEmpty, true);

      // Pump the FeedbackItem within a GetMaterialApp context
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: ListView(
              children: [FeedbackItem(index: 0)],
            ),
          ),
        ),
      );

      // --- Try Multi-Pump Sequence ---
      // Sometimes needed for complex builds or Obx updates
      await tester.pump(); // Initial build frame
      await tester.pump(); // Allow Obx/controllers to react
      await tester.pumpAndSettle(); // Settle animations/async gaps
      // --- End Multi-Pump ---

      // --- Add Debug Dump ---
      // Uncomment this line to print the widget tree right before the check:
      debugDumpApp();
      // --- End Debug Dump ---

      // --- Verify Content and Username ---
      final feedbackItemFinder = find.byType(FeedbackItem);
      expect(feedbackItemFinder, findsOneWidget);

      final contentFinder = find.descendant(
        of: feedbackItemFinder,
        matching: find.textContaining('This is a test feedback.'),
      );
      // Check the content finder specifically
      expect(contentFinder, findsOneWidget,
          reason:
              'Feedback content not found within FeedbackItem. Check debugDumpApp output if enabled.');

      final usernameFinder = find.descendant(
        of: feedbackItemFinder,
        matching: find.textContaining('Test User'),
      );
      expect(usernameFinder, findsOneWidget,
          reason: 'Username not found within FeedbackItem');

      // Optional: Verify rating stars (keep these)
      final ratingStarFinder = find.descendant(
        of: feedbackItemFinder,
        matching: find.byIcon(Icons.star),
      );
      expect(ratingStarFinder, findsNWidgets(4));

      final ratingStarBorderFinder = find.descendant(
        of: feedbackItemFinder,
        matching: find.byIcon(Icons.star_border),
      );
      expect(ratingStarBorderFinder, findsOneWidget);
    });

    testWidgets('SearchItem calls onChanged', (WidgetTester tester) async {
      String? enteredText;
      await tester.pumpWidget(
        MaterialApp(
          // SearchItem doesn't seem to use GetX directly
          home: Scaffold(
            body: SearchItem(onChanged: (text) {
              enteredText = text;
            }),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello');
      // No need for pumpAndSettle usually for simple text field updates unless debouncing exists
      await tester.pump(); // Just pump to reflect the final state

      expect(enteredText, 'Hello');
    });

    testWidgets('StarRatingForm selects rating', (WidgetTester tester) async {
      int? selectedRating;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRatingForm(
              selectedRating: 0,
              onRatingSelected: (rating) {
                selectedRating = rating;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.star).first);
      await tester.pumpAndSettle();

      expect(selectedRating, 1);
    });
  });
}
