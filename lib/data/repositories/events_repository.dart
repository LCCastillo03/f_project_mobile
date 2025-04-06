/*
import 'package:project/domain/models/feedback_model.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  @override
  Future<void> submitFeedback(FeedbackModel feedback) {
    // Logic to send feedback to the server or database.
  }
}
*/
import 'package:project/domain/models/event_model.dart';
import 'package:project/domain/repositories/i_event_repository.dart';

List<EventModel> eventsRepo = [
  {
    'id': '1',
    'name': 'Fintech Revolution',
    'author': 'Augusto Salazar',
    'date': '2024-06-12T12:00:00.000Z',
    'description':
        'Dive deep into the transformative world of finance and technology. This event will explore cutting-edge innovations like blockchain, artificial intelligence, and the rise of fintech startups. Attendees will also gain insights into the changing landscape of digital payments, financial inclusion, and disruptive investment technologies reshaping global markets.',
    'category': 'Business',
    'maxParticipants': 20,
    'subscribedParticipants': 2,
    'location': 'Universidad del Norte',
    'avgRating': 4.3,
    'schedule': [
      {
        'time': '09:00 AM',
        'topic': 'Introduction to the fintech world',
        'description': 'Brief introduction to fintech trends.'
      },
      {
        'time': '10:30 AM',
        'topic': 'Blockchain in finance',
        'description':
            'How blockchain is applied to the current financial system.'
      },
      {
        'time': '12:00 PM',
        'topic': 'Fintechs in Latin America',
        'description': 'Success cases in the region and current challenges.'
      }
    ]
  },
  {
    'id': '2',
    'name': 'Global Health Forum',
    'author': 'Dr. Carolina Mendoza',
    'date': '2024-07-20T10:30:00.000Z',
    'description':
        'This forum invites medical professionals, researchers, and policymakers to address today’s most pressing global health challenges. Topics will include breakthroughs in medicine, combating infectious diseases, enhancing healthcare accessibility, and fostering international collaboration to build resilient healthcare systems worldwide.',
    'category': 'Science',
    'maxParticipants': 100,
    'subscribedParticipants': 50,
    'location': 'Centro Médico Internacional, Barranquilla',
    'avgRating': 3.9,
  },
  {
    'id': '3',
    'name': 'Engineering the Future',
    'author': 'Enrique Ramos',
    'date': '2024-05-15T18:00:00.000Z',
    'description':
        'Join an inspiring session dedicated to innovation in science and engineering. This event will cover revolutionary technologies aimed at promoting sustainable development, with special highlights on renewable energy, cutting-edge robotics, and the role of engineering in tackling climate change. Engage with hands-on demonstrations and expert panels discussing the future of our planet.',
    'category': 'Science',
    'maxParticipants': 30,
    'subscribedParticipants': 15,
    'location': 'Universidad del Atlántico',
    'avgRating': 3.5,
  },
  {
    'id': '4',
    'name': 'Mindful Living Workshop',
    'author': 'Sofia Castro',
    'date': '2025-04-30T09:00:00.000Z',
    'description':
        'This transformative workshop will introduce attendees to the art of mindfulness, providing practical techniques for stress reduction, emotional balance, and personal growth.',
    'category': 'Personal Growth',
    'maxParticipants': 50,
    'subscribedParticipants': 35,
    'location': 'Yoga Studio Barranquilla',
    'avgRating': 0,
  },
  {
    'id': '5',
    'name': 'Innovative Education Summit',
    'author': 'Laura Rodríguez',
    'date': '2025-08-05T14:00:00.000Z',
    'description':
        'This summit brings together educators, technologists, and policy experts to reimagine the future of learning. Discuss innovative teaching methods, the integration of technology in education, and strategies to foster creativity and critical thinking in students. Participants will explore how to bridge gaps in education accessibility and create systems that empower learners of all ages.',
    'category': 'Education',
    'maxParticipants': 200,
    'subscribedParticipants': 150,
    'location': 'Plaza de la Paz, Barranquilla',
    'avgRating': 0,
  }
].map((e) => EventModel.fromJson(e)).toList()
  ..sort((a, b) => b.date.compareTo(a.date));

///
/*
class PastEventRepository implements IEventRepository {
  @override
  List getEvents() {
    return eventsRepo.where((event) => event.isPast()).toList();
  }
}

class FutureEventRepository implements IEventRepository {
  @override
  List getEvents() {
    return eventsRepo.where((event) => !event.isPast()).toList();
  }
}

class FullRepository implements IEventRepository {
  @override
  List getEvents() {
    return eventsRepo;
  }
}
*/
