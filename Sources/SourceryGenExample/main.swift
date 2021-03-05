//
//  File.swift
//  
//
//  Created by Thomas Visser on 04/03/2021.
//

import Foundation
import SourceryGen
import SourceryRuntime
import SourceryFramework

let input = """
enum Result {
    case success
    case failure
}

enum Async {
    case loading
    case complete(Result)
}
"""

let result = try! makeParser(for: input, path: nil, module: nil).parse()

print(AutoEnumIsCase().render(Types(types: result.types, typealiases: result.typealiases)))
