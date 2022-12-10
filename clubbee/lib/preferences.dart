import 'package:clubbee/models/event.dart';

import 'models/user.dart';

class UserPreferences {
  static final User myUser = User(
    id: 1,
    username: "haso",
    photoUrl:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    fullName: 'Ayşe',
    studentNumber: 150200100,
    email: 'yilmaz20@itu.edu.tr',
  );

  static Event demoEvent = Event(
      id: 1,
      name: "algoComp",
      description:
          "Merhabalar, ben ITU ACM öğrenci kulübü başkanı Hasan. Sizi yaklaşık 300 kişinin katılacağı Roadmap etkinliğimize davet etmek istiyoruz. Hem Teknasyon'u temsil etmek için hem de İTÜ öğrencilerine yol göstermek için bizimle birlikte olmanızı isteriz. Detayları iletmek için cevabınızı bekliyorum. iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
      dateTime: DateTime.now(),
      eventStatus: EventStatus.active,
      highlighted: true);
}
