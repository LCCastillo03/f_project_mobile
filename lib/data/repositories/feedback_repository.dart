import 'package:project/domain/models/feedback_model.dart';

List<FeedbackModel> feedbackRepo = [
  {
    'username': 'Alice Johnson',
    'profilePic': 'assets/images/avatars/avatar-0.jpg',
    'date': '2025-03-27T19:07:00.000Z',
    'content':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis hendrerit sodales. Etiam malesuada, ex ac viverra volutpat, enim magna consectetur lacus, sed fringilla arcu nisi non ipsum. Nunc egestas, ligula ac auctor facilisis, lacus erat iaculis purus, at blandit nibh nunc sit amet nisl. Quisque eget turpis tincidunt, iaculis lorem in, blandit ligula. Duis interdum tempus est, sit amet dictum urna egestas nec. Pellentesque sit amet enim neque. Aenean porttitor enim quis tellus aliquam aliquam. Duis augue est, cursus ac lorem quis, blandit tincidunt lacus. Quisque varius metus quis nulla tincidunt, vel eleifend magna scelerisque. Ut eu sodales nulla. Aenean convallis dapibus metus a efficitur.',
    'rating': 5,
    'votes': 12,
  },
  {
    'username': 'Bob Smith',
    'profilePic': 'assets/images/avatars/avatar-1.jpg',
    'date': '2025-03-27T16:07:00.000Z',
    'content':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis hendrerit sodales.',
    'rating': 3,
    'votes': -2,
  },
  {
    'username': 'Charlie Lee',
    'profilePic': 'assets/images/avatars/avatar-2.jpg',
    'date': '2025-03-26T21:07:00.000Z',
    'content':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis hendrerit sodales. Etiam malesuada, ex ac viverra volutpat, enim magna consectetur lacus, sed fringilla arcu nisi non ipsum. Nunc egestas, ligula ac auctor facilisis, lacus erat iaculis purus, at blandit nibh nunc sit amet nisl. Quisque eget turpis tincidunt, iaculis lorem in, blandit ligula. Duis interdum tempus est, sit amet dictum urna egestas nec. Pellentesque sit amet enim neque. Aenean porttitor enim quis tellus aliquam aliquam. Duis augue est, cursus ac lorem quis, blandit tincidunt lacus.',
    'rating': 4,
    'votes': 8,
  },
  {
    'username': 'Diana Morales',
    'profilePic': 'assets/images/avatars/avatar-3.jpg',
    'date': '2023-11-15T10:15:00.000Z',
    'content':
        'Vivamus at lorem et est aliquet tincidunt. Suspendisse potenti. Nulla facilisi. In bibendum augue vel nulla pharetra, quis viverra leo hendrerit. Phasellus malesuada, turpis ut sagittis bibendum, lorem sapien blandit ipsum, ut sodales neque turpis et nulla. Nullam tincidunt, magna eget cursus ultrices, arcu nulla laoreet lectus, sit amet tristique ligula orci sit amet lacus.',
    'rating': 5,
    'votes': 22,
  },
  {
    'username': 'Ethan Brown',
    'profilePic': 'assets/images/avatars/avatar-4.jpg',
    'date': '2024-07-22T15:30:00.000Z',
    'content':
        'Proin placerat, mi sit amet molestie vehicula, erat nisi egestas eros, vitae mattis risus nunc sit amet libero. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nulla ac dui non est commodo feugiat. Aliquam erat volutpat. Suspendisse ultricies velit a velit vestibulum, vel tempor arcu pharetra.',
    'rating': 3,
    'votes': 5,
  },
  {
    'username': 'Sophia Garcia',
    'profilePic': 'assets/images/avatars/avatar-5.jpg',
    'date': '2021-06-10T19:45:00.000Z',
    'content':
        'Phasellus sed ante gravida, varius sapien vel, porttitor neque. Sed condimentum dictum libero, vel tristique ligula faucibus vel. Quisque in malesuada sapien. Fusce id arcu eu purus posuere dictum at et eros. Integer ut convallis risus. Cras sed purus magna. Nam vulputate vel lacus sit amet varius.',
    'rating': 2,
    'votes': -3,
  },
  {
    'username': 'Mia Adams',
    'profilePic': 'assets/images/avatars/avatar-0.jpg',
    'date': '2025-03-27T22:00:00.000Z',
    'content':
        'Sed quis metus vitae neque mollis venenatis. Fusce placerat interdum feugiat. Ut elementum libero et consequat auctor. Ut a nisl velit. Suspendisse potenti. Vestibulum lobortis sem sed lectus feugiat, quis pharetra libero facilisis. Aliquam eu nulla neque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae.',
    'rating': 4,
    'votes': 10,
  },
  {
    'username': 'Noah Smith',
    'profilePic': 'assets/images/avatars/avatar-1.jpg',
    'date': '2020-01-14T08:20:00.000Z',
    'content':
        'Mauris sodales risus vitae varius pellentesque. Donec ut felis sit amet turpis efficitur aliquet sed ut ligula. Nullam cursus nisl ut sagittis scelerisque. Etiam viverra, sapien ac tempus laoreet, libero nulla pretium erat, vel varius ligula mauris eu magna. Donec posuere mauris a ex efficitur, eu ultricies metus sollicitudin.',
    'rating': 5,
    'votes': 15,
  },
].map((item) => FeedbackModel.fromJson(item)).toList();
