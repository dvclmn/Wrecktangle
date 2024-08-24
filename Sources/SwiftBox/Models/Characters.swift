//
//  Characters.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUI

extension SwiftBox {
  

  public enum Invisibles {
    case line(LineType)
    case space
    case tab
    case padding
    case paddingAlt
    
    public enum LineType {
      case new
      case end
    }
    
    public var character: Character {
      switch self {
        case .line(.new): "¬"
        case .line(.end): "¶"
        case .space: "•"
        case .tab: "→"
        case .padding: ","
        case .paddingAlt: "."
      }
    }
  }
 
}

