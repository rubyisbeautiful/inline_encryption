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