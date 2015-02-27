# Trouble

A unified wrapper to report errors and Exceptions.

This gem achieves independence of things like Bugsnag, Airbrake, etc.. If any of those is defined, Trouble will pass on the exception to them. Additionaly, everything is written to a custom logger you specify (defaults to `Rails.logger`).

Currently only Bugsnag is defined as a working backend.

# Installation

```bash
gem install trouble
````

# Usage

#### Syntax

```ruby
Trouble.notify EXCEPTION, [METADATA-HASH]
````

#### Examples 

```ruby
exception = RuntimeError.new

Trouble.notify exception
Trouble.notify exception, some_idea_why_it_happened: "I don't know, but try this and that."
```

# Rails Middleware

```ruby
# config/application.rb
config.middleware.insert_after ActionDispatch::DebugExceptions, 'Trouble::Middleware'
```
