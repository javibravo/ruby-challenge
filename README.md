Ruby-Challenge
==============

[![Build Status](https://travis-ci.org/javibravo/ruby-challenge.svg?branch=master)](https://travis-ci.org/javibravo/ruby-challenge)

This Ruby test provide an API to upload ASCII files and count the numbers of words and the occurrence of each of them.
Some assumptions taken into account:

   - Words contains all letters (a-z and A-Z) and numbers (0-9).
   - It is not case sensitive, ie. "world" and "WoRLD" are the same word.
   - All punctiation marks are removed. So if two words are joined by a punctuation mark it will be a word, ie "re-play" will be "replay"
   - All word that contains the string "blue" will not be counted, ie: "blue", "blueberry", "bluegrass", ...

Endpoint : /api/v1/file
-----------------------
Method: **POST**

Upload and process file. The file must be added in the body of the request in a field named "file":

```
curl -X POST -F file=@/Users/jbravo/Projects/ruby-challenge/specs/fixtures/file_example_ok.txt http://localhost:3000/api/v1/file
```

The response of the request will be a JSON with the following data:
    - name : unique name generate for the file (UUID : http://ruby-doc.org/stdlib-2.2.3/libdoc/securerandom/rdoc/SecureRandom.html#method-c-uuid)
    - total : total number of words
    - distinct : number of distinct words
    - words : list of words and number of occurrences

```json
{
  "name": "0be772dc-3204-40d9-bbb3-9ced52366512",
  "total": 37,
  "distinct": 25,
  "words": {
    "this": 1,
    "is": 1,
    "a": 2,
    "test": 2,
    "file": 3,
    "to": 2,
    "the": 5,
    "new": 1,
    "api": 1,
    "service": 1,
    "upload": 1,
    "files": 1,
    "it": 1,
    "will": 1,
    "count": 1,
    "number": 2,
    "of": 2,
    "words": 1,
    "in": 2,
    "and": 1,
    "fo": 1,
    "times": 1,
    "each": 1,
    "them": 1,
    "appear": 1
  }
}
```

Endpoint : /api/v1/file/:name
-----------------------
Method: **GET**

Get the result for file uploaded previously. The *name* (Returned in the response for upload request) must be specified
at the end of the URL.

The response will be the same that the once received with file is uploaded.


Install
-------

To start using the application you must clone the project and run the following comands to install

```
>$ bundle install
```

Tests
-----

Once the project is stalled you mus run the following command to run tests

```
>$ bundle exec rspec
```

Run
---

To start running you must run the following comand

```
>$ bin/rails server
```