//
//  PartType.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//

import SwiftUICore
import TextCore

public extension SwiftBox {
  
  enum PartType: Hashable {
    
    case horizontal(HorizontalLocation = .top)
    case vertical(VerticalLocation = .leading)
    case join(JoinType)
    case corner(CornerType)
    
    
    public enum HorizontalLocation: Hashable {
      case top
      case bottom
      case interior // Divider
    }
    
    public enum VerticalLocation: Hashable {
      case leading
      case trailing
      case interior // Divider
    }
    
    public var flexibility: PartFlexibility {
      switch self {
        case .horizontal:
            .repeatable(axis: .horizontal)
          
        case .vertical:
            .repeatable(axis: .vertical)
          
        default:
            .fixed
      }
    }
    
   
    
  } // END part type
  
  
  
  enum LineSegment {
    case capLeading
    case capTrailing
  }
  
  
  enum PartFlexibility {
    case repeatable(axis: Axis)
    case fixed
  }
  
  
}
