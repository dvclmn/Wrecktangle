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
    /// in the horizontal and vertical dimension, including a space each side.
    ///
    public var reservedSpace: Int {
      switch self {
        case .single:       4
        case .double:       6
        case .shadow:       6
        case .intertwined:  6
      }
    }
  }
}
