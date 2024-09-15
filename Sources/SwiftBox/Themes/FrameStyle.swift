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
    case intertwined

    public var reservedDimensions: SwiftBox.Dimensions {
      
      let dimensions: SwiftBox.Dimensions
      
      switch self {
        case .single:
          
          // 1x1
          let width: Int = 1 + 1 // One character either side
          let height: Int = 1
          
          dimensions = .init(width, height)

        case .double, .intertwined:
          
          // 3x2
          let width: Int = 3 + 3 // One character either side
          let height: Int = 2
          
          dimensions = .init(width, height)
      } // END switch
      
      return dimensions
    }

  }
}
