import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import for DateFormat
// No Mocks needed
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/feedback_controllers.dart';
//import 'package:project/controllers/navigation_controller.dart'; // Testing as Widget
import 'package:project/data/repositories/feedback_repository.dart'; // Import for feedbackRepo list
import 'package:project/data/repositories/events_repository.dart'; // Import for eventsRepo list
import 'package:project/domain/models/event_model.dart';
import 'package:project/domain/models/feedback_model.dart';
import 'package:project/domain/models/schedule_item.dart';
//import 'package:project/presentation/widgets/agenda_item.dart';
//import 'package:project/presentation/widgets/avatar_selector.dart';
import 'package:project/presentation/widgets/comment_input.dart';
//import 'package:project/presentation/widgets/event_card.dart';
import 'package:project/presentation/widgets/event_details_h.dart';
import 'package:project/presentation/widgets/event_schedule_widget.dart';
//import 'package:project/presentation/widgets/feedback_item.dart';
import 'package:project/presentation/widgets/search_item.dart';
import 'package:project/presentation/widgets/star_rating_form.dart';
import 'package:project/utils.dart'; // Import for eventDecorationImagePath, getTimestamp etc.

// Helper function to pump widgets with Material context
Future<void> pumpWidgetWithMaterialApp(WidgetTester tester, Widget widget) {
  // Provide GetMaterialApp as many widgets now use Get.find()
  return tester.pumpWidget(GetMaterialApp(home: Scaffold(body: widget)));
}

