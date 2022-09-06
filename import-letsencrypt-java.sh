#!/bin/bash -e

# souce https://gist.github.com/richmilne/5a5cb4be0ec8233a6c50ba40229d8278

# A codificiation of the steps outlined at
# https://ordina-jworks.github.io/security/2019/08/14/Using-Lets-Encrypt-Certificates-In-Java.html
CERT_EXT=der

KEYSTORE="/usr/share/elasticsearch/jdk/lib/security/cacerts"
if [ ! -f "$KEYSTORE" ]; then
    echo "Keystore not found in '$KEYSTORE'"
    exit 1
fi
cp "$KEYSTORE" "$KEYSTORE.$(date +"%Y-%m-%dT%H:%m:%S")"

# Make sure the keytool is on our path
PATH=${PATH}:/usr/share/elasticsearch/jdk/bin/

# List of downloads updated based on information found at
# https://letsencrypt.org/certificates/ (Last updated 2021-08-17)
# Depending on your application, you may or may not need the intermediate certificates.

certs=(
    # Root Certificates
    isrgrootx1
    isrg-root-x1-cross-signed
    isrg-root-x2
    isrg-root-x2-cross-signed

    # Intermediate Certificates
    lets-encrypt-r3
    lets-encrypt-r3-cross-signed   # Retired
    lets-encrypt-e1
    lets-encrypt-r4
    lets-encrypt-r4-cross-signed   # Retired
    lets-encrypt-e2
    letsencryptauthorityx1
    lets-encrypt-x1-cross-signed   # Retired
    letsencryptauthorityx2         # Retired
    lets-encrypt-x2-cross-signed   # Retired
    letsencryptauthorityx3         # Retired
    lets-encrypt-x3-cross-signed   # Retired
    letsencryptauthorityx4         # Retired
    lets-encrypt-x4-cross-signed   # Retired
)

for ALIAS in "${certs[@]}"
do
    FNAME="$ALIAS".$CERT_EXT
    echo "Downloading '$FNAME'..."
    curl "https://letsencrypt.org/certs/${FNAME}" --output ${FNAME}
    # to be idempotent, ensure new keys are removed from store
    echo "Deleting '$ALIAS' from '${KEYSTORE}'..."
    keytool -delete -alias "$ALIAS" -keystore "$KEYSTORE" -storepass changeit 2>/dev/null || true
    echo "Adding certificate $ALIAS to '${KEYSTORE}'..."
    keytool -trustcacerts -keystore "$KEYSTORE" -storepass changeit -noprompt -importcert -alias "$ALIAS" -file "$FNAME"
done

rm -vf ./*.${CERT_EXT}*