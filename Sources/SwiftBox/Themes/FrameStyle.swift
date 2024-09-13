//
//  FrameStyle.swift
//  SwiftBox
//
//  Created by Dave Coleman on 24/8/2024.
//

public extension SwiftBox.Theme {
  
  enum FrameStyle {
    case single
    case double
    case shadow
    case intertwined
    
    // TODO: I think I need to 'enforce a promise' in the package, regarding permitted width of leading and trailing caps, so that this value is reliable
    public var reservedWidth: Int {
      switch self {
        case .single:
          1 + 1 // One character either side
          
        case .double, .shadow, .intertwined:
          3 + 3 // Three characters either side
      }
    }
  }
}
