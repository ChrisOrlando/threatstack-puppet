# == Class: threatstack::params
#
# Common module parameters.
#
# === Examples
#
# class threatstack ( .. ) inherits threatstack::params { .. }
#
# === Authors
#
# Pete Cheslock <pete.cheslock@threatstack.com>
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
#
# === Copyright
#
# Copyright 2016 Threat Stack, Inc.
#

class threatstack::params {

  $ts_package = 'threatstack-agent'
  $ts_service = 'cloudsight'
  $ruleset    = ['Base Rule Set']

  case $::osfamily {
    'RedHat', 'Amazon', 'Fedora': {
      $repo_class       = '::threatstack::yum'
      $gpg_key          = 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file     = '/etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file_uri = "file://${gpg_key_file}"

      if $::osfamily == 'Amazon' {
        $repo_url = 'https://pkg.threatstack.com/Amazon'
      }
      elsif $::osfamily == 'Fedora' {
        $repo_url = 'https://pkg.threatstack.com/El/7'
      }
      else {
        $repo_url = "https://pkg.threatstack.com/EL/${::operatingsystemmajrelease}"
      }

    }
    'Debian': {
      $repo_class = '::threatstack::apt'
      $gpg_key  = 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK'
      $repo_url = 'https://pkg.threatstack.com/Ubuntu'
    }
    default: {
      fail("Module ${module_name} does not support ${::operatingsystem}")
    }
  }


}
