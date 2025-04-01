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
    'subscribed': true,
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
    'subscribed': true,
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
  },
  {
    'id': '6',
    'name': 'Startup Incubation Bootcamp',
    'author': 'Maria Espinosa',
    'date': '2025-07-10T09:30:00.000Z',
    'description':
        'An intensive bootcamp for aspiring entrepreneurs looking to validate and grow their startup ideas. Sessions will include mentorship, investor networking, and practical strategies to scale businesses in competitive markets.',
    'category': 'Business',
    'maxParticipants': 50,
    'subscribedParticipants': 20,
    'location': 'Barranquilla Coworking Hub',
    'avgRating': 4.1,
    'subscribed': true,
  },
  {
    'id': '7',
    'name': 'Cybersecurity Trends Conference',
    'author': 'Juan Camilo López',
    'date': '2025-11-05T13:00:00.000Z',
    'description':
        'Dive into the latest cybersecurity threats and defense strategies. Industry leaders will discuss emerging risks such as AI-driven cyber attacks, data protection regulations, and best practices for securing digital infrastructure.',
    'category': 'Education',
    'maxParticipants': 200,
    'subscribedParticipants': 130,
    'location': 'Hotel Dann Carlton, Barranquilla',
    'avgRating': 4.7,
  },
  {
    'id': '8',
    'name': 'Sustainable Urban Development Forum',
    'author': 'Gabriela Moreno',
    'date': '2025-09-12T15:00:00.000Z',
    'description':
        'A discussion on the future of urban planning, smart cities, and sustainable infrastructure. Experts will cover topics like renewable energy integration, green architecture, and strategies for reducing environmental impact in growing cities.',
    'category': 'Science',
    'maxParticipants': 100,
    'subscribedParticipants': 60,
    'location': 'Universidad del Atlántico',
    'avgRating': 3.8,
  },
  {
    'id': '9',
    'name': 'Neuroscience & Mental Health Summit',
    'author': 'Dr. Patricia Vélez',
    'date': '2025-06-18T10:00:00.000Z',
    'description':
        'An in-depth exploration of neuroscience research, mental health advancements, and cognitive wellness. This event will feature expert panels on the intersection between brain health, psychology, and technological innovations in therapy.',
    'category': 'Science',
    'maxParticipants': 120,
    'subscribedParticipants': 85,
    'location': 'Centro de Convenciones, Barranquilla',
    'avgRating': 4.4,
    'subscribed': true,
  },
  {
    'id': '10',
    'name': 'Telemedicine & Digital Health Summit',
    'author': 'Dr. Ricardo Zambrano',
    'date': '2024-09-25T14:00:00.000Z',
    'description':
        'Discover the latest advancements in telemedicine and digital healthcare. Experts will discuss how technology is reshaping patient care, remote diagnostics, and AI-driven health solutions to improve accessibility and efficiency in healthcare services.',
    'category': 'Healthcare',
    'maxParticipants': 120,
    'subscribedParticipants': 80,
    'location': 'Hospital Universitario, Barranquilla',
    'avgRating': 4.6,
  },
  {
    'id': '11',
    'name': 'Future of Online Learning Conference',
    'author': 'Dr. Valeria Gómez',
    'date': '2025-07-15T10:30:00.000Z',
    'description':
        'This conference will explore the transformation of education through online platforms, adaptive learning, and AI-driven teaching methods. Engage with educators and technologists to discuss strategies for making education more inclusive and accessible worldwide.',
    'category': 'Education',
    'maxParticipants': 200,
    'subscribedParticipants': 150,
    'location': 'Centro Educativo Digital, Barranquilla',
    'avgRating': 4.3,
  },
  {
    'id': '12',
    'name': 'Entrepreneurship & Innovation Expo',
    'author': 'Carlos Restrepo',
    'date': '2025-08-20T13:00:00.000Z',
    'description':
        'An interactive expo bringing together startups, investors, and business leaders to showcase the latest innovations in various industries. Participants will gain insights into market trends, networking opportunities, and investment strategies for launching successful businesses.',
    'category': 'Business',
    'maxParticipants': 250,
    'subscribedParticipants': 180,
    'location': 'Barranquilla Business Center',
    'avgRating': 4.5,
  },
  {
    'id': '13',
    'name': 'Mental Health & Wellness Workshop',
    'author': 'Dr. Andrea Pardo',
    'date': '2024-06-10T09:00:00.000Z',
    'description':
        'A workshop designed to promote mental health awareness and stress management techniques. Learn practical approaches to mindfulness, resilience, and psychological well-being from expert therapists and mental health professionals.',
    'category': 'Healthcare',
    'maxParticipants': 80,
    'subscribedParticipants': 45,
    'location': 'Centro de Bienestar Integral, Barranquilla',
    'avgRating': 4.0,
    'subscribed': true,
  },
  {
    'id': '14',
    'name': 'Leadership & Business Strategy Summit',
    'author': 'Sergio Vargas',
    'date': '2025-11-05T16:00:00.000Z',
    'description':
        'A high-impact event for business professionals and executives looking to sharpen their leadership skills and strategic thinking. This summit will cover corporate management techniques, decision-making frameworks, and business growth strategies in competitive industries.',
    'category': 'Business',
    'maxParticipants': 300,
    'subscribedParticipants': 220,
    'location': 'Hotel Majestic, Barranquilla',
    'avgRating': 4.7,
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
