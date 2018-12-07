# 2.0.1
  - update test app to latest Rails 4 to satisfy automated security scan; future versions 
    will probably drop the included test app
  - updated travis to drop ruby 2.1, update 2.2 and 2.3 to latest; add ruby 2.4 and 2.5
    
# 2.0.0
  - Major backwards compatible change.  A common if perhaps upspoken thought
  of many good developers I have known is "I hate what I wrote yesterday"
  Well, for whatever reason (that I cannot recall or even fathom) this gem was
  originally written using a private key for encrypting a value, and a public
  key to decrypt.  While that is not itself insecure, it's a terrible
  practice and makes it easy for humans to make errors.
  So starting in version 2.0.0 encrpyt methods will use public key and
  decrypt will use private key, as is conventional
  - raise on trying to decrypt with a public key
  - code cleanup (style, remove spork remnant)
  - bump travis ruby versions to secure versions

# 1.0.5
  - updated gem groups, updated travis to run without debugger and development groups
# 1.0.4
  - update version of Bundler to floor 1.7
  - swapped byebug for debugger
  - fixed a few style violations (single/double quotes)
  - added Thor to runtime dependencies
  - added explicit require for hashie/dash and hashie/extensions/dash/indifferent_access in config.rb
    I think this is probably unnecessary but was getting unresolved name errors in some rubies
  - added explicit require for base64 in base.rb ([Issue #2](https://github.com/rubyisbeautiful/inline_encryption/issues/2))
  - drop 1.9.x and 2.0.x in travis testing
  - updated to rspec 3 syntax
  
# 1.0.3
