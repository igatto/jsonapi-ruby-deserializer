# JSONAPI Ruby Deserializer
Makes work with [JSON::API compound documents](https://jsonapi.org/format/#document-compound-documents) easy

## Status
[![CircleCI](https://circleci.com/gh/igatto/jsonapi-ruby-deserializer/tree/main.svg?style=shield&circle-token=20af9c492f5ee96fb66bffb1236b11e979549d54)](https://circleci.com/gh/igatto/jsonapi-ruby-deserializer/tree/main)&emsp;&emsp;

## Installation
```
gem 'jsonapi-ruby-deserializer'
```
```
gem install jsonapi-ruby-deserializer
```

## Usage
### Simple example:
```ruby
hash = {"data"=>{"type"=>"articles", "attributes"=>{"title"=>"Lorem Ipsum"}}}
document = JSONAPI::Ruby::Deserializer::Document.new(hash)
document.data.title
=> "Lorem Ipsum"
```

### Advanced example:
```ruby
hash = {"meta"=>{"license"=>"MIT", "authors"=>["James Smith", "Maria Hernandez"]}, "links"=>{"self"=>"http://example.com/articles", "next"=>"http://example.com/articles?page[offset]=2", "last"=>"http://example.com/articles?page[offset]=10"}, "data"=>[{"type"=>"articles", "id"=>"1", "attributes"=>{"title"=>"JSON:API paints my bikeshed!"}, "relationships"=>{"author"=>{"links"=>{"self"=>"http://example.com/articles/1/relationships/author", "related"=>"http://example.com/articles/1/author"}, "data"=>{"type"=>"people", "id"=>"9"}}, "comments"=>{"links"=>{"self"=>"http://example.com/articles/1/relationships/comments", "related"=>"http://example.com/articles/1/comments"}, "data"=>[{"type"=>"comments", "id"=>"5"}, {"type"=>"comments", "id"=>"12"}]}}, "links"=>{"self"=>"http://example.com/articles/1"}}], "included"=>[{"type"=>"people", "id"=>"9", "attributes"=>{"first_name"=>"Dan", "last_name"=>"Gebhardt", "twitter"=>"dgeb"}, "links"=>{"self"=>"http://example.com/people/9"}}, {"type"=>"comments", "id"=>"5", "attributes"=>{"body"=>"First!"}, "relationships"=>{"author"=>{"data"=>{"type"=>"people", "id"=>"2"}}}, "links"=>{"self"=>"http://example.com/comments/5"}}, {"type"=>"comments", "id"=>"12", "attributes"=>{"body"=>"I like XML better"}, "relationships"=>{"author"=>{"data"=>{"type"=>"people", "id"=>"9"}}}, "links"=>{"self"=>"http://example.com/comments/12"}}]}
document = JSONAPI::Ruby::Deserializer::Document.new(hash)
```

#### Attributes
```ruby
document.data[0].attributes
# => {"title"=>"JSON:API paints my bikeshed!"}

document.data[0].title
# => "JSON:API paints my bikeshed!"
```

#### One-to-one relation
```ruby
document.data[0].author.first_name
# => "Dan"
```

#### One-to-many relation
```ruby
document.data[0].comments[0].body
# => "First!"
```

#### Access to relation through another relation
```ruby
document.data[0].comments[1].author.first_name
# => "Dan"
```

#### Meta
```ruby
document.meta.authors
# => ["James Smith", "Maria Hernandez"]
```

#### Links
```ruby
document.links.self
# => "http://example.com/articles"

document.data[0].relationships['author'].links.self
# => "http://example.com/articles/1/relationships/author"
```

## License
jsonapi-ruby-deserializer is released under the [MIT License](http://www.opensource.org/licenses/MIT).
