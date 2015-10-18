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
# [*schema_src_file*]
#   The schema file must exist on the file system and should be controlled
#   outside of this module.  This will simply link to the schema file.
#   Default: the basic example core's schema.
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
  $core_name       = $title,
  $schema_src_file = "${solr::basic_dir}/schema.xml",
  ){

  anchor {"solr::core::${core_name}::begin":}

  # The base class must be included first because core uses variables from
  # base class
  if ! defined(Class['solr']) {
    fail("You must include the solr base class before using any solr defined\
 resources")
  }

  $dest_dir    = "${solr::solr_core_home}/${core_name}"
  $conf_dir    = "${dest_dir}/conf"
  $schema_file = "${conf_dir}/schema.xml"

  # create the conf directory
  file {[$dest_dir,$conf_dir]:
    ensure => directory,
    owner  => $solr::solr_user,
    group  => $solr::solr_user,
  }

  exec {"${core_name}_copy_solrconfig":
    command => "/bin/cp ${solr::basic_dir}/solrconfig.xml ${conf_dir}/.",
    user    => $solr::solr_user,
    creates => "${conf_dir}/solrconfig.xml",
    require => File[$conf_dir],
  }
  exec {"${core_name}_copy_synonyms":
    command => "/bin/cp ${solr::basic_dir}/synonyms.txt ${conf_dir}/.",
    user    => $solr::solr_user,
    creates => "${conf_dir}/synonyms.txt",
    require => Exec["${core_name}_copy_solrconfig"],
  }
  exec {"${core_name}_copy_protwords":
    command => "/bin/cp ${solr::basic_dir}/protwords.txt ${conf_dir}/.",
    user    => $solr::solr_user,
    creates => "${conf_dir}/protwords.txt",
    require => Exec["${core_name}_copy_synonyms"],
  }
  exec {"${core_name}_copy_stopwords":
    command => "/bin/cp ${solr::basic_dir}/stopwords.txt ${conf_dir}/.",
    user    => $solr::solr_user,
    creates => "${conf_dir}/stopwords.txt",
    require => Exec["${core_name}_copy_protwords"],
  }
  exec {"${core_name}_copy_lang":
    command => "/bin/cp -r ${solr::basic_dir}/lang ${conf_dir}/.",
    user    => $solr::solr_user,
    creates => "${conf_dir}/lang/stopwords_en.txt",
    require => Exec["${core_name}_copy_stopwords"],
  }
  exec {"${core_name}_copy_currency":
    command => "/bin/cp ${solr::basic_dir}/currency.xml ${conf_dir}/.",
    user    => $solr::solr_user,
    creates => "${conf_dir}/currency.xml",
    require => Exec["${core_name}_copy_lang"],
  }

  file {$schema_file:
    ensure  => link,
    target  => $schema_src_file,
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    require => Exec["${core_name}_copy_currency"],
  }

  file {"${dest_dir}/core.properties":
    ensure  => file,
    content => inline_template(
"name=${core_name}
config=solrconfig.xml
schema=schema.xml
dataDir=data"),
    require => File[$schema_file],
  }

  anchor {"solr::core::${core_name}::end":
    require => File["${dest_dir}/core.properties"],
  }
}