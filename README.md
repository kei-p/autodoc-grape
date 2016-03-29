# Autodoc::Grape

Extend [r7kamura/autodoc](https://github.com/r7kamura/autodoc) to generate documention for [Grape API](https://github.com/ruby-grape/grape).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'autodoc-grape'
```

## Example

### Grape API params block
```ruby
params do
  requires :id, type: Integer
  optional :hash, type: Hash do
    requires :attr, type: String
  end
end
```

### Generated Parameter Section
```md
### Parameters
* id Integer (required)
* hash Hash
 * attr String (required)
```


## Supported Parameter Options
The following are all valid options.

* required
* values
* default
* description
