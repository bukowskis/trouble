# Rationale

A unified wrapper to report trouble.

This gem achieves independence of things like Bugsnag, Airbrake, etc.. If any of those is defined, Trouble will pass on the exception to them. Additionaly, everything is written to a custom logger you specify.

# Usage

#### Syntax

```ruby
Trouble.notify EXCEPTION, [METADATA-HASH]
````

#### Examples 

```ruby
Trouble.logger = Rails.logger
exception = RuntimeError.new

Trouble.notify exception
Trouble.notify exception, some_idea_why_it_happened: "I don't know, but try this and that."
```
