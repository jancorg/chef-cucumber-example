name             'rsyslog-ssl'
maintainer       'JAC'
maintainer_email 'jancorg@gmail.com'
license          'All rights reserved'
description      'Installs/Configures rsyslog-ssl'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'rsyslog'
depends          'apt'

recipe          'rsyslog-wrapper::default', 'rsyslog wrapper'
recipe          'rsyslog-wrapper::server', 'rsyslog server recipe wrapper'
recipe          'rsyslog-wrapper::client', 'rsyslog client recipe wrapper'
