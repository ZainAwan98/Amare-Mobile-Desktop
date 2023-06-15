import 'package:amare/providers/hearth_this_api/models/track.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:flutter/widgets.dart';

class PodcastTile extends StatelessWidget {
  final Track track;
  final VoidCallback? onTap;
  bool showSubtitle;

  PodcastTile(
      {Key? key, required this.track, this.onTap, this.showSubtitle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: GestureDetector(
        onTap: onTap,
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AspectRatio(
                aspectRatio: 1,
                child: (track.image != null && track.image!.startsWith("http"))
                    ? Image.network(
                        track.image!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                      )),
          ),
          const SizedBox(height: 8),
          Text(
            track.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.accent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          if (showSubtitle)
            Text(
              track.author.name,
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
