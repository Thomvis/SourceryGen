//
//  File.swift
//  
//
//  Created by Thomas Visser on 04/03/2021.
//

import Foundation
import SourceryRuntime

public protocol Renderable {
    func render() -> String
}

public protocol GeneratedCode: Renderable {
    associatedtype Code: GeneratedCode
    var code: Code { get }
}

protocol BuiltinGeneratedCode {
    func renderBuiltin() -> String
}

extension GeneratedCode where Code == Never {
    public var code: Never { fatalError("This should never be called.") }
}

extension Never: GeneratedCode {
    public typealias Code = Never
}

extension GeneratedCode {
    public func render() -> String {
        if let builtin = self as? BuiltinGeneratedCode {
            return builtin.renderBuiltin()
        } else {
            return code.render()
        }
    }
}

public protocol SourceFile {
    associatedtype Code: GeneratedCode
    @CodeBuilder
    func generate(_ types: SourceryRuntime.Types) -> Code
}

public extension SourceFile {
    func render(_ types: SourceryRuntime.Types) -> String {
        generate(types).render()
    }
}

public struct Scope<Content>: GeneratedCode, BuiltinGeneratedCode where Content: GeneratedCode {

    let name: String
    let content: () -> Content

    public init(_ name: String, @CodeBuilder _ content: @escaping () -> Content) {
        self.name = name
        self.content = content
    }

    func renderBuiltin() -> String {
        "\(name) {\n\t" + content().render().replacingOccurrences(of: "\n", with: "\n\t") + "\n}"
    }
}

extension String: GeneratedCode, BuiltinGeneratedCode {
    func renderBuiltin() -> String {
        self
    }
}

public struct CodeList<T>: GeneratedCode, BuiltinGeneratedCode {
    let value: T

    func renderBuiltin() -> String {
        // Is this how the SwiftUI sausage is made?
        let mirror = Mirror(reflecting: value)
        return mirror.children
            .compactMap { $0.value as? Renderable }
            .map { $0.render() }.joined(separator: "\n")
    }
}

public struct ForEach<Element, Content>: GeneratedCode, BuiltinGeneratedCode where Content: GeneratedCode {

    let data: [Element]
    let content: (Element) -> Content

    public init(_ data: [Element], @CodeBuilder _ content: @escaping (Element) -> Content) {
        self.data = data
        self.content = content
    }

    func renderBuiltin() -> String {
        data.map { content($0).render() }.joined(separator: "\n")
    }

}

//infix operator --
//
//public func --<Content>(lhs: String, rhs: @escaping () -> Content) -> Scope<Content> where Content: GeneratedCode {
//    Scope(lhs, rhs)
//}
