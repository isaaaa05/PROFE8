import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

// COMPONENT 10: Video player using video_player package
// COMPONENT 11: Enhanced video player with controls using chewie package
// COMPONENT 12: Play audio clip using audioplayers package
// COMPONENT 19: Video + audio player app with play, pause, and stop buttons
class MediaPlayerScreen extends StatefulWidget {
  const MediaPlayerScreen({super.key});

  @override
  State<MediaPlayerScreen> createState() => _MediaPlayerScreenState();
}

class _MediaPlayerScreenState extends State<MediaPlayerScreen> {
  final List<Map<String, String>> _videos = [
    {
      'title': 'Live Concert Performance',
      'asset':
          'assets/videos/event_preview.mp4', // COMPONENT 10: Local video path
    },
    {
      'title': 'Music Festival Highlights',
      'asset': 'assets/videos/event_preview.mp4',
    },
    {
      'title': 'Theater Show Preview',
      'asset': 'assets/videos/event_preview.mp4',
    },
  ];

  // COMPONENT 12: Audio tracks from assets
  // To use local audio files:
  // 1. Add audio files to assets/audio/ folder (e.g., event_music1.mp3)
  // 2. Declare them in pubspec.yaml under assets section
  // 3. Use AssetSource('audio/event_music1.mp3')
  final List<Map<String, String>> _audioTracks = [
    {
      'title': 'Event Background Music 1',
      'asset': 'audio/event_music1.mp3', // COMPONENT 12: Local audio path
    },
    {
      'title': 'Event Background Music 2',
      'asset': 'audio/event_music2.mp3',
    },
    {
      'title': 'Event Background Music 3',
      'asset': 'audio/event_music3.mp3',
    },
  ];

  int _currentVideoIndex = 0;
  int _currentAudioIndex = 0;

  // COMPONENT 10 & 11: Video player controllers
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  // COMPONENT 12: Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlayingAudio = false;
  Duration _audioDuration = Duration.zero;
  Duration _audioPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(_currentVideoIndex);
    _initializeAudioPlayer();
  }

  // COMPONENT 10 & 11: Initialize video player with chewie controls
  void _initializeVideoPlayer(int index) {
    _videoPlayerController = VideoPlayerController.asset(
      _videos[index]['asset']!,
    )..initialize().then((_) {
        if (mounted) {
          setState(() {
            // COMPONENT 11: Chewie provides enhanced controls
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: false,
              looping: false,
              showControls: true,
              materialProgressColors: ChewieProgressColors(
                playedColor: const Color(0xFF2196F3),
                handleColor: const Color(0xFF2196F3),
                backgroundColor: Colors.grey,
                bufferedColor: Colors.grey[300]!,
              ),
            );
          });
        }
      }).catchError((error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: Add video file to ${_videos[index]['asset']}',
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
      });
  }

  void _changeVideo(int index) {
    _chewieController?.dispose();
    _videoPlayerController.dispose();
    setState(() {
      _currentVideoIndex = index;
    });
    _initializeVideoPlayer(index);
  }

  // COMPONENT 12: Initialize audio player
  void _initializeAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          _audioDuration = duration;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() {
          _audioPosition = position;
        });
      }
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _isPlayingAudio = false;
          _audioPosition = Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  // COMPONENT 19: Play audio from assets
  Future<void> _playAudio() async {
    try {
      // COMPONENT 12: Play audio from assets folder
      await _audioPlayer
          .play(AssetSource(_audioTracks[_currentAudioIndex]['asset']!));
      if (mounted) {
        setState(() {
          _isPlayingAudio = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: Add audio file to ${_audioTracks[_currentAudioIndex]['asset']}',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  // COMPONENT 19: Pause audio
  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    if (mounted) {
      setState(() {
        _isPlayingAudio = false;
      });
    }
  }

  // COMPONENT 19: Stop audio
  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    if (mounted) {
      setState(() {
        _isPlayingAudio = false;
        _audioPosition = Duration.zero;
      });
    }
  }

  Future<void> _changeAudio(int index) async {
    await _stopAudio();
    setState(() {
      _currentAudioIndex = index;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Media Player',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // COMPONENT 10 & 11: Video Player Section
            Text(
              'Event Preview Videos',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    // COMPONENT 11: Chewie player with enhanced controls
                    child: Chewie(controller: _chewieController!),
                  )
                : Container(
                    height: 200,
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            const SizedBox(height: 16),
            Text(
              'Select Video:',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(_videos.length, (index) {
                return ChoiceChip(
                  label: Text('Video ${index + 1}'),
                  selected: _currentVideoIndex == index,
                  onSelected: (selected) {
                    if (selected) _changeVideo(index);
                  },
                );
              }),
            ),
            const SizedBox(height: 32),
            Divider(color: isDark ? Colors.white24 : Colors.grey[300]),
            const SizedBox(height: 16),

            // COMPONENT 12 & 19: Audio Player Section
            Text(
              'Event Background Music',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // COMPONENT 13: Material Icons with dynamic size and color
                  Icon(
                    _isPlayingAudio ? Icons.music_note : Icons.music_off,
                    size: 64,
                    color: const Color(0xFF2196F3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _audioTracks[_currentAudioIndex]['title']!,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Audio progress slider
                  Slider(
                    value: _audioDuration.inSeconds > 0
                        ? _audioPosition.inSeconds.toDouble()
                        : 0.0,
                    max: _audioDuration.inSeconds > 0
                        ? _audioDuration.inSeconds.toDouble()
                        : 1.0,
                    activeColor: const Color(0xFF2196F3),
                    inactiveColor: isDark ? Colors.white24 : Colors.grey[300],
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await _audioPlayer.seek(position);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_audioPosition),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      Text(
                        _formatDuration(_audioDuration),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // COMPONENT 19: Play, Pause, and Stop buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Stop button
                      IconButton(
                        onPressed: _stopAudio,
                        icon: const Icon(Icons.stop),
                        iconSize: 40,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 20),
                      // Play/Pause button
                      IconButton(
                        onPressed: _isPlayingAudio ? _pauseAudio : _playAudio,
                        icon: Icon(
                          _isPlayingAudio
                              ? Icons.pause_circle
                              : Icons.play_circle,
                        ),
                        iconSize: 64,
                        color: const Color(0xFF2196F3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select Track:',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: List.generate(_audioTracks.length, (index) {
                      return ChoiceChip(
                        label: Text('Track ${index + 1}'),
                        selected: _currentAudioIndex == index,
                        onSelected: (selected) {
                          if (selected) _changeAudio(index);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
