# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include motd::defaults
class motd::defaults {
  # print uname & distribution release
  motd::script { 'header':
    priority => 0,
    content  => "#!/bin/sh\nuname -snrvm\nlsb_release -s -d\n\n",
  }

  # print /etc/motd.tail, useful & harmless enough
  motd::script { 'footer':
    priority => 99,
    content  => "#!/bin/sh\n[ -f /etc/motd.tail ] && cat /etc/motd.tail || true\n",
  }
}
