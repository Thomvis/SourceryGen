//
//  CodeBuilder.swift
//  SourceryGen
//
//  Created by Thomas Visser on 04/03/2021.
//

import Foundation

@_functionBuilder
public struct CodeBuilder {
    public static func buildBlock<Content>(_ c: Content) -> Content {
        c
    }

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> CodeList<(C0, C1)> {
        CodeList(value: (c0, c1))
    }

    // Doesn't work yet?
    public static func buildArray<Content>(_ cs: [Content]) -> CodeList<[Content]> {
        CodeList(value: cs)
    }
}
