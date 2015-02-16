require 'libnotify'

module PianobarNotify
  autoload :Blob,         'pianobar_notify/blob'
  autoload :CLI,          'pianobar_notify/cli'
  autoload :Cover,        'pianobar_notify/cover'
  autoload :Notification, 'pianobar_notify/notification'
  autoload :Stations,     'pianobar_notify/stations'
  autoload :VERSION,      'pianobar_notify/version'

  COVER_PATH = File.join(ENV.fetch("HOME"), ".cache/pianobar-notify")

  Libnotify.icon_dirs << COVER_PATH
end
