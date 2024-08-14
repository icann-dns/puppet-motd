# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include motd
# @param messages a hash of messages to pass to modt::messages
class motd (
  Hash[String[1], Hash] $messages = {}
) {
  # Kill Debian's default copyright/warranty banner
  file { '/etc/motd':
    ensure => absent,
  }

  file { '/etc/update-motd.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
  }

  include motd::defaults
  $messages.each |$title, $params| {
    motd::message { $title:
      * => $params,
    }
  }
}
