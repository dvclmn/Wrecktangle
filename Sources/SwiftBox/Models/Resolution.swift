//
//  Preset+Resolution.swift
//  SwiftBox
//
//  Created by Dave Coleman on 12/9/2024.
//

import Foundation

public extension SwiftBox.BoxPart {
  
  enum Resolution {
    case oneByOne
    case threeByTwo
    
    var rows: Int {
      switch self {
        case .oneByOne: return 1
        case .threeByTwo: return 2
      }
    }
    
    var columns: Int {
      switch self {
        case .oneByOne: return 1
        case .threeByTwo: return 3
      }
    }
  }
}

extension SwiftBox.BoxPart.Resolution: CustomStringConvertible {
  
  public var description: String {
    switch self {
      case .oneByOne:
        return "1x1"
      case .threeByTwo:
        return "3x2"
    }
  }
}
