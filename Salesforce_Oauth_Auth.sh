#!/bin/bash -x

#Date management
DATE=$(date +\"%Y%m%d_%H%M%S\")
DATE="${DATE%\"}"
DATE="${DATE#\"}"
echo $DATE

#Autentication variables in order to get oauth Token
username=integration@EndPoint.com.EndPointdev
password=123456Jencomart123456789123456789
client_id=ABCDEFGHIJK123456789abcdefghijk1ab2c3d4e5f6g7h8i9
client_secret=123456789012345
grant_type=password
parameter1=\"username=$username\"
parameter1="${parameter1%\"}"
parameter1="${parameter1#\"}"
parameter2=\"password=$password\"
parameter2="${parameter2%\"}"
parameter2="${parameter2#\"}"
parameter3=\"client_id=$client_id\"
parameter3="${parameter3%\"}"
parameter3="${parameter3#\"}"
parameter4=\"client_secret=$client_secret\"
parameter4="${parameter4%\"}"
parameter4="${parameter4#\"}"
parameter5=\"grant_type=$grant_type\"
parameter5="${parameter5%\"}"
parameter5="${parameter5#\"}"

#Endpoint url for oauth token; (Endpoint for oauth token can be stored in a setting, so it isn't hard coded) 
Blackbox_Environment='https://test.salesforce.com/services/oauth2/token'
Production_Environment='https://login.salesforce.com/services/oauth2/token'

# Stores IDs and End point
myJencomartStoreId=5831
lastStoreId=5831
Jencomart_enpoint='https://Jencomart222--EndPointdev.my.salesforce.com/services/apexrest/CacheProducts'

#curl salesforce

TEMP=`curl $Blackbox_Environment -d $parameter1 -d $parameter2 -d $parameter3 -d $parameter4 -d $parameter5 | grep -oP '"access_token":\K.*?(?=,)'`

# To extract the token from the curl

TEMP="${TEMP%\"}"
TOKEN="${TEMP#\"}"

# If echo $TOKEN is blank, you won't authenticate.
echo $TOKEN

# To place the token into the new curl and request for an Store ID

curl -X POST $Jencomart_enpoint -H 'Authorization: OAuth '${TOKEN}'' -H 'Cache-Control: no-cache' -H 'Content-Type: application/json' -d '{"store" : { "myJencomartStoreId":"'${myJencomartStoreId}'", "lastStoreId":"'${lastStoreId}'"} }' > salesforce_download$DATE
