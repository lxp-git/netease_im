class AudioSystem {
  static const TAG = "AudioSystem";

  /* These values must be kept in sync with system/audio.h */
  /*
     * If these are modified, please also update Settings.System.VOLUME_SETTINGS
     * and attrs.xml and AudioManager.java.
     */
  /// Used to identify the default audio stream volume */
  static const STREAM_DEFAULT = -1;

  /// Used to identify the volume of audio streams for phone calls */
  static const STREAM_VOICE_CALL = 0;

  /// Used to identify the volume of audio streams for system sounds */
  static const STREAM_SYSTEM = 1;

  /// Used to identify the volume of audio streams for the phone ring and message alerts */
  static const STREAM_RING = 2;

  /// Used to identify the volume of audio streams for music playback */
  static const STREAM_MUSIC = 3;

  /// Used to identify the volume of audio streams for alarms */
  
  static const STREAM_ALARM = 4;

  /// Used to identify the volume of audio streams for notifications */
  static const STREAM_NOTIFICATION = 5;

  /// Used to identify the volume of audio streams for phone calls when connected on bluetooth */
  static const STREAM_BLUETOOTH_SCO = 6;

  /// Used to identify the volume of audio streams for enforced system sounds in certain
  /// countries (e.g camera in Japan) */
  static const STREAM_SYSTEM_ENFORCED = 7;

  /// Used to identify the volume of audio streams for DTMF tones */
  static const STREAM_DTMF = 8;

  /// Used to identify the volume of audio streams exclusively transmitted through the
  ///  speaker (TTS) of the device */
  static const STREAM_TTS = 9;

  /// Used to identify the volume of audio streams for accessibility prompts */
  static const STREAM_ACCESSIBILITY = 10;
}