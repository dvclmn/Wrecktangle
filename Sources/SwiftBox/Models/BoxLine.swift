//
//  Line.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//


/// Currently this library can only handle horizontal dividers, not vertical.
/// So processing line-by-line, vertically, is fairly strightforward.
///
public enum BoxLine {
  
  case structure(Structure)
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
  public var caps: (SwiftBox.BoxPart, SwiftBox.BoxPart) {
    switch self {
        
      case .structure(.top):
        (
          SwiftBox.BoxPart.corner(.topLeading),
          SwiftBox.BoxPart.corner(.topTrailing)
        )
        
      case .structure(.divider):
        (
          SwiftBox.BoxPart.join(.leading),
          SwiftBox.BoxPart.join(.trailing)
        )
        
      case .structure(.bottom):
        (
          SwiftBox.BoxPart.corner(.bottomLeading),
          SwiftBox.BoxPart.corner(.bottomTrailing)
        )
        
      case .text(.header), .text(.content):
        (
          SwiftBox.BoxPart.vertical(.exterior),
          SwiftBox.BoxPart.vertical(.exterior)
        )
        
        
    }
  } // END caps
  

  
  
  public enum Cap {
    case leading
    case trailing
  }
  
  public func cap(
    _ end: Cap,
    from glyphSet: SwiftBox.Theme.GlyphSet
  ) -> Character {
    
    //      var glyphCount: BoxPart.GlyphCount {
    //        return config.extraFrame ? .double : .single
    //      }
    //
    switch end {
      case .leading:
        
        let leading = self.caps.0.character(from: glyphSet)
//        print("Leading cap: \(leading)")
        return leading
        
      case .trailing:
        
        let trailing = self.caps.1.character(from: glyphSet)
//        print("Trailing cap: \(trailing)")
        return trailing
        
    }
  } // END cap
}
