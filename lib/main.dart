
import 'package:flutter/material.dart';

void main() => runApp(const MOHApp());

const bg = Color(0xFF101318);
const panel = Color(0xFF1D232B);
const accent = Color(0xFFE5A13A);

class MOHApp extends StatelessWidget {
  const MOHApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOH Heroes 2',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

void notify(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY GAME LAUNCHER'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingsPage(),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF34302A), panel, bg],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: accent.withValues(alpha: .5)),
            ),
            child: const Column(
              children: [
                Icon(Icons.military_tech, size: 90, color: accent),
                SizedBox(height: 12),
                Text(
                  'MEDAL OF HONOR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'HEROES 2',
                  style: TextStyle(
                    color: accent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                SizedBox(height: 12),
                Text('WORLD WAR II • ACTION • PSP'),
              ],
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 58,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.black,
              ),
              icon: const Icon(Icons.play_arrow, size: 30),
              label: const Text(
                'PLAY GAME',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GamePage(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          MenuButton(
            icon: Icons.flag,
            label: 'MISSIONS',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MissionsPage(),
              ),
            ),
          ),
          MenuButton(
            icon: Icons.folder_open,
            label: 'GAME FILES',
            onTap: () => showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('GAME FILES'),
                content: const Text(
                  'دي نسخة تجريبية من الواجهة. '
                  'اختيار ملفات ISO غير مضاف في النسخة دي.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
          MenuButton(
            icon: Icons.settings,
            label: 'SETTINGS',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingsPage(),
              ),
            ),
          ),
          MenuButton(
            icon: Icons.info_outline,
            label: 'ABOUT',
            onTap: () => showAboutDialog(
              context: context,
              applicationName: 'MOH Heroes 2 Launcher',
              applicationVersion: '1.0.0',
              children: const [
                Text(
                  'واجهة تجريبية شخصية لنظام Android. '
                  'لا تحتوي على اللعبة الأصلية أو محاكي PSP.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'PERSONAL GAME LAUNCHER',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38, letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: accent),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          side: const BorderSide(color: Colors.white24),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int health = 100;
  int ammo = 30;
  int score = 0;
  String status = 'MISSION READY';
  bool paused = false;

  void action(String name) {
    if (paused) {
      notify(context, 'استأنف المهمة أولاً');
      return;
    }

    setState(() {
      if (name == 'SHOOT') {
        if (ammo > 0) {
          ammo--;
          score += 10;
          status = 'TARGET ENGAGED';
        } else {
          status = 'OUT OF AMMO';
        }
      } else if (name == 'RELOAD') {
        ammo = 30;
        status = 'WEAPON RELOADED';
      } else if (name == 'HEAL') {
        health = (health + 20).clamp(0, 100);
        status = 'HEALTH RESTORED';
      } else if (name == 'MOVE') {
        score += 5;
        status = 'SOLDIER MOVED';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MISSION: TRAINING'),
        actions: [
          IconButton(
            tooltip: 'Pause',
            icon: Icon(paused ? Icons.play_arrow : Icons.pause),
            onPressed: () => setState(() {
              paused = !paused;
              status = paused ? 'MISSION PAUSED' : 'MISSION RESUMED';
            }),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 205,
            decoration: BoxDecoration(
              color: panel,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: accent.withValues(alpha: .5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  paused ? Icons.pause_circle : Icons.shield,
                  size: 65,
                  color: accent,
                ),
                const SizedBox(height: 12),
                Text(
                  paused ? 'GAME PAUSED' : 'TRAINING SIMULATOR',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(status, style: const TextStyle(color: accent)),
                const SizedBox(height: 8),
                const Text(
                  'DEMO MODE • NO PSP EMULATOR',
                  style: TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              StatCard(label: 'HEALTH', value: '$health%', icon: Icons.favorite),
              const SizedBox(width: 8),
              StatCard(label: 'AMMO', value: '$ammo', icon: Icons.gps_fixed),
              const SizedBox(width: 8),
              StatCard(label: 'SCORE', value: '$score', icon: Icons.star),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'MOVEMENT',
            style: TextStyle(color: accent, letterSpacing: 2),
          ),
          const SizedBox(height: 10),
          Center(
            child: FilledButton(
              onPressed: () => action('MOVE'),
              child: const Icon(Icons.keyboard_arrow_up, size: 32),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () => action('MOVE'),
                child: const Icon(Icons.keyboard_arrow_left, size: 30),
              ),
              const SizedBox(width: 14),
              FilledButton(
                onPressed: () => action('MOVE'),
                child: const Icon(Icons.keyboard_arrow_down, size: 30),
              ),
              const SizedBox(width: 14),
              FilledButton(
                onPressed: () => action('MOVE'),
                child: const Icon(Icons.keyboard_arrow_right, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'ACTIONS',
            style: TextStyle(color: accent, letterSpacing: 2),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => action('SHOOT'),
                  icon: const Icon(Icons.gps_fixed),
                  label: const Text('SHOOT'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red.shade900,
                    minimumSize: const Size.fromHeight(52),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => action('RELOAD'),
                  icon: const Icon(Icons.refresh),
                  label: const Text('RELOAD'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => action('HEAL'),
            icon: const Icon(Icons.health_and_safety),
            label: const Text('RESTORE HEALTH'),
          ),
          OutlinedButton.icon(
            onPressed: () => setState(() {
              health = 100;
              ammo = 30;
              score = 0;
              paused = false;
              status = 'MISSION RESET';
            }),
            icon: const Icon(Icons.restart_alt),
            label: const Text('RESTART MISSION'),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
        decoration: BoxDecoration(
          color: panel,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: accent, size: 22),
            const SizedBox(height: 7),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class MissionsPage extends StatelessWidget {
  const MissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final missions = [
      ('01', 'TRAINING CAMP', 'Learn the controls'),
      ('02', 'OPERATION STORM', 'Combat simulation'),
      ('03', 'FINAL ASSAULT', 'Complete the challenge'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('MISSIONS')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: missions.length,
        itemBuilder: (context, i) {
          final m = missions[i];
          return Card(
            color: panel,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: accent,
                foregroundColor: Colors.black,
                child: Text(m.$1),
              ),
              title: Text(m.$2),
              subtitle: Text(m.$3),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GamePage(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool sound = true;
  bool vibration = true;
  bool tips = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SETTINGS')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.volume_up, color: accent),
            title: const Text('Sound effects'),
            value: sound,
            onChanged: (v) => setState(() => sound = v),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.vibration, color: accent),
            title: const Text('Vibration'),
            value: vibration,
            onChanged: (v) => setState(() => vibration = v),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.lightbulb_outline, color: accent),
            title: const Text('Gameplay tips'),
            value: tips,
            onChanged: (v) => setState(() => tips = v),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: accent),
            title: const Text('App version'),
            subtitle: const Text('1.0.0 • Demo launcher'),
          ),
          ListTile(
            leading: const Icon(Icons.restore, color: accent),
            title: const Text('Reset settings'),
            onTap: () => setState(() {
              sound = true;
              vibration = true;
              tips = true;
            }),
          ),
        ],
      ),
    );
  }
}
