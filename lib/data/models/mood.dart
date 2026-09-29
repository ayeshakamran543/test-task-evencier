/// Moods placed around the mood wheel.
///
/// [centerDegrees] is measured clockwise from 12 o'clock.
enum Mood {
  calm('Calm', 60),
  content('Content', 150),
  peaceful('Peaceful', 240),
  happy('Happy', 330);

  const Mood(this.label, this.centerDegrees);

  final String label;
  final double centerDegrees;

  /// The mood whose segment is closest to [degrees].
  static Mood fromDegrees(double degrees) {
    final angle = degrees % 360;
    var best = Mood.calm;
    var bestDistance = double.infinity;
    for (final mood in Mood.values) {
      var distance = (angle - mood.centerDegrees).abs();
      if (distance > 180) distance = 360 - distance;
      if (distance < bestDistance) {
        best = mood;
        bestDistance = distance;
      }
    }
    return best;
  }

  Mood get next => Mood.values[(index + 1) % Mood.values.length];

  Mood get previous =>
      Mood.values[(index - 1 + Mood.values.length) % Mood.values.length];
}
