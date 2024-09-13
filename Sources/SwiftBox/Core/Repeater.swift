//
//  Repeater.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//


public extension SwiftBox {
  enum TrimMethod {
    case leaveSpace
    case crop
  }
  
  static func repeatHorizontally(
    _ content: [[Character]],
    toWidth width: Int,
    trimMethod: TrimMethod = .crop
  ) -> [[Character]] {
    
    guard !content.isEmpty && !content[0].isEmpty else { return [] }
    
    let patternWidth = content[0].count
    let patternHeight = content.count
    
    let repetitions = width / patternWidth
    let remainder = width % patternWidth
    
    var result: [[Character]] = Array(repeating: [], count: patternHeight)
    
    for row in 0..<patternHeight {
      for _ in 0..<repetitions {
        result[row].append(contentsOf: content[row])
      }
      
      if remainder > 0 {
        switch trimMethod {
          case .leaveSpace:
            result[row].append(contentsOf: content[row][0..<remainder])
            result[row].append(contentsOf: Array(repeating: " ", count: patternWidth - remainder))
          case .crop:
            result[row].append(contentsOf: content[row][0..<remainder])
        }
      }
    }
    
    return result
  }
}
