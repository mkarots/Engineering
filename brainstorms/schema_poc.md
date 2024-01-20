A producer process wants to send a message to a consumer process.
The processes might not operate on the same language so, for example the Producer might be in go
whereas the consumer might be written in C++.

Both processes can be configurated with a set of parameters.
The processes need to agree on a message exchange protocol.



# Use case
## A Simulation runs that outputs a single float32 number. i.e simulate function f(t) = 2 * t for i in {1, 5}.
## The Producer would have to create output messages with the above values. The messages exchanged might look like this

## Messages
```
{
    version: 0.0.1
    timestamp: 1,
    component_id: 1001,
    value = 1,
},
{
    version: 0.0.1
    timestamp: 2,
    component_id: 1001,
    value = 2
},
{
    version: 0.0.1
    timestamp: 3,
    component_id: 1001,
    value = 3
},
{
    version: 0.0.1
    timestamp: 4,
    component_id: 1001,
    value = 4
},
{
    version: 0.0.1
    timestamp: 5,
    component_id: 1001,
    value = 5
}
```

### Message Proto
```golang

message := Message{
    version: "0.0.1",
    timestamp: 1,
    component_id: 1001,
    values: {

    }
}

message Message{
    string version = 1;
    uint64 timestamp = 2;
    uint64 component_id = 3;
    Values values = 4;
}

message Values {
    map<string, Value>
}

message Value {
    onoef value {
        uint32
        float32
        bool
        string
        byte
        repeated byte
    }
}
```



## Message Schema

```
syntax = 'proto3'

message Field {
    oneof kind {
        IntegerField
        FloatField
        StringField
        ByteField
    }
}
message Message{
    version string
    map<string, Field> fields
}

message IntegerField {
    map<string, IntegerValue> field = 1;
}
message FloatField {
    map<string, FloatValue> field = 1;
}
message StringField {
    map<string, StringValue> field = 1;
}
message ByteField {
    map<string, ByteValue> field = 1;
}```
