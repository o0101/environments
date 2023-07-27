#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 domain"
    exit 1
fi

domain=$1
public_dns="8.8.8.8" # Google Public DNS

echo "Domain: $domain"
echo "---------------------------------------------"

echo "NSLOOKUP:"
nslookup $domain $public_dns
echo "---------------------------------------------"

DOMAIN=$1
WHOIS_OUTPUT=$(whois $DOMAIN)

echo "Domain: $DOMAIN"
echo "---------------------------------------------"
echo "Registrar:"
echo "$WHOIS_OUTPUT" | grep -i -E 'registrar(:| name:| url:)' | sort -u | sed 's/^[ \t]*//;s/[ \t]*$//'
echo "---------------------------------------------"
echo "Creation Date:"
echo "$WHOIS_OUTPUT" | grep -i -E 'creation date(:|:)' | sort -u | sed 's/^[ \t]*//;s/[ \t]*$//'
echo "---------------------------------------------"
echo "Expiration Date:"
echo "$WHOIS_OUTPUT" | grep -i -E 'expiry date(:|:)|expiration date(:|:)|registry expiry date(:|:)' | sort -u | sed 's/^[ \t]*//;s/[ \t]*$//'
echo "---------------------------------------------"
echo "Name Servers:"
echo "$WHOIS_OUTPUT" | grep -i -E 'name server(:|:)' | sort -u | sed 's/^[ \t]*//;s/[ \t]*$//'
echo "---------------------------------------------"
echo "Domain Status:"
echo "$WHOIS_OUTPUT" | grep -i -E 'domain status(:|:)' | sort -u | sed 's/^[ \t]*//;s/[ \t]*$//'
echo "---------------------------------------------"
echo "Registrant:"
echo "$WHOIS_OUTPUT" | grep -i -E 'registrant(:| name:| organization:| street:| city:| state/province:| postal code:| country:| phone:| email:)' | sort -u | sed 's/^[ \t]*//;s/[ \t]*$//'
echo "---------------------------------------------"
echo "Admin Contact:"
echo "$WHOIS_OUTPUT" | grep -i -E 'admin(:| name:| organization:| street:| city:| state/province:| postal code:| country:| phone:| email:)' | sort -u | sed 's/^[ \t]*//;s/[ \t]*$//'
echo "---------------------------------------------"
echo "Tech Contact:"
echo "$WHOIS_OUTPUT" | grep -i -E 'tech(:| name:| organization:| street:| city:| state/province:| postal code:| country:| phone:| email:)' | sort -u | sed 's/^[ \t]*//;s/[ \t]*$//'
echo "---------------------------------------------"

# DIG - DNS Records
echo "DIG - A Records:"
dig A $DOMAIN @8.8.8.8 +short
echo "---------------------------------------------"

echo "DIG - AAAA Records:"
dig AAAA $DOMAIN @8.8.8.8 +short
echo "---------------------------------------------"

echo "DIG - CNAME Records:"
dig CNAME $DOMAIN @8.8.8.8 +short
echo "---------------------------------------------"

echo "DIG - MX Records:"
dig MX $DOMAIN @8.8.8.8 +short
echo "---------------------------------------------"

echo "DIG - TXT Records:"
dig TXT $DOMAIN @8.8.8.8 +short
echo "---------------------------------------------"

echo "DIG - NS Records:"
dig NS $DOMAIN @8.8.8.8 +short
echo "---------------------------------------------"

if [ ! amass ]; then
  brew tap caffix/amass
  brew install amass
fi

amass $DOMAIN





