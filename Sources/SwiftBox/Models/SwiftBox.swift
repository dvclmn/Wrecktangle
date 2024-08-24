//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

public struct SwiftBox {
  
  public typealias Config = Configuration
  public typealias Line = BoxLine
  public typealias GlyphStyle = Theme.GlyphStyle
  
  var header: String
  var content: String
  var config: Config
  
  var attributedString: AttributedString {
    return self.drawBox()
  }
  
  public init(
    header: String,
    content: String,
    config: Config = .init()
  ) {
    self.header = header
    self.content = content
    self.config = config
  }
  
  /// Currently this implementaiton can only handle horizontal dividers, not vertical.
  /// So we can process line-by-line vertically in a fairly straightforward way.
  ///
  public enum BoxLine {
    
    case structure(Line.Structure)
    case text(Line.Text)
    
    public enum Structure {
      case top
      case divider
      case bottom
    }
    
    public enum Text {
      case header
      case content
    }
    
    /// Leading and trailing line caps
    ///
    public var caps: (Part, Part) {
      switch self {
          
        case .structure(.top):
          (
            Part.corner(.top(.leading)),
            Part.corner(.top(.trailing))
          )

        case .structure(.divider):
          (
            Part.join(.leading),
            Part.join(.trailing)
          )
          
        case .structure(.bottom):
          (
            Part.corner(.bottom(.leading)),
            Part.corner(.bottom(.trailing))
          )
          
        case .text(.header), .text(.content):
          (
            Part.vertical(.exterior),
            Part.vertical(.exterior)
          )
         
          
      }
    } // END caps
    
    public func repeatableString(for config: Config) -> String {
      
      let horizontalExterior: String = Part.horizontal(.exterior).character(with: config).asString
      
      let horizontalInterior: String = Part.horizontal(.interior).character(with: config).asString
      
      switch self {
          
        case .structure(.top):
          return horizontalExterior
          
        case .structure(.divider):
          return horizontalInterior
          
        case .structure(.bottom):
          return horizontalExterior
          
        case .text(.header), .text(.content):
          return ""
      }
    }
    
    
    public enum Cap {
      case leading
      case trailing
    }
    
    public func cap(
      _ end: Cap,
      with config: Config
    ) -> AttributedString {
      
//      var glyphCount: Part.GlyphCount {
//        return config.extraFrame ? .double : .single
//      }
//      
      let container = config.theme.colour.secondary.container
      switch end {
        case .leading:
          return self.caps.0.character(with: config, container: container)
        case .trailing:
          return self.caps.1.character(with: config, container: container)

      }
    } // END cap
  }
  
  

  
}
