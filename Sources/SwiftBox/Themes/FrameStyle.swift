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
    
    public var resolution: SwiftBox.BoxPart.Resolution {
      switch self {
        case .single:
            .oneByOne
        case .double, .shadow, .intertwined:
            .threeByTwo
      }
    }
  }
}
