# Phone

Phone number provider.

## Create

First, create a phone number verification:

    POST /v1/phone_numbers
    phone_number=+14152751660&message_format=seesaw://verify/CODE&redirect_uri=https:

Response:

``` json
{
  "id": "1asdf",
  "e164": "+14152751660",
  "country": "US",
  "formatted": "(415) 275-1660",
  "verified": false
}
```

This will send a text message with `#{prefix}#{code}` in it.


## Verify

Swingset will make the following request:

    POST https://phone.seesaw.co/v1/verify
    code=012345

Response:

``` json
{
  "id": "1asdf",
  "e164": "+14152751660",
  "country": "US",
  "formatted": "(415) 275-1660",
  "verified": true
}
```

## Show

You can show a phone number token for a day to poll to see if it's verified. This will probably rarely be used since the request to verify it will be the only place this information is needed.

    GET https://phone.seesaw.co/v1/phone_numbers/1asdf

Response:

``` json
{
  "id": "1asdf",
  "e164": "+14152751660",
  "country": "US",
  "formatted": "(415) 275-1660",
  "verified": true
}
```
