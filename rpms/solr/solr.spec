# See http://blog.nexcess.net/2011/12/30/installing-apache-solr-on-centos/ for required tomcat6 and java jdk.
Summary: Solr binary package
Name: apache-solr
Version: 3.5.0
Release: 1%{?dist}
Group: Applications/File
License: Apache License 2.0
Source0: apache-solr-3.5.0.tgz
Requires: tomcat6
Requires: java-1.6.0-openjdk

%description
SOLR binary package, for version 3.5.0. Installs to a tomcat6 installation as war file and example data files.

%prep
%setup

%build
# No building, we are basically just installing the example directory + war for tomcats usage.

%install
install -d $RPM_BUILD_ROOT/opt/data/solr
install -d $RPM_BUILD_ROOT/usr/share/tomcat6/conf/Catalina/localhost
mv $RPM_BUILD_DIR/apache-solr-3.5.0/example/solr $RPM_BUILD_ROOT/opt/data
mv $RPM_BUILD_DIR/apache-solr-3.5.0/dist/apache-solr-3.5.0.war $RPM_BUILD_ROOT/opt/data/solr/solr.war
# A bit of a kludge ... works ok though
cat > $RPM_BUILD_ROOT/usr/share/tomcat6/conf/Catalina/localhost/solr.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<Context docBase="/opt/data/solr/solr.war" debug="0" crossContext="true">
  <Environment name="solr/home" type="java.lang.String" value="/opt/data/solr/" override="true"/>
</Context>
EOF
install -d $RPM_BUILD_ROOT/opt/data/solr/conf/lang
cat > $RPM_BUILD_ROOT/opt/data/solr/conf/lang/stopwords_fi.txt << EOF
 | Even more originally https://gitorious.org/yacy/rc1/blobs/1be0025a9ca151ff08a2cefd35c7ee0ed3e1c39d/defaults/solr/lang/stopwords_fi.txt
 | From svn.tartarus.org/snowball/trunk/website/algorithms/finnish/stop.txt
 | This file is distributed under the BSD License.
 | See http://snowball.tartarus.org/license.php
 | Also see http://www.opensource.org/licenses/bsd-license.html
 |  - Encoding was converted to UTF-8.
 |  - This notice was added.
 
| forms of BE

olla
olen
olet
on
olemme
olette
ovat
ole        | negative form

oli
olisi
olisit
olisin
olisimme
olisitte
olisivat
olit
olin
olimme
olitte
olivat
ollut
olleet

en         | negation
et
ei
emme
ette
eivät

|Nom   Gen    Acc    Part   Iness   Elat    Illat  Adess   Ablat   Allat   Ess    Trans
minä   minun  minut  minua  minussa minusta minuun minulla minulta minulle               | I
sinä   sinun  sinut  sinua  sinussa sinusta sinuun sinulla sinulta sinulle               | you
hän    hänen  hänet  häntä  hänessä hänestä häneen hänellä häneltä hänelle               | he she
me     meidän meidät meitä  meissä  meistä  meihin meillä  meiltä  meille                | we
te     teidän teidät teitä  teissä  teistä  teihin teillä  teiltä  teille                | you
he     heidän heidät heitä  heissä  heistä  heihin heillä  heiltä  heille                | they

tämä   tämän         tätä   tässä   tästä   tähän  tallä   tältä   tälle   tänä   täksi  | this
tuo    tuon          tuotä  tuossa  tuosta  tuohon tuolla  tuolta  tuolle  tuona  tuoksi | that
se     sen           sitä   siinä   siitä   siihen sillä   siltä   sille   sinä   siksi  | it
nämä   näiden        näitä  näissä  näistä  näihin näillä  näiltä  näille  näinä  näiksi | these
nuo    noiden        noita  noissa  noista  noihin noilla  noilta  noille  noina  noiksi | those
ne     niiden        niitä  niissä  niistä  niihin niillä  niiltä  niille  niinä  niiksi | they

kuka   kenen kenet   ketä   kenessä kenestä keneen kenellä keneltä kenelle kenenä keneksi| who
ketkä  keiden ketkä  keitä  keissä  keistä  keihin keillä  keiltä  keille  keinä  keiksi | (pl)
mikä   minkä minkä   mitä   missä   mistä   mihin  millä   miltä   mille   minä   miksi  | which what
mitkä                                                                                    | (pl)

joka   jonka         jota   jossa   josta   johon  jolla   jolta   jolle   jona   joksi  | who which
jotka  joiden        joita  joissa  joista  joihin joilla  joilta  joille  joina  joiksi | (pl)

| conjunctions

että   | that
ja     | and
jos    | if
koska  | because
kuin   | than
mutta  | but
niin   | so
sekä   | and
sillä  | for
tai    | or
vaan   | but
vai    | or
vaikka | although


| prepositions

kanssa  | with
mukaan  | according to
noin    | about
poikki  | across
yli     | over, across

| other

kun    | when
niin   | so
nyt    | now
itse   | self
EOF

%post
# To counter the issues with a 500 error on solr.
sed -i 's/enable="${solr.velocity.enabled:true}"/enable="${solr.velocity.enabled:false}"/' /opt/data/solr/conf/solrconfig.xml
service tomcat6 restart
%files
%attr(-,tomcat,tomcat)/opt/data/solr
%attr(-,tomcat,tomcat)/usr/share/tomcat6/conf/Catalina/localhost/solr.xml
