import 'package:study_bible/data/user_store.dart';
import 'package:uuid/uuid.dart';

void main() async {
  final userStore = UserStore();
  
  final entry = NavigationHistory(
    id: const Uuid().v4(),
    updatedAt: DateTime.now().millisecondsSinceEpoch,
    deviceId: 'test',
    deleted: false,
    bookName: 'Genesis',
    chapter: 1,
    verse: 5,
    verseText: 'And God called the light Day...',
  );
  
  await userStore.into(userStore.navigationHistories).insert(entry);
  
  final entries = await userStore.select(userStore.navigationHistories).get();
  for (var e in entries) {
    print('DB Entry: book=${e.bookName}, chapter=${e.chapter}, verse=${e.verse}, text=${e.verseText}');
  }
}
