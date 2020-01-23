#!/bin/sh -e

echo "NO_START=0\nJETTY_HOST=127.0.0.1\nJETTY_PORT=8983\nJAVA_HOME=$JAVA_HOME" | sudo tee /etc/default/jetty
sudo cp ckan/ckan/config/solr/schema.xml /etc/solr/conf/schema.xml
sudo service jetty restart

if [ $CKANVERSION = 'master' ]
then
  pytest --ckan-ini=subdir/test.ini --cov=ckanext.archiver
else
  nosetests --nologcapture --with-pylons=subdir/test-core.ini --with-coverage --cover-package=ckanext.archiver --cover-inclusive --cover-erase --cover-tests
fi