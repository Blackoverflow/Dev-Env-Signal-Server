Dev-Env-Signal-Server with docker
=================

Why?
-------------

This is a modified version of the Signal Server by Open Whisper System.
It has vastly reduced configuration dependencies and is meant to be used in a development or testing environment.

It is __not__ meant to be used for secure communication.

Installation
-------------

This setup requires docker and docker-compose.

```
# build signal server
docker-compose build signal-server
# start the databases 
docker-compose up -d postgresql-abuse postgresql-accounts  postgresql-message redis
```

Migrate the databases

```
docker-compose run signal-server bash 
cd /Signal-Server/service
java -jar target/TextSecureServer-3.21.jar abusedb migrate config/config.yml
java -jar target/TextSecureServer-3.21.jar accountdb migrate config/config.yml
java -jar target/TextSecureServer-3.21.jar messagedb migrate config/config.yml

```

Run signal server

```
docker-compose up -d signal-server
```

SMS code
-------------

The default code is `111 111`

Cryptography Notice
------------

This distribution includes cryptographic software. The country in which you currently reside may have restrictions on the import, possession, use, and/or re-export to another country, of encryption software.
BEFORE using any encryption software, please check your country's laws, regulations and policies concerning the import, possession, or use, and re-export of encryption software, to see if this is permitted.
See <http://www.wassenaar.org/> for more information.

The U.S. Government Department of Commerce, Bureau of Industry and Security (BIS), has classified this software as Export Commodity Control Number (ECCN) 5D002.C.1, which includes information security software using or performing cryptographic functions with asymmetric algorithms.
The form and manner of this distribution makes it eligible for export under the License Exception ENC Technology Software Unrestricted (TSU) exception (see the BIS Export Administration Regulations, Section 740.13) for both object code and source code.

License
---------------------
Modifications by Blackoverflow 2020

Original Signal Server:
Copyright 2013-2016 Open Whisper Systems

Licensed under the AGPLv3: https://www.gnu.org/licenses/agpl-3.0.html
