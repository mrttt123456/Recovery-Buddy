class Injury {
  final String name;
  final List<Stretch> stretches;

  Injury({
    required this.name,
    required this.stretches,
  });
}

class Stretch {
  final String name;
  final String youtubeLink;
  final String? imageUrl;

  Stretch({
    required this.name,
    required this.youtubeLink,
    this.imageUrl = null,
  });
}

class BodyPart {
  final String name;
  final List<Injury> injuries;

  BodyPart({
    required this.name,
    required this.injuries,
  });
}

List<BodyPart> bodyParts = [
  BodyPart(
    name: 'Leg',
    injuries: [
      Injury(
        name: 'Hamstring Strain',
        stretches: [
          Stretch(
              name: 'Hamstring Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=9eqe8fLGX6w'),
          Stretch(
              name: 'Quad Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=6t4XX3oXKzU'),
          Stretch(
              name: 'Calf Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=-M4-G8p8fmc'),
        ],
      ),
      Injury(
        name: 'Quadriceps Strain',
        stretches: [
          Stretch(
              name: 'Quad Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=6t4XX3oXKzU'),
          Stretch(
              name: 'Hamstring Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=9eqe8fLGX6w'),
          Stretch(
              name: 'Hip Flexor Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=example'),
        ],
      ),
      Injury(
        name: 'ACL Tear',
        stretches: [
          Stretch(
              name: 'Knee Flexion Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=1iODncOLJnk'),
          Stretch(
              name: 'Quad Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=6t4XX3oXKzU'),
          Stretch(
              name: 'Hamstring Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=9eqe8fLGX6w'),
        ],
      ),
    ],
  ),
  BodyPart(
    name: 'Shoulder',
    injuries: [
      Injury(
        name: 'Rotator Cuff Tear',
        stretches: [
          Stretch(
              name: 'Rotator Cuff Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=5-5Wp6WnU7o'),
          Stretch(
              name: 'Shoulder Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=eP9IY6zd2E8'),
          Stretch(
              name: 'Arm Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=example'),
        ],
      ),
      Injury(
        name: 'Shoulder Impingement',
        stretches: [
          Stretch(
              name: 'Shoulder Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=eP9IY6zd2E8'),
          Stretch(
              name: 'Rotator Cuff Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=5-5Wp6WnU7o'),
          Stretch(
              name: 'Neck Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=U9n6DfqKaiQ'),
        ],
      ),
      Injury(
        name: 'Frozen Shoulder',
        stretches: [
          Stretch(
              name: 'Wall Shoulder Flexion',
              imageUrl: 'assets/images/wall_shoulder_flexion.jpg',
              youtubeLink: 'https://www.youtube.com/watch?v=wbyhKCjrPSQ'),
          Stretch(
              name: 'Shoulder-Blade Squeeze',
              imageUrl: 'assets/images/wall_shoulder_squeeze.png',
              youtubeLink: 'https://www.youtube.com/watch?v=k65bXhZLQ_g'),
          Stretch(
              name: 'Rotator Cuff Stretch',
              imageUrl: 'assets/images/rotator_cuff.jpg',
              youtubeLink: 'https://www.youtube.com/watch?v=luoiGpT4PJ8'),
        ],
      ),
    ],
  ),
  BodyPart(
    name: 'Back',
    injuries: [
      Injury(
        name: 'Lower Back Strain',
        stretches: [
          Stretch(
              name: 'Lower Back Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=example'),
          Stretch(
              name: 'Hip Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=NG9qbvAN3gQ'),
          Stretch(
              name: 'Hamstring Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=9eqe8fLGX6w'),
        ],
      ),
      Injury(
        name: 'Sciatica',
        stretches: [
          Stretch(
              name: 'Sciatic Nerve Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=5oQmO9lqTUs'),
          Stretch(
              name: 'Lower Back Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=example'),
          Stretch(
              name: 'Hip Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=NG9qbvAN3gQ'),
        ],
      ),
      Injury(
        name: 'Herniated Disc',
        stretches: [
          Stretch(
              name: 'Spinal Decompression Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=ClvBB1R5OIQ'),
          Stretch(
              name: 'Lower Back Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=example'),
          Stretch(
              name: 'Hip Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=NG9qbvAN3gQ'),
        ],
      ),
    ],
  ),
  BodyPart(
    name: 'Neck',
    injuries: [
      Injury(
        name: 'Neck Strain',
        stretches: [
          Stretch(
              name: 'Neck Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=U9n6DfqKaiQ'),
          Stretch(
              name: 'Shoulder Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=eP9IY6zd2E8'),
          Stretch(
              name: 'Upper Back Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=Qt2WsKahs1Q'),
        ],
      ),
      Injury(
        name: 'Whiplash',
        stretches: [
          Stretch(
              name: 'Neck Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=U9n6DfqKaiQ'),
          Stretch(
              name: 'Shoulder Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=eP9IY6zd2E8'),
          Stretch(
              name: 'Upper Back Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=Qt2WsKahs1Q'),
        ],
      ),
      Injury(
        name: 'Cervical Radiculopathy',
        stretches: [
          Stretch(
              name: 'Neck Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=U9n6DfqKaiQ'),
          Stretch(
              name: 'Shoulder Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=eP9IY6zd2E8'),
          Stretch(
              name: 'Upper Back Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=Qt2WsKahs1Q'),
        ],
      ),
    ],
  ),
  BodyPart(
    name: 'Wrist',
    injuries: [
      Injury(
        name: 'Carpal Tunnel Syndrome',
        stretches: [
          Stretch(
              name: 'Wrist Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=KLh83c6ul2s'),
          Stretch(
              name: 'Finger Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=tsEf8V2PywA'),
          Stretch(
              name: 'Forearm Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=OT-1mQSE3lw'),
        ],
      ),
      Injury(
        name: 'Wrist Strain',
        stretches: [
          Stretch(
              name: 'Wrist Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=KLh83c6ul2s'),
          Stretch(
              name: 'Finger Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=tsEf8V2PywA'),
          Stretch(
              name: 'Forearm Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=OT-1mQSE3lw'),
        ],
      ),
      Injury(
        name: 'Tendonitis',
        stretches: [
          Stretch(
              name: 'Wrist Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=KLh83c6ul2s'),
          Stretch(
              name: 'Finger Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=tsEf8V2PywA'),
          Stretch(
              name: 'Forearm Stretch',
              youtubeLink: 'https://www.youtube.com/watch?v=OT-1mQSE3lw'),
        ],
      ),
    ],
  ),
];


