//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

public typealias BoxLine = SwiftBox.BoxLine
public typealias GlyphSet = SwiftBox.Theme.GlyphSet
public typealias ColourSet = SwiftBox.Theme.ColourSet
public typealias FrameStyle = SwiftBox.Theme.FrameStyle

public struct SwiftBox {
  
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
    
    case structure(BoxLine.Structure)
    case text(BoxLine.Text)
    
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
    public var caps: (BoxPart, BoxPart) {
      switch self {
          
        case .structure(.top):
          (
            BoxPart.corner(.topLeading),
            BoxPart.corner(.topTrailing)
          )

        case .structure(.divider):
          (
            BoxPart.join(.leading),
            BoxPart.join(.trailing)
          )
          
        case .structure(.bottom):
          (
            BoxPart.corner(.bottomLeading),
            BoxPart.corner(.bottomTrailing)
          )
          
        case .text(.header), .text(.content):
          (
            BoxPart.vertical(.exterior),
            BoxPart.vertical(.exterior)
          )
         
          
      }
    } // END caps
    
    public func repeatableString(for config: Config) -> String {
      
      let horizontalExterior: String = BoxPart.horizontal(.exterior).character(with: config).asString
      
      let horizontalInterior: String = BoxPart.horizontal(.interior).character(with: config).asString
      
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
      
//      var glyphCount: BoxPart.GlyphCount {
//        return config.extraFrame ? .double : .single
//      }
//      
//      let container = config.theme.colour.secondary.container
      switch end {
        case .leading:
          return self.caps.0.character(with: config)
//          return self.caps.0.character(with: config, container: container)
        case .trailing:
          return self.caps.1.character(with: config)
//          return self.caps.1.character(with: config, container: container)

      }
    } // END cap
  }
  
  

  
}
