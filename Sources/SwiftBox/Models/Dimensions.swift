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
      self.width = .fixed(width)
      self.height = .fixed(height)
    }
    
  }
  
//  enum DimensionType {
//    case fixed(Int)
//    case repeatable(min: Int, max: Int? = nil)
//  }
  
  enum DimensionType {
    case fixed(Fixed)
    case repeatable(Repeatable)
    
    public struct Fixed {
      public let value: Int
    }
    
    public struct Repeatable {
      public let min: Int
    }
  }
  
  
  public func expectedDimensions(for part: SwiftBox.PartType) -> SwiftBox.Dimensions {
    
    let reservedWidth: Int = theme.frameStyle.reservedDimensions.width
    let dimensions: SwiftBox.Dimensions
    
    
    switch theme.frameStyle {
      case .single:
        
        
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
  
  //  public func expectedDimensions(for part: SwiftBox.PartType) -> SwiftBox.Dimensions {
  //    switch self {
  //      case .single:
  //
  //
  //
  //      case .double:
  //
  //        let dimensions: SwiftBox.Dimensions
  //
  //        switch part {
  //          case .horizontal:
  //            dimensions = .init((width: Int, height: Int))
  //
  //        }
  //    }
}



extension SwiftBox.DimensionType.Fixed: SwiftBox.FixedDimension {}


extension SwiftBox.DimensionType: SwiftBox.FixedDimension where Self == SwiftBox.DimensionType.Fixed  {
  
  public var value: Int {
    guard case .fixed(let value) = self else {
      fatalError("This should never happen due to the conditional conformance")
    }
    return value
  }
}
