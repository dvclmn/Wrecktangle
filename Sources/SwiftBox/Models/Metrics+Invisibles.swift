//
//  Characters.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation
import SwiftUI

public extension SwiftBox {
  
  enum Invisibles {
    case line
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
        case .line: "¬"
//        case .line(.end): "¶"
        case .space: "/"
        case .tab: "→"
        case .padding: ","
        case .paddingAlt: "."
      }
    }
    
    static public func ifNeeded(
      _ character: Invisibles,
      fallBackCharacter: Character = " ",
      isShowing isShowingInvisibles: Bool
    ) -> Character {
      let result = isShowingInvisibles ? character.character : fallBackCharacter
      
      return result
    }
  }
  
}
