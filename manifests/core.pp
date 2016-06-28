# == Type: solr::core
#
# Sets up a core based on the example core installed by default.
#
# === Parameters
#
# [*core_name*]
#   The name of the core (must be unique).
#   Default: $title
#
# [*replace*]
#   Whether or not files should be updated if they are different from the source
#   specified.
#   Default: true
#
# [*currency_src_file*]
#   The currency file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#   The default is the example currency file.
#
# [*protwords_src_file*]
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#   The default is the example protwords file.
#
# [*schema_src_file*]
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#   The default is the example schema file.
#
# [*solrconfig_src_file*]
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#   The default is the example solrconfig file.
#
# [*stopwords_src_file*]
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#   The default is the example stopwords file.
#
# [*synonyms_src_file*]
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#   The default is the example synonyms file.
#
# === Variables
#
# [*dest_dir*]
#
#
# === Examples
#
# === Copyright
#
# GPL-3.0+
#
define solr::core (
  $core_name            = $title,
  $replace              = true,
  $currency_src_file    = "${::solr::basic_dir}/currency.xml",
  $other_files          = [],
  $protwords_src_file   = "${::solr::basic_dir}/protwords.txt",
  $schema_src_file      = "${::solr::basic_dir}/schema.xml",
  $solrconfig_src_file  = "${::solr::basic_dir}/solrconfig.xml",
  $stopwords_src_file   = "${::solr::basic_dir}/stopwords.txt",
  $synonyms_src_file    = "${::solr::basic_dir}/synonyms.txt",
){

  anchor{"solr::core::${title}::begin":}

  # The base class must be included first because core uses variables from
  # base class
  if ! defined(Class['solr']) {
    fail("You must include the solr base class before using any\
 solr defined resources")
  }

  $dest_dir    = "${::solr::solr_core_home}/${core_name}"
  $conf_dir    = "${dest_dir}/conf"
  $schema_file = "${conf_dir}/schema.xml"

  file { $dest_dir:
    ensure  => directory,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    require => [Class[Solr::Config],
                Anchor["solr::core::${title}::begin"]],
  }

  # create the conf directory
  file { $conf_dir:
    ensure  => directory,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    require => File[$dest_dir],
  }

  file { "${conf_dir}/solrconfig.xml":
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $solrconfig_src_file,
    replace => $replace,
    require => File[$conf_dir],
    notify  => Class[Solr::Service],
  }

  file { "${conf_dir}/synonyms.txt":
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $synonyms_src_file,
    replace => $replace,
    require => File["${conf_dir}/solrconfig.xml"],
    notify  => Class[Solr::Service],
  }

  file { "${conf_dir}/protwords.txt":
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $protwords_src_file,
    replace => $replace,
    require => File["${conf_dir}/synonyms.txt"],
    notify  => Class[Solr::Service],
  }

  file { "${conf_dir}/stopwords.txt":
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $stopwords_src_file,
    replace => $replace,
    require => File["${conf_dir}/protwords.txt"],
    notify  => Class[Solr::Service],
  }

  exec { "${core_name}_copy_lang":
    command => "/bin/cp -r ${::solr::basic_dir}/lang ${conf_dir}/.",
    user    => $::solr::solr_user,
    creates => "${conf_dir}/lang/stopwords_en.txt",
    require => File["${conf_dir}/stopwords.txt"],
    notify  => Class[Solr::Service],
  }

  file { "${conf_dir}/currency.xml":
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $currency_src_file,
    replace => $replace,
    require => Exec["${core_name}_copy_lang"],
    notify  => Class[Solr::Service],
  }

  file { $schema_file:
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $schema_src_file,
    replace => $replace,
    require => File["${conf_dir}/currency.xml"],
    notify  => Class[Solr::Service],
  }

  $defaults = {
    'ensure'  => file,
    'owner'   => $::solr::solr_user,
    'group'   => $::solr::solr_user,
    'replace' => $replace,
    'require' => File[$conf_dir],
    'notify'  => Class[Solr::Service],
    'before'  => File["${dest_dir}/core.properties"],
  }
  create_resources(file, other_files($other_files, $conf_dir), $defaults)

  file { "${dest_dir}/core.properties":
    ensure  => file,
    content => inline_template(
"name=${core_name}
config=solrconfig.xml
schema=schema.xml
dataDir=data"),
    require => File[$schema_file],
  }

  anchor{"solr::core::${title}::end":
    require => File["${dest_dir}/core.properties"],
  }
}
