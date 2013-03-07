# Rationale

A unified wrapper to report trouble.

This gem achieves independence of things like Bugsnag, Airbrake, etc..

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
