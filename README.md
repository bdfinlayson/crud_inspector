# CrudInspector
Keeps a record of recent CRUD transactions by REST or SOAP protocol. CrudInspector will create a timestamped file of the request or response contents for later reference. This is helpful for projects using many external APIs that must share copies of requests and responses with clients for debugging purposes.

## Usage
`CrudInspector::Tracker` currently supports REST and SOAP CRUD transactions using JSON and XML formats.

The `Tracker` class expects three arguments: `type`, `klass`, and either a `request` or `response`.

- `type` is which protocol is being used. This can be either `:rest` or `:soap`
- `klass` is the class name from which the transaction was handled. This is used for building the directory tree where  the request/response files will be stored.
- `request` or `response` is set to the request or response object to be written to the timestamped request or response file. It can be either a string or an object that responds to the method `body`.

When `track` is called on the `Tracker` instance, CrudInspector will create a timestamped file of the request or response contents.

```
  CrudInspector::Tracker.new(type: :soap, klass: self.class, response: response).track
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'crud_inspector'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install crud_inspector
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
