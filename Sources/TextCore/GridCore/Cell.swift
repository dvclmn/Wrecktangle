//
//  CellSize.swift
//  SwiftBox
//
//  Created by Dave Coleman on 28/8/2024.
//

import SwiftUI

extension GlyphCell {
  
  public static let example: GlyphCell = GlyphCell(fontName: "Menlo", fontSize: 15)
  
  //  private static func calculateCellSize(
  //    fontName: String,
  //    fontSize: CGFloat
  //  ) -> CGSize {
  //
  //  }
  
  /// For when the font is the same, but the zoom has changed.
  ///
  /// `mutating` means that this function can update `self.cellSize`
  /// even though this is a struct.
  ///
  public mutating func updateCellSizeForZoom(
    _ zoom: CGFloat
  ) {
    let newWidth = size.width * zoom
    let newHeight = size.height * zoom
    self.size = CGSize(width: newWidth, height: newHeight)
  }
  
  /// For when the font is being updated, and zoom is unchanged
  ///
  public mutating func updateFont(
    fontName: String,
    fontSize: CGFloat
  ) {

    size = GlyphCell.calculateCellSize(fontName: fontName, fontSize: fontSize)
    
  }
  


  /// Get cell size when you don't yet have the `NSFont`
  ///
  static func calculateCellSize(
    fontName: String,
    fontSize: CGFloat = 14,
    zoom: CGFloat? = nil,
    minWidth: CGFloat = 1.5
  ) -> CGSize {
    
    guard let (nsFont, ctFont) = getFonts(fontName: fontName, fontSize: fontSize) else { return .zero }
    
    let size: CGSize = calculateCellSize(for: nsFont, zoom: zoom ?? 1.0, minWidth: minWidth)
    
    return size
    
  }
  
  /// Returns both an NSFont and CTFont, for a given name and size
  ///
  private static func getFonts(
    fontName: String,
    fontSize: CGFloat = 14
  ) -> (NSFont, CTFont)? {
    
    guard let nsFont = NSFont.init(name: fontName, size: fontSize) else { return nil }
    
    let ctFont = nsFont as CTFont
    
    let fontMetrics: String = """
      Cap height: \(nsFont.capHeight)
      Point size: \(nsFont.pointSize)
      Ascender height: \(nsFont.ascender)
      Fixed pitch?: \(nsFont.isFixedPitch)
      Leading value: \(nsFont.leading)
      Whole font rect: \(nsFont.boundingRectForFont)
      """
    
    print(fontMetrics)
    
    return (nsFont, ctFont)
  }
  
  /// Get cell size when already have the `NSFont`. This is useful in that it
  /// provides a way to perform the size claculation *without* the performance
  /// hit of obtaining the right font.
  ///
  static func calculateCellSize(
    for font: NSFont,
    zoom: CGFloat,
    minWidth: CGFloat = 1.5
  ) -> CGSize {
    
    let ctFont = font as CTFont
    
    guard let cgGlyph = getGlyphForCharacter(font: ctFont) else {
      print("Couldn't get CGGlyph")
      return .zero
    }
    
    let glyphWidth: CGFloat = font.advancement(forCGGlyph: cgGlyph).width
    
    let glyphHeight: CGFloat = font.ascender - font.descender + font.leading
    
    let finalWidth: CGFloat = glyphWidth * zoom
    let finalHeight: CGFloat = glyphHeight * zoom
    
    let size = CGSize(width: max(minWidth, finalWidth), height: max(minWidth, finalHeight))
    print("Here is the final cell size: \(size)")
    
    return size
  }
  
  
  private static func getGlyphForCharacter(
    _ character: Character = "M",
    font: CTFont
  ) -> CGGlyph? {
    
    guard let scalar = character.unicodeScalars.first else { return nil }
    let char = UniChar(scalar.value)
    var glyph = CGGlyph(0)
    let result = CTFontGetGlyphsForCharacters(font, [char], &glyph, 1)
    
    return result ? glyph : nil
  }
  
 
} // END glyph cell extension