/*class Stretch {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String muscleGroup;
  final String difficulty;
  final String time;
  final List<String> instructions;
  final String youtubeLink; // New property

  Stretch({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.muscleGroup,
    required this.difficulty,
    required this.time,
    required this.instructions,
    required this.youtubeLink, // New property
  });
}

List<Stretch> stretches = [
  Stretch(
    id: '1',
    name: 'Bending Hamstring Stretch',
    imageUrl: 'assets/images/basic_hamstring_stretch.jpg',
    description: 'A basic hamstring stretch',
    muscleGroup: 'Hamstrings',
    difficulty: 'Easy',
    time: 'Reps: Hold 1 minute; Sets: 4',
    instructions: [
      'Stand up straight',
      'Bend forward at the waist',
    ],
    youtubeLink: 'https://www.youtube.com/watch?v=R1d6DkZrjGM', // New property
  ),
  Stretch(
    id: '2',
    name: 'Balancing Quad Stretch',
    imageUrl: 'assets/images/balancing_quad_stretch.jpg',
    description: 'A basic quad stretch',
    muscleGroup: 'Quadriceps',
    difficulty: 'Easy',
    time: 'Reps: Hold 30 secs per leg; Sets: 3',
    instructions: [
      'Stand up straight',
      'Pull one foot behind you with the same arm',
      'Hold and feel the stretch in your Quad',
    ],
    youtubeLink: 'https://www.youtube.com/watch?v=K4t9Xw1Ueok', // New property
  ),
  Stretch(
    id: '3',
    name: "Wall Chest Stretch",
    imageUrl: 'assets/images/basic_hamstring_stretch.jpg',
    description: "Stretches the pectoral muscles and helps improve posture.",
    muscleGroup: "Chest",
    difficulty: "Medium",
    time: 'Reps: 30 secs per arm; Sets: 3',
    instructions: [
      'Stand upright',
      'Find a wall',
      'Place one of your forearms and hand on the wall',
      'Have a 90 degree angle of your elbow',
      'Pull your chest away from the wall and feel the pull on your chest',
    ],
    youtubeLink: 'https://www.youtube.com/watch?v=PL6P8CzunHo', // New property
  ),
  Stretch(
    id: '4',
    name: "90-90 stretch",
    imageUrl: 'assets/images/basic_hamstring_stretch.jpg',
    description: "Stretches the pectoral muscles and helps improve posture.",
    muscleGroup: "Glutes|Hip Flexors",
    difficulty: "Hard",
    time: 'Reps: 3 minutes per leg; Sets: 1',
    instructions: [
      'Sit down',
      'Place both of your legs on a 90 degree hold on the floor',
      'Try to get both of your bottocks on the ground for an enhanced stretch',
      'Hold, but if there is sharp pain, stop stretching',
    ],
    youtubeLink: 'https://www.youtube.com/watch?v=rb8t2kQF-EM', // New property
  ),
  Stretch(
    id: '5',
    name: "Triceps Stretch",
    imageUrl: 'assets/images/basic_hamstring_stretch.jpg',
    description: "Targets the back of your upper arm.",
    muscleGroup: "Arm",
    difficulty: "Easy",
    time: 'Reps: 5 seconds each arm; Sets: 10',
    instructions: [
      'Raise one arm above your head and bend at the elbow',
      'Gently pat yourself on the back. Use your other hand to increase the stretch.',
    ],
    youtubeLink: 'https://www.youtube.com/watch?v=sHkMz55SDHM', // New property
  ),
  Stretch(
    id: '6',
    name: "Floor Twist",
    imageUrl: 'assets/images/basic_hamstring_stretch.jpg',
    description: "Targets the back of your upper arm.",
    muscleGroup: "Arm",
    difficulty: "Easy",
    time: 'Reps: 5 seconds each arm; Sets: 10',
    instructions: [
      'Raise one arm above your head and bend at the elbow',
      'Gently pat yourself on the back. Use your other hand to increase the stretch.',
    ],
    youtubeLink: 'https://www.youtube.com/watch?v=uHTTO0uPW1E', // New property
  ),
];
*/