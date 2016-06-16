# inline_encryption [![Build Status](https://travis-ci.org/rubyisbeautiful/inline_encryption.png)](https://travis-ci.org/rubyisbeautiful/inline_encryption)[![Code Climate](https://codeclimate.com/github/rubyisbeautiful/inline_encryption.png)](https://codeclimate.com/github/rubyisbeautiful/inline_encryption)

Simple encryption relying on convention and designed to be used inline as string replacements.

PLEASE upgrade to version 2.0 - previous versions lend themselves to making
human errors which could lead to exploitation.

## Upgrading from 1.0 to 2.0

1. Recommended, but optional - generate a new RSA key pair
2. For a properly configured production environment, simply configure with a private key
3. Pass along the public key to any developers on the team that will need to encrypt new values

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

To set up:

```ruby
InlineEncryption.config[:key] = '/some/rsa_key'
```

An example of different keys per environment:

```ruby
InlineEncryption.config[:key] = ENV['INLINE_ENCRYPTION_KEY']
```


If you've configured with a private key, you can both encrypt and decrypt.  If you've
configured with a public key, you can only encrypt.
