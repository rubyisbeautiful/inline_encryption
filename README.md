inline_encryption [![Build Status](https://travis-ci.org/rubyisbeautiful/inline_encryption.png)](https://travis-ci.org/rubyisbeautiful/inline_encryption)
=================


Simple encryption relying on convention and designed to be used inline as string replacements 
Best demonstrated with pseudo-yaml

Before:

database.yml:
---
password: '123456'


After:

database.yml:
---
password: <%= InlineEncryption.decrypt(encrypted stuff goes here) %>
