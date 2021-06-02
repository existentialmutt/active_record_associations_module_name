# ActiveRecordAssociationsModuleName
When working with ActiveRecord models within modules, retyping the module path within association definitions can become repetive and noisy. This extension makes things a little more DRY by adding a `module_name` option.

## Usage
Specify a string `module_name` for any ActiveRecord association (belongs_to, has_many, has_one, or has_and_belongs_to_many)

For example:

```ruby
class Post
  has_many :comments, module_name: "Blog"

  # this replaces:
  # has_many :comments, class_name: "Blog::Comment"
end

```

Models often reference other models in the same module. For this you can use the shortcut `module_name: true`.

```ruby
class Blog::Post
  has_many :comments, module_name: true

  # this replaces:
  # has_many :comments, class_name: "Blog::Comment"
end

```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'active_record_associations_module_name'
```

And then execute:
```bash
$ bundle
```

## Contributing
Issues and pull requests are welcome. Please be respectful.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
