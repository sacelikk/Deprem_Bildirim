import 'package:flutter/material.dart';

class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({super.key});

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  bool bildirimAcik = true;
  bool titresim = true;
  double minMagnitud = 3.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _Header(title: "Deprem Uyarı Ayarları"),

        _Section(
          icon: Icons.notifications_active_outlined,
          title: "Bildirimler",
          children: [
            _SwitchTile(
              title: "Deprem Bildirimleri",
              subtitle: "Büyük depremler için anlık uyarı",
              value: bildirimAcik,
              onChanged: (v) => setState(() => bildirimAcik = v),
            ),
            _SwitchTile(
              title: "Titreşim",
              subtitle: "Uyarılarda titreşim kullan",
              value: titresim,
              onChanged: (v) => setState(() => titresim = v),
            ),
          ],
        ),

        _Section(
          icon: Icons.tune_outlined,
          title: "Filtreleme",
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Minimum Deprem Büyüklüğü",
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: minMagnitud,
                          min: 1,
                          max: 7,
                          divisions: 12,
                          label: minMagnitud.toStringAsFixed(1),
                          onChanged: (v) {
                            setState(() => minMagnitud = v);
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          minMagnitud.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        _Section(
          icon: Icons.palette_outlined,
          title: "Görünüm",
          children: [
            ListTile(
              leading: const Icon(Icons.dark_mode_outlined),
              title: const Text("Tema"),
              subtitle: const Text("Açık / Koyu / Sistem"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),

        _Section(
          icon: Icons.info_outline,
          title: "Hakkında",
          children: [
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("Uygulama Bilgisi"),
              subtitle: const Text("Deprem Uyarı v1.0.0"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Deprem Uyarı",
                  applicationVersion: "1.0.0",
                  applicationIcon:
                      const Icon(Icons.warning_amber_rounded, size: 40),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
class _Header extends StatelessWidget {
  final String title;
  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const _Section({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}