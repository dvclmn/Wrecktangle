//
//  Part+Corner.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//

public extension SwiftBox.BoxPart {
  
  enum Corner: Hashable {
    /// ┏
    case topLeading
    /// ┓
    case topTrailing
    /// ┗
    case bottomLeading
    /// ┛
    case bottomTrailing
    
    func part(mode: PartMode) -> String {
      switch self {
        case .topLeading:
          
          var result = ""
          
          switch mode {
            case .oneByOne:
              
              
            case .threeByTwo:
          }
          
          return result
          
        case .topTrailing:
          return ""
          
        case .bottomLeading:
          return ""
          
        case .bottomTrailing:
          return ""
          
      }
    }
    
  }
}
