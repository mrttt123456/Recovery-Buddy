import 'package:flutter_test/flutter_test.dart';
import 'package:RecoveryBuddy/models/stretch.dart';
import 'package:RecoveryBuddy/models/user.dart';

void main() {
  group('Stretch Model', () {
    test('should create a Stretch instance with expected values', () {
      final stretch = Stretch(
        id: '1',
        name: 'Hamstring Stretch',
        imageUrl: 'https://example.com/hamstring-stretch.jpg',
        description: 'A basic hamstring stretch',
        muscleGroup: 'Hamstrings',
        difficulty: 'Easy',
        time: 'Reps: NA; Sets: NA',
        instructions: ['Stand up straight', 'Bend forward at the waist'],
      );

      expect(stretch.id, '1');
      expect(stretch.name, 'Hamstring Stretch');
      expect(stretch.imageUrl, 'https://example.com/hamstring-stretch.jpg');
      expect(stretch.description, 'A basic hamstring stretch');
      expect(stretch.muscleGroup, 'Hamstrings');
      expect(stretch.difficulty, 'Easy');
      expect(stretch.instructions,
          ['Stand up straight', 'Bend forward at the waist']);
    });
  });

  group('User Model', () {
    test('should create a User instance with expected values', () {
      final user = User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        avatarUrl: 'https://example.com/john-doe.jpg',
        totalStretchPoints: 42,
      );

      expect(user.id, '1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john.doe@example.com');
      expect(user.avatarUrl, 'https://example.com/john-doe.jpg');
      expect(user.totalStretchPoints, 42);
    });
  });
}
