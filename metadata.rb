name             'dse-chef'
maintainer       'SimpleReach'
maintainer_email 'rbradberry@simplereach.com'
license          'All rights reserved'
description      'Installs/Configures dse-chef'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu', '>= 12.04'

depends 'java'
depends 'apache2'
