//
//  TextCore.swift
//  SwiftBox
//
//  Created by Dave Coleman on 27/8/2024.
//

/// Common operations
///
/// 1. Find just enough whitespace to fill out a row of character to x-length
///

public extension String {
  func padLine(
    with paddingString: String = " ",
    toFill width: Int,
    sliceCharacter: Character = "@"
  ) -> String {
    
    let components = self.split(separator: sliceCharacter, omittingEmptySubsequences: false)
    let contentLength = components.reduce(0) { $0 + $1.count }
    let availableSpace = max(0, width - contentLength)
    
    if components.count <= 1 {
      return self + String(repeating: paddingString, count: availableSpace)
    }
    
    let spacesPerSlice = availableSpace / (components.count - 1)
    let extraSpaces = availableSpace % (components.count - 1)
    
    var result = ""
    
    for (index, component) in components.enumerated() {
      result += component
      if index < components.count - 1 {
        let spaces = spacesPerSlice + (index < extraSpaces ? 1 : 0)
        result += String(repeating: " ", count: spaces)
      }
    }
    
    return result
  }
}
