import 'package:amare/providers/hearth_this_api/models/playlist.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:flutter/widgets.dart';

class PlaylistTile extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback? onTap;

  const PlaylistTile({Key? key, required this.playlist, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: GestureDetector(
        onTap: onTap,
        child: Column(children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: AspectRatio(
                  aspectRatio: 1,
                  child: (playlist.image != null &&
                          playlist.image!.startsWith("http"))
                      ? Image.network(
                          playlist.image!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.cover,
                        )),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            playlist.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.accent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            playlist.author.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.accent,
              fontSize: 12,
            ),
          ),
        ]),
      ),
    );
  }
}
