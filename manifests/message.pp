# @summary define to add some text to the motd
# @param enable if we should enable the motd
# @param message the message to add, use title by default
# @param priority the motd priority
# @param color the color of the message
define motd::message (
  Boolean                      $enable  =  true,
  String[1]                    $message  = $title,
  Integer[0, 99]               $priority = 50,
  Optional[Motd::Ansi::Colour] $color    = undef,
) {
  $_message = $color ? {
    undef   => $message,
    default => motd::ansi::fg($message, $color)
  }
  $content = @("CONTENT")
    #!/bin/sh
    printf "%s\n" "${_message}"
    | CONTENT
  motd::script { $title:
    enable   => $enable,
    priority => $priority,
    content  => $content,
  }
}
