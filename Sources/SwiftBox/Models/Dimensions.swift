//
//  Dimensions.swift
//  SwiftBox
//
//  Created by Dave Coleman on 15/9/2024.
//

public extension SwiftBox {
  
  protocol FixedDimension {
    var value: Int { get }
  }
  
  struct Dimensions {
    var width: DimensionType
    var height: DimensionType
    
    init(_ width: DimensionType, _ height: DimensionType) {
      self.width = width
      self.height = height
    }
    
    init(_ width: Int, _ height: Int) {
      self.width = .fixed(.init(width))
      self.height = .fixed(.init(height))
    }
    
  }

  enum DimensionType {
    case fixed(Int)
    case repeatable(min: Int, max: Int?)
    
    var fixedValue: Int? {
      switch self {
        case .fixed(let value):
          return value
        case .repeatable:
          return nil
      }
    }
  }

  
  
  func expectedDimensions(for part: SwiftBox.PartType) -> SwiftBox.Dimensions {
    
    /// This will only return a value for dimensions with a `DimensionType` of `.fixed()`.
    /// I'm sure there is a better way to handle this, I'll get to it.
    ///
    let maxPartWidth: Int = theme.frameStyle.maximumGridSize.width.value
    let maxPartHeight: Int = theme.frameStyle.maximumGridSize.height.value
    
    let dimensions: SwiftBox.Dimensions
    
    switch theme.frameStyle {
      case .single:
        dimensions = SwiftBox.Dimensions(maxPartWidth, maxPartHeight)
        
      case .double:
        
        switch part {
          case .horizontal:
            
            dimensions = SwiftBox.Dimensions(.repeatable(min: 1), .fixed(reservedHeight))
            
          case .vertical:
            
            dimensions = SwiftBox.Dimensions(.repeatable(min: 1), .fixed(reservedHeight))
            
            return SwiftBox.Dimensions(.fixed(1), .repeatable(min: 1))
          case .cornerTopLeading, .cornerTopTrailing, .cornerBottomLeading, .cornerBottomTrailing:
            return Dimensions(.fixed(1), .fixed(1))
            
            
          case .vertical(let verticalLocation):
            <#code#>
          case .joinLeading:
            <#code#>
          case .joinTrailing:
            <#code#>
          case .joinTop:
            <#code#>
          case .joinBottom:
            <#code#>
          case .joinCross:
            <#code#>
          case .cornerTopLeading:
            <#code#>
          case .cornerTopTrailing:
            <#code#>
          case .cornerBottomLeading:
            <#code#>
          case .cornerBottomTrailing:
            <#code#>
        }
        
      case .intertwined:
        
        
        
    } // END frame style switch
    
    return dimensions
    
    
    
  }

}

extension SwiftBox.DimensionType: SwiftBox.FixedDimension {
  
  /// Warning: This will cause a fatal error if accessed for a
  /// variable-width (aka `repeatable`) dimension type.
  ///
  public var value: Int {
    switch self {
      case .fixed(let value):
        return value
      case .repeatable:
        fatalError("Cannot get fixed value from a repeatable dimension")
    }
  }
}
