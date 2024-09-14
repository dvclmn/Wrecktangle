//
//  Theme+Shadow.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//



public extension SwiftBox.Theme {
  
  struct Shadow {
    var type: ShadowType
    var lightSource: SwiftBox.LightSource
    var strength: ShadowStrength
    
    public init(
      type: ShadowType = .simple,
      lightSource: SwiftBox.LightSource = .topTrailing,
      strength: ShadowStrength = .light
    ) {
      self.type = type
      self.lightSource = lightSource
      self.strength = strength
    }
  }
}

public extension SwiftBox.Theme.Shadow {
  
  /// What do we need to know to create a shadow for a side?
  ///
  /// 1. Dimensions — only 1x character high for text lines, but need
  /// height to make sure I match structural lines
  /// 2. Whether it repeats horizontally
  /// 3. Alignment based on light source
  ///
  
  
  /// Referring to horizontal space only
  ///
  var reservedSpace: Int {
    switch type {
      case .simple:
        1
      case .none:
        0
    }
  }
  

  
  enum ShadowType {
    case simple
    case none
  } // END shadow type
  

  
  enum ShadowStrength {
    case light
    case medium
    case dark
    
    public var character: Character {
      switch self {
        case .light:
          "░"
        case .medium:
          "▒"
        case .dark:
          "▓"
      }
    }
  }

}

public extension SwiftBox {
  
  enum LightSource {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
    
  } // END light source
}

//public extension SwiftBox {
//  
//  enum BoxSide {
//    case top
//    case bottom
//    case leading
//    case trailing
//    
//    /// Depending on which side of the box the shadow needs to
//    /// be drawn on, the shadow may repeat, or act as a line cap.
//    ///
//    public var shadowMode: ShadowMode {
//      switch self {
//        case .top, .bottom:
//            .repeating
//        case .leading, .trailing:
//            .cap
//      }
//    }
//    
//
//    public enum ShadowMode {
//      case cap
//      case repeating
//    }
//    
//  }
//  
//}
