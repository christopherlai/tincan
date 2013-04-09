# Phone

Phone number provider.

# Configuration

Tincan delegates out the sending of SMS messages. Place the following code in an initializer
with an implementation in order to use it.

```ruby
Tincan::SMS.sender = lambda do |phone_number, body|
  puts "SMS sent to #{phone_number} - #{body}"
end
```

## Create

First, create a phone number verification:

    POST /v1/phone_numbers
    phone_number=%2B14152751660&message_format=Click%20this%20link%3A%20https%3A//seesaw.co/a/CODE

Response:

``` json
{
  "id": "0H2r2U1W3s3I0M3K0k173j1s3y2i2r05",
  "e164": "+14152751660",
  "country_code": "US",
  "local_format": "(415) 275-1660",
  "verified_at": null
}
```

This will send a text message with the following message:

> Click this link: https://seesaw.co/a/aFdh79mD"


## Verify

A client can now make the following request:

    POST /v1/phone_numbers/verify
    code=aFdh79mD

Response:

``` json
{
  "id": "0H2r2U1W3s3I0M3K0k173j1s3y2i2r05",
  "e164": "+14152751660",
  "country_code": "US",
  "local_format": "(415) 275-1660",
  "verified_at": 1365445347
}
```

Now `verified_at` is set and the client knows this is a valid phone number.


## Show

You can show a phone number token for a day to poll to see if it's verified. This will probably rarely be used since the request to verify it will be the only place this information is needed.

    GET /v1/phone_numbers/0H2r2U1W3s3I0M3K0k173j1s3y2i2r05

Response:

``` json
{
  "id": "0H2r2U1W3s3I0M3K0k173j1s3y2i2r05",
  "e164": "+14152751660",
  "country_code": "US",
  "local_format": "(415) 275-1660",
  "verified_at": 1365445347
}
```
