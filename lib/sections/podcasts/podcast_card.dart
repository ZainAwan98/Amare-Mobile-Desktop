import 'package:amare/providers/local_storage/local_storage.dart';
import 'package:amare/services/am_player.dart';
import 'package:intl/intl.dart';

import 'package:amare/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../providers/hearth_this_api/models/track.dart';

class PodcastCard extends StatefulWidget {
  final Track track;
  bool isPlaying = false;

  final VoidCallback? onTap;

  PodcastCard(
      {Key? key, required this.track, required this.isPlaying, this.onTap})
      : super(key: key);

  @override
  State<PodcastCard> createState() => _PodcastCardState();
}

class _PodcastCardState extends State<PodcastCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 58,
                    height: 58,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: widget.track.image != null &&
                                widget.track.image!.startsWith("http")
                            ? Image.network(
                                widget.track.image!,
                                height: 12,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  AppTheme.spacerH12,
                  Flexible(
                    child: Text(
                      widget.track.name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                      iconSize: 32,
                      onPressed: () {
                        if (widget.isPlaying) {
                          AMPLayer.shared.togglePlay();
                        } else {
                          if (AMPLayer.shared.currentStream ==
                              widget.track.stream_url) {
                            AMPLayer.shared.togglePlay();
                          } else {
                            AMPLayer.shared.replaceStream(PlayableSource(
                                widget.track.name,
                                widget.track.author.name,
                                widget.track.name,
                                widget.track.stream_url!,
                                widget.track.image_large));
                            LocalStorageProvider.saveRecentlyPlayed(
                                widget.track);
                          }
                        }
                      },
                      icon: Icon(
                        widget.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: AppTheme.accent,
                      )),
                  Text(
                    DateFormat.yMMMd().format(widget.track.date) + ' - ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppTheme.accent,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.track.duration_string,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppTheme.accent,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
