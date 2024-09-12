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
    
    /// This is the number of characters used to construct this style of frame,
    /// in the horizontal and vertical dimension. This does not include any
    /// space characters, this is handled by the `Theme`s `padding` property.
    ///
    /// This could be improved upon by utilising the
    /// `SwiftBox.BoxGlyph.Resolution` type.
    ///
//    public var reservedSpace: Int {
//      switch self {
//        case .single:       2
//        case .double:       6
//        case .shadow:       4
//        case .intertwined:  4
//      }
//    }
    
    public var resolution: SwiftBox.PartPreset.Resolution {
      switch self {
        case .single:
            .oneByOne
        case .double, .shadow, .intertwined:
            .threeByTwo
      }
    }
  }
}
