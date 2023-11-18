---
markmap:
  colorFreezeLevel: 2
  maxWidth: 800
---
# [Encoding data with Go Binary](https://medium.com/learning-the-go-programming-language/encoding-data-with-the-go-binary-package-42c7c0eb3e73)

## [encoding/binary Go docs](https://pkg.go.dev/encoding/binary)

## [streaming IO in Go](https://medium.com/learning-the-go-programming-language/streaming-io-in-go-d93507931185)

## [Let's make an NTP client in GO](https://medium.com/learning-the-go-programming-language/lets-make-an-ntp-client-in-go-287c4b9a969f)

## [Go Walkthrough: encoding/binary](https://medium.com/go-walkthrough/go-walkthrough-encoding-binary-96dc5d4abb5d)


# ChatGPT: Binary Protocols
## Determine the Data Structure:
### Decide what kind of data you need to transmit or store in your binary protocol. This could be structured data like messages, records, or packets.

## Choose a Schema Definition Language:
### **Protocol Buffers (ProtoBuf)**: Developed by Google, ProtoBuf is a widely used binary serialization format with its own schema definition language.
### **Apache Avro**: Avro is a binary data format that can be defined using a JSON-based schema language.
### **MessagePack**: MessagePack is a binary serialization format that doesn't have its own schema language, but you can define your schema in JSON or other data definition languages.
## Write the Schema:

### Use the chosen schema definition language to define your data structure. This typically involves specifying fields, data types, and their order.

### For example, in **Protocol Buffers**, you would write a `.proto` file to define your message structure.
## Generate Code (Optional):

###  Depending on your chosen schema definition language, you may be able to generate code in different programming languages to serialize and deserialize data based on the schema.
###  For example, in **Protocol Buffers**, you can use the **Protocol Buffers** compiler (`protoc`) to generate code in languages like Go, Python, Java, etc.
## Implement Serialization and Deserialization:

### Write code in your chosen programming language to serialize data into the binary format defined by your schema and deserialize binary data back into structured data.
### The implementation varies based on the language and libraries you use. If you generated code in Step 4, use the generated code for serialization and deserialization.
## Test and Validate:

### Test your schema and the serialization/deserialization code to ensure that it correctly encodes and decodes data without loss or corruption.
## Documentation:

### Document your binary protocol schema so that other developers can understand how to use it.
## Versioning (Optional):

### Plan for schema evolution and versioning. Schemas may change over time, so it's essential to have a strategy for backward and forward compatibility.
## Choose Appropriate Libraries:

### Depending on your programming language and protocol, you may need to select suitable libraries or frameworks that support your binary protocol. For instance, if you're using Go, you might use libraries like encoding/binary for low-level binary encoding.
## Optimize for Efficiency (Optional):

### Depending on your use case, you may want to optimize your binary protocol for efficiency in terms of size, parsing speed, or both.


# Examples:

## A simple binary Protocol:
```
+----------------+-----------------+-------------------+
| Message Length | Message Type    | Message Content   |
| (4 bytes)      | (1 byte)        | (variable length) |
+----------------+-----------------+-------------------+
```
```golang
package main

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"log"
)

// Message represents a binary message structure.
type Message struct {
	Length  uint32
	Type    byte
	Content string
}

func main() {
	// Encode a message
	message := Message{
		Length:  19,
		Type:    1,
		Content: "Hello, Binary Protocol!",
	}

	buf := new(bytes.Buffer)
	if err := binary.Write(buf, binary.LittleEndian, &message.Length); err != nil {
		log.Fatal(err)
	}
	if err := binary.Write(buf, binary.LittleEndian, &message.Type); err != nil {
		log.Fatal(err)
	}
	if err := binary.Write(buf, binary.LittleEndian, []byte(message.Content)); err != nil {
		log.Fatal(err)
	}

	// Decode the message
	var decodedMessage Message
	if err := binary.Read(buf, binary.LittleEndian, &decodedMessage.Length); err != nil {
		log.Fatal(err)
	}
	if err := binary.Read(buf, binary.LittleEndian, &decodedMessage.Type); err != nil {
		log.Fatal(err)
	}
	contentBytes := make([]byte, decodedMessage.Length-5)
	if err := binary.Read(buf, binary.LittleEndian, contentBytes); err != nil {
		log.Fatal(err)
	}
	decodedMessage.Content = string(contentBytes)

	// Display the original and decoded messages
	fmt.Printf("Original Message: %+v\n", message)
	fmt.Printf("Decoded Message: %+v\n", decodedMessage)
}

```
