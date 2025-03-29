---
layout: Story
tags: Swift
lastModified: 2020-03-30 16:37:21
---

# Confusing extensions in Swift

This post is a little bit the information aggregator. 🙃 If you find a mistake, you could write to me about it I really appreciate that. Have a nice read.

## Example with JSONDecoder

What would happen if we run the following piece of code?

```swift
struct Test<T>: Codable where T: Codable {
    enum CodingKeys: String, CodingKey {
        case value
    }
    
    let value: T
    let info: String
}

extension Test {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(T.self, forKey: .value)
        self.info = "Default init(from decoder:)"
    }
}

extension Test where T == String {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(T.self, forKey: .value)
        self.info = "Custom init(from decoder:)"
    }
}

let data = #"{"value":"Hello, World!"}"#.data(using: .utf8)!
let object = try? JSONDecoder().decode(Test<String>.self, from: data)
print(object.debugDescription)
```

Try thinking for 5 seconds about the result. 🤔

```swift
Optional(
    Test<String>(
        value: "Hello, World!", 
        info: "Default init(from decoder:)"
    )
)
```

## Why did it happen?

The `JSONDecoder:decode` definition looks like

```swift
func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
```

We see the `generic function` and also the metatype `T.Type`. I’m not focusing your attention on those two definitions by accident. We should understand these structures of language.

You could read more about metatypes:
- Swift documentation
- What’s .self, .Type and .Protocol?

Consider the example with metatype.

```swift
protocol TestProtocol {
    var info: String { get }
    init(from value: Codable)
}

struct Test<T: Codable>: TestProtocol {
    let value: T
    let info: String
}

extension Test {
    init(from value: Codable) {
        self.value = value as! T
        self.info = "Default init(value:)"
    }
}

extension Test where T == String {
    init(from value: Codable) {
        self.value = value as! T
        self.info = "Custom init(value:)"
    }
}

let type: TestProtocol.Type = Test<String>.self
print(type.init(from: "Hello, World!").info)
```

We’ll get the `"Default init(value:)"`. The reason is the second `init(from value: Codable)` not requirements of such protocol because for the swift compiler it’s just another method. However, it’s overloading of the method for us.

These methods calls `static` (it isn’t about `static func`). Generally, the `Static dispatch` works here - the swift compiler discribes how a programm will select which implementation of a method on the compile time.

You will see that if you build a [Swift Intermediate Language (SIL)](https://github.com/swiftlang/swift/blob/main/docs/SIL/SIL.md#sil-in-the-swift-compiler) file by the example.

```swift
> swiftc -emit-sil example.swift > example.swift.sil
```

> No polymorphism for static methods.

Where a same problem could be in `JSONDecoder:decode`? If we see how it works, we will find the reason. The next code from the official repository:

```swift
open func decode<T : Decodable>(_ type: T.Type, from data: Data) throws -> T {
    let topLevel: Any
    do {
        topLevel = try JSONSerialization.jsonObject(with: data)
    } catch {
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: error))
    }

    let decoder = __JSONDecoder(referencing: topLevel, options: self.options)
    guard let value = try decoder.unbox(topLevel, as: type) else {
        throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: [], debugDescription: "The given data did not contain a top-level value."))
    }

    return value
}

// MARK: - Concrete Value Representations
private extension __JSONDecoder {
    
    ...

    func unbox<T : Decodable>(_ value: Any, as type: T.Type) throws -> T? {
        return try unbox_(value, as: type) as? T
    }

    func unbox_(_ value: Any, as type: Decodable.Type) throws -> Any? {
        ... {
            return try type.init(from: self)
        }
    }
}
```

You would think a problem will be when the `unbox_` called, but the situation a little bit complicated.
Consider another example:

```swift
func generate<T: TestProtocol, Value: Codable>(value: Value, as type: T.Type) -> T {
    type.init(from: value)
}

print(generate(value: "Hello, World!", as: Test<String>.self).info)
```

We’ll get the `"Default init(value:)"` again. What will we see in the SIL code for the `generate` function?

```swift
// generate<A, B>(value:as:)
sil hidden @$s5test28generate5value2asxq__xmtAA12TestProtocolRzSeR_SER_r0_lF : $@convention(thin) <T, Value where T : TestProtocol, Value : Decodable, Value : Encodable> (@in_guaranteed Value, @thick T.Type) -> @out T {
// %0                                             // user: %9
// %1                                             // users: %7, %3
// %2                                             // users: %9, %4
bb0(%0 : $*T, %1 : $*Value, %2 : $@thick T.Type):
  debug_value_addr %1 : $*Value, let, name "value", argno 1 // id: %3
  debug_value %2 : $@thick T.Type, let, name "type", argno 2 // id: %4
  %5 = alloc_stack $Decodable & Encodable         // users: %10, %9, %6
  %6 = init_existential_addr %5 : $*Decodable & Encodable, $Value // user: %7
  copy_addr %1 to [initialization] %6 : $*Value   // id: %7
  %8 = witness_method $T, #TestProtocol.init!allocator.1 : <Self where Self : TestProtocol> (Self.Type) -> (Decodable & Encodable) -> Self : $@convention(witness_method: TestProtocol) <τ_0_0 where τ_0_0 : TestProtocol> (@in Decodable & Encodable, @thick τ_0_0.Type) -> @out τ_0_0 // user: %9
  %9 = apply %8<T>(%0, %5, %2) : $@convention(witness_method: TestProtocol) <τ_0_0 where τ_0_0 : TestProtocol> (@in Decodable & Encodable, @thick τ_0_0.Type) -> @out τ_0_0
  dealloc_stack %5 : $*Decodable & Encodable      // id: %10
  %11 = tuple ()                                  // user: %12
  return %11 : $()                                // id: %12
} // end sil function '$s5test28generate5value2asxq__xmtAA12TestProtocolRzSeR_SER_r0_lF'
```

As we see the `generate` function works with `TestProtocol.init`. Why? You could read the small article about the [Abstract Difference of SIL Types](https://github.com/swiftlang/swift/blob/main/docs/SIL/Types.md#abstraction-difference). I just show you three base things about generics’ working as I’ve understood this:

- Don’t generate a different copy of generic function for every unconstrained type.
- Don’t give every type in the language a common representation.
- Don’t dynamically construct a call to generator depending on an unconstrained type.

I hope this information will help you. 😃

## References

- [What’s .self, .Type and .Protocol?](https://swiftrocks.com/whats-type-and-self-swift-metatypes.html)
- [WWDC 2015: Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/play/wwdc2015/408/)
- [WWDC 2016: Understanding Swift Performance](https://developer.apple.com/videos/play/wwdc2016/416/)
- [Swift Protocol Extensions Method Dispatch](https://medium.com/@leandromperez/protocol-extensions-gotcha-9ef1a42c83b6#2347)
- [Static vs Dynamic Dispatch in Swift: A decisive choice](https://medium.com/flawless-app-stories/static-vs-dynamic-dispatch-in-swift-a-decisive-choice-cece1e872d)
- [Swift Intermediate Language (SIL)](https://github.com/swiftlang/swift/blob/main/docs/SIL/SIL.md)
