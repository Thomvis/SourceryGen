//
//  File.swift
//  
//
//  Created by Thomas Visser on 04/03/2021.
//

import Foundation
import SourceryGen
import SourceryRuntime

struct AutoEnumIsCase: SourceFile {
    func generate(_ types: Types) -> some GeneratedCode {
        ForEach(types.enums) { t in
            Scope("extension \(t.name)") {
                ForEach(t.cases) { c in
                    Scope("var is\(c.name.capitalized): Bool") {
                        Scope("if case .\(c.name) = self") {
                            "return true"
                        }
                        "return false"
                    }
                }
            }
        }
    }
}
