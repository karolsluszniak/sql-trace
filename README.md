# sql_trace

Ever wondered where do those SQL calls come from in your Rails app?

**sql_trace** allows to trace code that makes ActiveRecord SQL queries that
appear in development server's log. It also allows to filter them in order
to trace heavy ones or ones with matching SQL.

This makes it very useful during app-db optimizations.

## Installation

Add to `Gemfile`:

```ruby
gem 'sql_trace', group: :development
```

Then run:

    bundle install

## Usage

Start development server like this:

    SQL_TRACE=1 rails server

This way you'll get 5-line traces for all SQL queries. You can customize
that using options described below.

## Options

You can write options when invoking Rails server or store them in *.env*
file and use `dotenv` or `foreman` gems to load them.

Following options are available:

##### SQL_TRACE=N

Changes the stack size to N (must be at least 2, defaults to 5).

##### SQL_TRACE_COLOR=cyan

Uses [colorize](https://github.com/fazibear/colorize) gem to make traces
look distinct within server log. The gem must be installed separately.

##### SQL_TRACE_MIN_DURATION=250

Only prints traces for queries that take at least specified duration.
Duration is in **ms**.

##### SQL_TRACE_MATCH='FROM "users"'

Only prints traces for queries whose SQL match given string or /regex/