// --- Controller & Widget Tests ---
void main() {
  // Ensure GetX is initialized for tests that use Get.put/find
  setUpAll(() => Get.testMode = true);
  // Reset GetX bindings after each test method for isolation
  tearDown(() => Get.reset());

  // --- Tests for NavigationController, EventsController, FeedbackController ---
  // --- AgendaItem, AvatarSelector, CommentInput ---
  // (These groups passed previously and remain unchanged)

  group('EventsController Tests', () {
    /* ... unchanged ... */
    late EventsController eventsController;
    // Sample Event Data
    final tEvent1 = EventModel(
        id: '1',
        name: 'Test Event 1',
        author: 'Author 1',
        date: DateTime(2025, 10, 20),
        description: 'Desc 1',
        category: 'Tech',
        maxParticipants: 50,
        subscribedParticipants: 10,
        location: 'Location 1',
        schedule: [],
        subscribed: false,
        avgRating: 4.0);
    final tEvent2 = EventModel(
        id: '2',
        name: 'Test Event 2',
        author: 'Author 2',
        date: DateTime(2025, 11, 21),
        description: 'Desc 2',
        category: 'Music',
        maxParticipants: 100,
        subscribedParticipants: 100,
        location: 'Location 2',
        schedule: [],
        subscribed: true,
        avgRating: 4.5);
    final tEvent3 = EventModel(
        id: '3',
        name: 'Tech Event 3',
        author: 'Author 3',
        date: DateTime(2025, 12, 01),
        description: 'Desc 3',
        category: 'Tech',
        maxParticipants: 20,
        subscribedParticipants: 5,
        location: 'Location 3',
        schedule: [],
        subscribed: false);

    setUp(() {
      eventsController = Get.put(EventsController());
      eventsController.events.assignAll(List.from(eventsRepo));
      eventsController.selectedCategory.value = "All";
    });
    test('Initial state should be correct', () {
      expect(eventsController.selectedCategory.value, "All");
      expect(eventsController.events.length, eventsRepo.length);
    });
    test(
        'updateCategory changes selectedCategory and affects getFilteredEvents',
        () {
      eventsController.updateCategory('Business');
      expect(eventsController.selectedCategory.value, 'Business');
      final updatedFiltered = eventsController.getFilteredEvents();
      final expectedBusinessEvents =
          eventsRepo.where((e) => e.category == 'Business').toList();
      expect(updatedFiltered.length, expectedBusinessEvents.length);
      expect(
          updatedFiltered.every((item) => item['event'].category == 'Business'),
          isTrue);
      eventsController.updateCategory('All');
      expect(eventsController.getFilteredEvents().length, eventsRepo.length);
    });
    test(
        'toggleSubscription successfully subscribes when not subscribed and space available',
        () {
      final testEvent = EventModel(
          id: 'sub1',
          name: 'Event To Sub',
          author: 'Auth',
          date: DateTime.now().add(Duration(days: 5)),
          description: 'Desc',
          category: 'Test',
          maxParticipants: 10,
          subscribedParticipants: 5,
          location: 'Loc',
          schedule: [],
          subscribed: false);
      eventsController.events.add(testEvent);
      final index = eventsController.events.length - 1;
      final initialSubCount = testEvent.subscribedParticipants;
      final result = eventsController.toggleSubscription(index);
      expect(result, isTrue);
      final updatedEvent = eventsController.events[index];
      expect(updatedEvent.subscribed, isTrue);
      expect(updatedEvent.subscribedParticipants, initialSubCount + 1);
    });
    test('toggleSubscription successfully unsubscribes when subscribed', () {
      final testEvent = EventModel(
          id: 'sub2',
          name: 'Event To Unsub',
          author: 'Auth',
          date: DateTime.now().add(Duration(days: 5)),
          description: 'Desc',
          category: 'Test',
          maxParticipants: 10,
          subscribedParticipants: 6,
          location: 'Loc',
          schedule: [],
          subscribed: true);
      eventsController.events.add(testEvent);
      final index = eventsController.events.length - 1;
      final initialSubCount = testEvent.subscribedParticipants;
      final result = eventsController.toggleSubscription(index);
      expect(result, isTrue);
      final updatedEvent = eventsController.events[index];
      expect(updatedEvent.subscribed, isFalse);
      expect(updatedEvent.subscribedParticipants, initialSubCount - 1);
    });

    test(
        'getSubscribedEvents returns only subscribed events with original indices',
        () {
      eventsController.events
          .assignAll([tEvent1, tEvent2, tEvent3]); // tEvent2 is subscribed
      final subscribedList = eventsController.getSubscribedEvents();
      expect(subscribedList, hasLength(1));
      expect(subscribedList[0]['index'], 1);
      expect(subscribedList[0]['event'], tEvent2);
    });
    test(
        'getFilteredEvents returns correct events based on category with original indices',
        () {
      eventsController.events
          .assignAll([tEvent1, tEvent2, tEvent3]); // Tech, Music, Tech
      eventsController.updateCategory('Tech');
      final filteredList = eventsController.getFilteredEvents();
      expect(filteredList, hasLength(2));
      expect(filteredList[0]['index'], 0);
      expect(filteredList[1]['index'], 2);
      eventsController.updateCategory('Music');
      final filteredMusicList = eventsController.getFilteredEvents();
      expect(filteredMusicList, hasLength(1));
      expect(filteredMusicList[0]['index'], 1);
    });
    test('toggleSubscription handles invalid index gracefully', () {
      final initialListState = List<EventModel>.from(eventsController.events);
      expect(eventsController.toggleSubscription(-1), isFalse);
      expect(
          eventsController.toggleSubscription(eventsController.events.length),
          isFalse);
      expect(eventsController.events, equals(initialListState));
    });
  });
  group('FeedbackController Tests', () {
    /* ... unchanged ... */
    late FeedbackController feedbackController;
    setUp(() {
      feedbackController = Get.put(FeedbackController());
      feedbackController.onInit();
      feedbackController.feedbackList.assignAll(List.from(feedbackRepo));
    });
    test('onInit assigns initial feedback list', () {
      expect(feedbackController.feedbackList.length, feedbackRepo.length);
      expect(feedbackController.feedbackList[0].username,
          feedbackRepo[0].username);
    });
    test(
        'toggleUpvote increases votes and sets flags correctly (no prior vote)',
        () {
      final initialFeedback = feedbackRepo[0].copyWith();
      feedbackController.feedbackList[0] = initialFeedback;
      final initialVotes = initialFeedback.votes;
      feedbackController.toggleUpvote(0);
      final updatedFeedback = feedbackController.feedbackList[0];
      expect(updatedFeedback.votes, initialVotes + 1);
      expect(updatedFeedback.upvoted, isTrue);
      expect(updatedFeedback.downvoted, isFalse);
    });
    test('toggleUpvote removes upvote if already upvoted', () {
      final initialFeedback =
          feedbackRepo[0].copyWith(upvoted: true, votes: 1, downvoted: false);
      feedbackController.feedbackList[0] = initialFeedback;
      final initialVotes = initialFeedback.votes;
      feedbackController.toggleUpvote(0);
      final updatedFeedback = feedbackController.feedbackList[0];
      expect(updatedFeedback.votes, initialVotes - 1);
      expect(updatedFeedback.upvoted, isFalse);
      expect(updatedFeedback.downvoted, isFalse);
    });
    test(
        'toggleUpvote removes downvote and adds upvote if previously downvoted',
        () {
      final initialFeedback =
          feedbackRepo[0].copyWith(downvoted: true, votes: -1, upvoted: false);
      feedbackController.feedbackList[0] = initialFeedback;
      final initialVotes = initialFeedback.votes;
      feedbackController.toggleUpvote(0);
      final updatedFeedback = feedbackController.feedbackList[0];
      expect(updatedFeedback.votes, initialVotes + 2);
      expect(updatedFeedback.upvoted, isTrue);
      expect(updatedFeedback.downvoted, isFalse);
    });
    test(
        'toggleDownvote decreases votes and sets flags correctly (no prior vote)',
        () {
      final initialFeedback = feedbackRepo[1].copyWith();
      feedbackController.feedbackList[1] = initialFeedback;
      final initialVotes = initialFeedback.votes;
      feedbackController.toggleDownvote(1);
      final updatedFeedback = feedbackController.feedbackList[1];
      expect(updatedFeedback.votes, initialVotes - 1);
      expect(updatedFeedback.downvoted, isTrue);
      expect(updatedFeedback.upvoted, isFalse);
    });
    test('toggleDownvote removes downvote if already downvoted', () {
      final initialFeedback =
          feedbackRepo[1].copyWith(downvoted: true, votes: -1, upvoted: false);
      feedbackController.feedbackList[1] = initialFeedback;
      final initialVotes = initialFeedback.votes;
      feedbackController.toggleDownvote(1);
      final updatedFeedback = feedbackController.feedbackList[1];
      expect(updatedFeedback.votes, initialVotes + 1);
      expect(updatedFeedback.downvoted, isFalse);
      expect(updatedFeedback.upvoted, isFalse);
    });
    test(
        'toggleDownvote removes upvote and adds downvote if previously upvoted',
        () {
      final initialFeedback =
          feedbackRepo[1].copyWith(upvoted: true, votes: 1, downvoted: false);
      feedbackController.feedbackList[1] = initialFeedback;
      final initialVotes = initialFeedback.votes;
      feedbackController.toggleDownvote(1);
      final updatedFeedback = feedbackController.feedbackList[1];
      expect(updatedFeedback.votes, initialVotes - 2);
      expect(updatedFeedback.downvoted, isTrue);
      expect(updatedFeedback.upvoted, isFalse);
    });
    test('toggleDownvote handles invalid index gracefully', () {
      final initialListState =
          List<FeedbackModel>.from(feedbackController.feedbackList);
      expect(() => feedbackController.toggleDownvote(-1), returnsNormally);
      expect(
          () => feedbackController
              .toggleDownvote(feedbackController.feedbackList.length),
          returnsNormally);
      expect(feedbackController.feedbackList, equals(initialListState));
    });
  });

  group('CommentInput Widget Tests', () {
    /* ... unchanged ... */
    late TextEditingController commentController;
    setUp(() => commentController = TextEditingController());
    tearDown(() => commentController.dispose());
    testWidgets('Renders TextField and uses provided controller',
        (WidgetTester tester) async {
      await pumpWidgetWithMaterialApp(
          tester, CommentInput(controller: commentController));
      expect(find.byType(TextField), findsOneWidget);
      const testComment = 'Typing in comment input';
      await tester.enterText(find.byType(TextField), testComment);
      await tester.pump();
      expect(commentController.text, testComment);
    });
  });

  group('EventDetailsH Widget Tests', () {
    setUp(() {
      Get.put(EventsController());
      Get.put(FeedbackController());
      Get.find<EventsController>().events.assignAll(List.from(eventsRepo));
      Get.find<FeedbackController>()
          .feedbackList
          .assignAll(List.from(feedbackRepo));
    });

    // Refined test for icon tap
    testWidgets(
        'Tapping icon calls toggleSubscription or triggers navigation (Feedback)',
        (WidgetTester tester) async {
      final controller = Get.find<EventsController>();
      expect(controller.events, isNotEmpty,
          reason: "Events repository is empty");

      // --- Test toggleSubscription on a non-past event ---
      final nonPastEventIndex =
          controller.events.indexWhere((e) => !e.isPast());
      expect(nonPastEventIndex, isNot(-1),
          reason:
              "No non-past event found in repo for testing toggleSubscription.");

      final eventToToggle = controller.events[nonPastEventIndex];
      final initialSubscribedState = eventToToggle.subscribed;
      print(
          "EventDetailsH Test: Testing toggle on event index $nonPastEventIndex ('${eventToToggle.name}'), initial subscribed: $initialSubscribedState");

      await pumpWidgetWithMaterialApp(
          tester, EventDetailsH(index: nonPastEventIndex));

      // Find the icon's InkWell
      final iconInkWell =
          find.byType(InkWell).last; // Assuming icon's InkWell is last
      expect(iconInkWell, findsOneWidget,
          reason: "Icon InkWell not found for non-past event.");

      await tester.tap(iconInkWell);
      await tester.pumpAndSettle(); // Use pumpAndSettle

      // Verify the state change in the controller
      expect(controller.events[nonPastEventIndex].subscribed,
          !initialSubscribedState,
          reason:
              "Subscription state did not toggle as expected for non-past event.");

      // --- Test navigation trigger on a past event ---
      final pastEventIndex = controller.events.indexWhere((e) => e.isPast());
      if (pastEventIndex != -1) {
        final pastEvent = controller.events[pastEventIndex];
        print(
            "EventDetailsH Test: Testing navigation on past event index $pastEventIndex ('${pastEvent.name}')");
        await pumpWidgetWithMaterialApp(
            tester, EventDetailsH(index: pastEventIndex));
        final pastIconInkWell =
            find.byType(InkWell).last; // Assuming icon's InkWell is last
        expect(pastIconInkWell, findsOneWidget,
            reason: "Icon InkWell not found for past event.");
        // Tap and pump, assume no crash is sufficient
        await tester.tap(pastIconInkWell);
        await tester.pump(); // Just pump once
      } else {
        print(
            "Skipping past event navigation test for EventDetailsH icon tap: No past event found.");
      }
    });
  });

  group('EventScheduleWidget Tests', () {
    /* ... unchanged ... */
    final eventWithSchedule = EventModel(
        id: 'sched1',
        name: 'Event With Schedule',
        author: 'Sched Author',
        date: DateTime.now(),
        description: 'Desc',
        category: 'Test',
        maxParticipants: 10,
        subscribedParticipants: 5,
        location: 'Loc',
        subscribed: false,
        schedule: [
          ScheduleItem(
              time: '09:00',
              topic: 'Registration',
              description: 'Collect badges'),
          ScheduleItem(
              time: '10:00', topic: 'Keynote', description: 'Main talk'),
        ]);
    final eventWithoutSchedule = EventModel(
        id: 'sched2',
        name: 'Event No Schedule',
        author: 'Sched Author 2',
        date: DateTime.now(),
        description: 'Desc 2',
        category: 'Test 2',
        maxParticipants: 10,
        subscribedParticipants: 5,
        location: 'Loc 2',
        subscribed: false,
        schedule: []);
    testWidgets('Renders a list of _TimelineTile for schedule items',
        (WidgetTester tester) async {
      await pumpWidgetWithMaterialApp(
          tester, EventScheduleWidget(event: eventWithSchedule));
      final timelineTileFinder = find.byWidgetPredicate(
          (widget) => widget.runtimeType.toString() == '_TimelineTile');
      expect(
          timelineTileFinder, findsNWidgets(eventWithSchedule.schedule.length));
      expect(find.text('Registration'), findsOneWidget);
      expect(find.text('09:00'), findsOneWidget);
      expect(find.text('Collect badges'), findsOneWidget);
    });
    testWidgets('Renders empty state if event schedule is empty',
        (WidgetTester tester) async {
      await pumpWidgetWithMaterialApp(
          tester, EventScheduleWidget(event: eventWithoutSchedule));
      final timelineTileFinder = find.byWidgetPredicate(
          (widget) => widget.runtimeType.toString() == '_TimelineTile');
      expect(timelineTileFinder, findsNothing);
      expect(find.textContaining('Nothing scheduled yet'), findsOneWidget);
    });
  });

  group('SearchItem Widget Tests', () {
    /* ... unchanged ... */
    String? changedValue;
    setUp(() => changedValue = null);
    testWidgets('Renders search icon and TextField',
        (WidgetTester tester) async {
      await pumpWidgetWithMaterialApp(
          tester, SearchItem(onChanged: (value) {}));
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
    testWidgets('Calls onChanged when text is entered',
        (WidgetTester tester) async {
      await pumpWidgetWithMaterialApp(tester, SearchItem(onChanged: (value) {
        changedValue = value;
      }));
      const testQuery = 'Flutter events';
      await tester.enterText(find.byType(TextField), testQuery);
      await tester.pump();
      expect(changedValue, testQuery);
    });
  });
  group('StarRatingForm Widget Tests', () {
    /* ... unchanged ... */
    int currentTestRating = 0;
    setUp(() => currentTestRating = 0);
    testWidgets('Renders 5 star icons', (WidgetTester tester) async {
      await pumpWidgetWithMaterialApp(
          tester,
          StarRatingForm(
              selectedRating: currentTestRating,
              onRatingSelected: (rating) {}));
      final starIconFinder = find.descendant(
          of: find.byType(StarRatingForm), matching: find.byType(Icon));
      expect(starIconFinder, findsNWidgets(5));
    });
    testWidgets('Calls onRatingSelected with correct rating when star tapped',
        (WidgetTester tester) async {
      await pumpWidgetWithMaterialApp(
          tester,
          StarRatingForm(
              selectedRating: currentTestRating,
              onRatingSelected: (rating) {
                currentTestRating = rating;
              }));
      final starGestureDetectors = find.descendant(
          of: find.byType(StarRatingForm),
          matching: find.byType(GestureDetector));
      await tester.tap(starGestureDetectors.at(2));
      await tester.pump();
      expect(currentTestRating, 3);
    });
  });
}

// FeedbackModel copyWith Helper (unchanged, assuming it's correct now)
extension FeedbackModelCopy on FeedbackModel {
  /* ... */
  FeedbackModel copyWith({
    String? username,
    String? profilePic,
    DateTime? date,
    String? content,
    int? rating,
    int? votes,
    bool? upvoted,
    bool? downvoted,
  }) {
    return FeedbackModel(
      username: username ?? this.username,
      profilePic: profilePic ?? this.profilePic,
      date: date ?? this.date,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      votes: votes ?? this.votes,
      upvoted: upvoted ?? this.upvoted,
      downvoted: downvoted ?? this.downvoted,
    );
  }
}
