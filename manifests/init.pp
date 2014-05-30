# Report processor integration with Slack.com
class slack (
  $slack_token          = undef,
  $slack_url            = undef,
  $slack_iconurl        = 'http://puppetlabs.com/wp-content/uploads/2010/12/PL_logo_vertical_RGB_lg.png',
  $slack_channel        = '#puppet',
  $slack_botname        = 'puppet',
  $slack_puppet_reports = undef,
) {

  package { 'faraday':
    ensure   => installed,
    provider => gem,
  }

  file { '/etc/puppet/slack.yaml':
    path    => '/etc/puppet/slack.yaml',
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('slack/slack.yaml.erb'),
  }

  if $slack_puppet_reports {
    ini_setting { 'slack_puppet_reports':
      ensure  => present,
      path    => '/etc/puppet/puppet.conf',
      section => 'master',
      setting => 'reports',
      value   => $slack_puppet_reports,
    }
  }

}
