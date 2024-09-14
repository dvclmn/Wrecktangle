//
//  Repeater.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

import TextCore

public extension SwiftBox {

  
  static func repeatHorizontally(
    _ part: BoxPart,
    toWidth width: Int,
    trimMethod: TrimMethod = .crop
  ) -> MultilineString {
    
    guard !part.content.isEmpty && !part.content[0].isEmpty else { return [] }
    
    let patternWidth = part.content[0].count
    let patternHeight = part.content.count
    
    let repetitions = width / patternWidth
    let remainder = width % patternWidth
    
    var result: MultilineString = Array(repeating: [], count: patternHeight)
    
    for row in 0..<patternHeight {
      for _ in 0..<repetitions {
        result[row].append(contentsOf: part.content[row])
      }
      
      if remainder > 0 {
        switch trimMethod {
          case .leaveSpace:
            result[row].append(contentsOf: part.content[row][0..<remainder])
            result[row].append(contentsOf: Array(repeating: " ", count: patternWidth - remainder))
          case .crop:
            result[row].append(contentsOf: part.content[row][0..<remainder])
        }
      }
    }
    
    return result
  }
}
