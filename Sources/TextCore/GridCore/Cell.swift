//
//  CellSize.swift
//  SwiftBox
//
//  Created by Dave Coleman on 28/8/2024.
//

import SwiftUI

extension GlyphCell {
  
  public static let example: GlyphCell = GlyphCell(fontName: .menlo)
  

  /// For when the font is the same, but the zoom has changed.
  ///
  /// `mutating` means that this function can update `self.cellSize`
  /// even though this is a struct.
  ///

  
  /// For when the font is being updated, and zoom is unchanged
  ///
  public mutating func updateFont(
    fontName: FontName
  ) {
    size = calculateCellSize(fontName: fontName)
  }
  


  /// Get cell size when you don't yet have the `NSFont`
  ///
  func calculateCellSize(
    fontName: FontName,
    zoom: CGFloat = 1.0,
    minWidth: CGFloat = 1.5
  ) -> CGSize {
    
    print("Calculating cell size, for \(fontName.rawValue)")
    
    guard let (nsFont, _) = getFonts(fontName: fontName.rawValue) else { return .zero }
    
    let size: CGSize = calculateCellSize(for: nsFont, zoom: zoom, minWidth: minWidth)
    
    return size
    
  }
  
  /// Returns both an NSFont and CTFont, for a given name and size
  ///
  private func getFonts(
    fontName: String
  ) -> (NSFont, CTFont)? {
    
    guard let nsFont = NSFont.init(name: fontName, size: GlyphCell.baseFontSize) else { return nil }
    
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
  func calculateCellSize(
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
    
    let finalWidth: CGFloat = glyphWidth * zoom * fontName.sizeNormalisationFactor
    let finalHeight: CGFloat = glyphHeight * zoom * fontName.sizeNormalisationFactor
    
    let size = CGSize(width: max(minWidth, finalWidth), height: max(minWidth, finalHeight))
    print("Here is the final cell size: \(size)")
    
    return size
  }
  
  
  private func getGlyphForCharacter(
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

