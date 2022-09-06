FROM elasticsearch:7.17.6
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-attachment
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3

# Accept let's encrypt certificates for S3 compatible snapshot repositories
# cf https://gist.github.com/galan/ec8b5f92dd325a97e2f66e524d28aaf8
# RUN curl https://letsencrypt.org/certs/letsencryptauthorityx1.der --output /tmp/letsencryptauthorityx1.der
RUN curl https://letsencrypt.org/certs/letsencryptauthorityx2.der --output /tmp/letsencryptauthorityx2.der
RUN curl https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.der --output /tmp/lets-encrypt-x1-cross-signed.der
RUN curl https://letsencrypt.org/certs/lets-encrypt-x2-cross-signed.der --output /tmp/lets-encrypt-x2-cross-signed.der
RUN curl https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.der --output /tmp/lets-encrypt-x3-cross-signed.der
RUN curl https://letsencrypt.org/certs/lets-encrypt-x4-cross-signed.der --output /tmp/lets-encrypt-x4-cross-signed.der
RUN curl https://letsencrypt.org/certs/lets-encrypt-r3-cross-signed.der --output /tmp/lets-encrypt-r3-cross-signed.der
# RUN /usr/share/elasticsearch/jdk/bin/keytool -trustcacerts -keystore /usr/share/elasticsearch/jdk/lib/security/cacerts -storepass changeit -noprompt -importcert -alias isrgrootx1 -file /tmp/letsencryptauthorityx1.der
RUN /usr/share/elasticsearch/jdk/bin/keytool -trustcacerts -keystore /usr/share/elasticsearch/jdk/lib/security/cacerts -storepass changeit -noprompt -importcert -alias isrgrootx2 -file /tmp/letsencryptauthorityx2.der
RUN /usr/share/elasticsearch/jdk/bin/keytool -trustcacerts -keystore /usr/share/elasticsearch/jdk/lib/security/cacerts -storepass changeit -noprompt -importcert -alias letsencryptauthorityx1 -file /tmp/lets-encrypt-x1-cross-signed.der
RUN /usr/share/elasticsearch/jdk/bin/keytool -trustcacerts -keystore /usr/share/elasticsearch/jdk/lib/security/cacerts -storepass changeit -noprompt -importcert -alias letsencryptauthorityx2 -file /tmp/lets-encrypt-x2-cross-signed.der
RUN /usr/share/elasticsearch/jdk/bin/keytool -trustcacerts -keystore /usr/share/elasticsearch/jdk/lib/security/cacerts -storepass changeit -noprompt -importcert -alias letsencryptauthorityx3 -file /tmp/lets-encrypt-x3-cross-signed.der
RUN /usr/share/elasticsearch/jdk/bin/keytool -trustcacerts -keystore /usr/share/elasticsearch/jdk/lib/security/cacerts -storepass changeit -noprompt -importcert -alias letsencryptauthorityx4 -file /tmp/lets-encrypt-x4-cross-signed.der
RUN /usr/share/elasticsearch/jdk/bin/keytool -trustcacerts -keystore /usr/share/elasticsearch/jdk/lib/security/cacerts -storepass changeit -noprompt -importcert -alias letsencryptauthorityr3 -file /tmp/lets-encrypt-r3-cross-signed.der