# inline_encryption [![Build Status](https://travis-ci.org/rubyisbeautiful/inline_encryption.png)](https://travis-ci.org/rubyisbeautiful/inline_encryption)
[![Code Climate](https://codeclimate.com/github/rubyisbeautiful/inline_encryption.png)](https://codeclimate.com/github/rubyisbeautiful/inline_encryption)

Simple encryption relying on convention and designed to be used inline as string replacements.

## Usage

Imagine you have a file named `database.yml` that contains passwords.

Before:

```ruby
password: '123456'
```

After:

```ruby
password: <%= InlineEncryption.decrypt(encrypted stuff goes here) %>
```
