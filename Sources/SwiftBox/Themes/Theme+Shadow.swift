//
//  Theme+Shadow.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//



public extension SwiftBox.Theme {
  
  struct BoxShadow {
    var type: ShadowType
    var lightSource: LightSource
    var strength: ShadowStrength
    
    public init(
      type: ShadowType = .simple,
      lightSource: LightSource = .topTrailing,
      strength: ShadowStrength = .light
    ) {
      self.type = type
      self.lightSource = lightSource
      self.strength = strength
    }
  }
}

public extension SwiftBox.Theme.BoxShadow {
  
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
  
  func sideHasShadow(_ side: SwiftBox.BoxSide) -> Bool {
    
    guard self.type != .none else { return false }

    switch side {
      case .top, .bottom:
        return side == self.lightSource.shadowedSides.vertical
      case .leading, .trailing:
        return side == self.lightSource.shadowedSides.horizontal
    }
  }
  
  enum ShadowType {
    case simple
    case none
  } // END shadow type
  
  enum LightSource {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
    
    var shadowedSides: (vertical: SwiftBox.BoxSide, horizontal: SwiftBox.BoxSide) {
      switch self {
        case .topLeading:
          return (.bottom, .trailing)
        case .topTrailing:
          return (.bottom, .leading)
        case .bottomLeading:
          return (.top, .trailing)
        case .bottomTrailing:
          return (.top, .leading)
      }
    }
    
  } // END light source
  
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
  
  
//  func shadow(for side: SwiftBox.BoxSide) -> String {
//    
//    var shadowWidth: Int {
//      let width: Int
//      switch side.shadowMode {
//        case .repeating:
//          width = boxWidth()
//        case .cap:
//          width = 1
//      }
//    }
//    
//    var shadowHeight: Int {
//      
//    }
//    
//    
//    switch side {
//      case .top:
//        <#code#>
//      case .bottom:
//        <#code#>
//      case .leading:
//        <#code#>
//      case .trailing:
//        <#code#>
//    }
//    
//    
//    switch shadow.lightSource {
//      case .topLeading:
//      case .topTrailing:
//      case .bottomLeading:
//      case .bottomTrailing:
//    }
//  }
  
  
  enum BoxSide {
    case top
    case bottom
    case leading
    case trailing
    
    /// Depending on which side of the box the shadow needs to
    /// be drawn on, the shadow may repeat, or act as a line cap.
    ///
    public var shadowMode: ShadowMode {
      switch self {
        case .top, .bottom:
            .repeating
        case .leading, .trailing:
            .cap
      }
    }
    

    public enum ShadowMode {
      case cap
      case repeating
    }
    
  }
  
}
