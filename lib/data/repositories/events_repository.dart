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

final now = '2025';

List<EventModel> eventsRepo = [
  {
    'name': 'Fintech Revolution',
    'author': 'Augusto Salazar',
    'date': '2024-06-12T12:00:00.000Z',
    'description':
        'Exploring the latest innovations in finance and technology, including blockchain, AI, and fintech startups.',
    'category': 'Business',
    'maxParticipants': 20,
    'subscribedParticipants': 2,
    'location': 'Universidad del Norte',
    'avgRating': 4.3,
  },
  {
    'name': 'Global Health Forum',
    'author': 'Dr. Carolina Mendoza',
    'date': '2024-07-20T10:30:00.000Z',
    'description':
        'A discussion on global health challenges, advancements in medicine, and collaborative healthcare solutions.',
    'category': 'Science',
    'maxParticipants': 100,
    'subscribedParticipants': 50,
    'location': 'Centro Médico Internacional, Barranquilla',
    'avgRating': 3.9,
  },
  {
    'name': 'Engineering the Future',
    'author': 'Enrique Ramos',
    'date': '2024-05-15T18:00:00.000Z',
    'description':
        'An interactive session showcasing groundbreaking innovations in science and engineering for sustainable development.',
    'category': 'Science',
    'maxParticipants': 30,
    'subscribedParticipants': 15,
    'location': 'Universidad del Atlántico',
    'avgRating': 3.5,
  },
  {
    'name': 'Mindful Living Workshop',
    'author': 'Sofia Castro',
    'date': '2025-04-30T09:00:00.000Z',
    'description':
        'Learn practical mindfulness techniques for personal growth, stress reduction, and a balanced life.',
    'category': 'Personal Growth',
    'maxParticipants': 50,
    'subscribedParticipants': 35,
    'location': 'Yoga Studio Barranquilla',
    'avgRating': 0,
  },
  {
    'name': 'Innovative Education Summit',
    'author': 'Laura Rodríguez',
    'date': '2025-08-05T14:00:00.000Z',
    'description':
        'Join educators and thought leaders to discuss the future of learning, including technology in education.',
    'category': 'Education',
    'maxParticipants': 200,
    'subscribedParticipants': 150,
    'location': 'Plaza de la Paz, Barranquilla',
    'avgRating': 0,
  }
].map((e) => EventModel.fromJson(e)).toList()
  ..sort((a, b) => b.date.compareTo(a.date));
