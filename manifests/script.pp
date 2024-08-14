# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   motd::script { 'namevar': }
# @param priority where in the motd list whill the message display.  higher values wil be at the bottom
# @param content the raw content of the message
# @param source a source location for the message
define motd::script (
  Integer[0, 99]               $priority  = 50,
  Optional[String]             $content = undef,
  Optional[Stdlib::Filesource] $source  = undef,
) {
  include motd

  if $source == undef and $content == undef {
    fail('you must provide either "source" or "content"')
  }
  if $source != undef and $content != undef {
    fail('"source" and "content" are mutually exclusive')
  }

  $safe_name = regsubst($title, '[\W_]', '-', 'G').downcase
  $script    = sprintf('%02d-%s', $priority, $safe_name)

  file { "/etc/update-motd.d/${script}":
    ensure  => file,
    content => $content,
    source  => $source,
    mode    => '0555',
  }
}
