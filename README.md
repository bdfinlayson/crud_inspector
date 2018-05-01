# CrudInspector
Keeps a record of recent CRUD transactions by REST or SOAP protocol. CrudInspector will create a timestamped file of the request or response contents for later reference. This is helpful for projects using many external APIs that must share copies of requests and responses with clients for debugging purposes.

## Usage
`CrudInspector::Tracker` currently supports REST and SOAP CRUD transactions using JSON and XML formats.

The `Tracker` class expects three arguments: `type`, `klass`, and either a `request` or `response`.

- `type` is which protocol is being used. This can be either `:rest` or `:soap`
- `klass` is the class name from which the transaction was handled. This is used for building the directory tree where  the request/response files will be stored.
- `request` or `response` is set to the request or response object to be written to the timestamped request or response file. It can be either a string or an object that responds to the method `body`.

When `track` is called on the `Tracker` instance, CrudInspector will create a timestamped file of the request or response contents. By default these files are placed in a `crud_tracking` directory at the root of the project.

Example usage:
```
  CrudInspector::Tracker.new({type: :rest, klass: self.class, request: request}).track
```

```
  CrudInspector::Tracker.new(type: :soap, klass: self.class, response: response).track
```

If the above call was tracking a response from a SOAP endpoint, the corresponding output might look something like this:

```
cat crud_tracking/services/soap/my_soap_service/2018-04-30_15h_55m_49s_response.xml
```

```
CREATED AT: 2018-04-30_15h_55m_49s
RESPONSE CODE: 200

RESPONSE:
<?xml version='1.0' encoding='UTF-8'?>
<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'>
  <soapenv:Body>
    <getSomethingAwesome xmlns='http://soap.acme.com'>
      <getMyAwesomeThing>
        <soap:getAwesomeNow xmlns:soap='http://myawesomeurl.com'>
          <soap:awesomeMessages>
            <soap:item>
              <soap:awesomeMessage>
                Not so awesome response: You sent an invalid type for field XYZ...
              </soap:awesomeMessage>
              <soap:bummerErrorCode>
                SOMERANDONUMBER1010
              </soap:bummerErrorCode>
            </soap:item>
          </soap:awesomeMessages>
          <soap:returnCode>
            ERROR!!!
          </soap:returnCode>
          <soap:someKindOfEmptyList/>
          <soap:aValueOfSomeKind>
            9999
          </soap:aValueOfSomeKind>
        </soap:getAwesomeNow>
      </getMyAwesomeThing>
    </getSomethingAwesome>
  </soapenv:Body>
</soapenv:Envelope>
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
