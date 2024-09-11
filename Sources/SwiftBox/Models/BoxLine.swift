//
//  Line.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//


/// Currently this library can only handle horizontal dividers, not vertical.
/// So processing line-by-line, vertically, is fairly strightforward.
///
public extension SwiftBox {
  
  enum BoxLine {
    
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

    public enum Cap {
      case leading
      case trailing
    }
    
    
  }

  
  /// Leading and trailing line caps
  ///
  func caps(for lineType: SwiftBox.BoxLine) -> (leading: SwiftBox.BoxPart, trailing: SwiftBox.BoxPart) {
    switch lineType {
        
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
  
  func cap(
    _ end: BoxLine.Cap,
    line: BoxLine
  ) -> Character {
    
    //      var glyphCount: BoxPart.GlyphCount {
    //        return config.extraFrame ? .double : .single
    //      }
    //
    switch end {
      case .leading:
        
        let cap = self.caps(for: line).leading
        let leading = self.character(for: cap)
        //        print("Leading cap: \(leading)")
        return leading
        
      case .trailing:
        
        let cap = self.caps(for: line).trailing
        let trailing = self.character(for: cap)
        //        print("Leading cap: \(leading)")

        return trailing
        
    }
  } // END cap
}
