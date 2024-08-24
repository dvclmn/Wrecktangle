//
//  Theme+Model.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

import SwiftUI
import BaseStyles

extension SwiftBox {
  
  public struct Theme {
    
    var glyphSet: Theme.GlyphSet
    var colour: Theme.GlyphStyle
    var frameStyle: Theme.FrameStyle
    var padding: Int
    
    public init(
      glyphSet: Theme.GlyphSet = .sharp,
      colour: Theme.GlyphStyle = .default,
      frameStyle: Theme.FrameStyle = .single,
      padding: Int = 1
    ) {
      self.glyphSet = glyphSet
      self.colour = colour
      self.frameStyle = frameStyle
      self.padding = padding
    }
    
    public struct GlyphStyle {
      var primary: AttributeSet      // Text
      var secondary: AttributeSet    // Box frame
      var tertiary: AttributeSet     // Invisibles
      var accent: AttributeSet       // Subtle accents
      
      public enum StyleType {
        case primary, secondary, tertiary, accent
      }
      
      public init(
        primary: AttributeSet,
        secondary: AttributeSet,
        tertiary: AttributeSet,
        accent: AttributeSet
      ) {
        self.primary = primary
        self.secondary = secondary
        self.tertiary = tertiary
        self.accent = accent
      }
      
      public static let `default`: GlyphStyle = GlyphStyle(
        primary: AttributeSet(AttributeSet.primary),
        secondary: AttributeSet(AttributeSet.chalkBlue),
        tertiary: AttributeSet(AttributeSet.tertiary),
        accent: AttributeSet(AttributeSet.peach)
      )
      
      public static let purple: GlyphStyle = GlyphStyle(
        primary: AttributeSet(AttributeSet.lavendar),
        secondary: AttributeSet(AttributeSet.secondary),
        tertiary: AttributeSet(AttributeSet.tertiary),
        accent: AttributeSet(AttributeSet.peach)
      )
      
      public static let matrix: GlyphStyle = GlyphStyle(
        primary: AttributeSet(AttributeSet.green),
        secondary: AttributeSet(AttributeSet.secondary),
        tertiary: AttributeSet(AttributeSet.tertiary),
        accent: AttributeSet(AttributeSet.olive)
      )
      
            
    }
    
    /// `AttributeSet` holds an `AttributeContainer` instance, which
    /// holds all the styles for the set.
    ///
    /// I find `AttributeContainer`s somewhat clumsy to make, so this type
    /// abstracts this job away from the user. Also, `SwiftBox` (currently) only
    /// really needs foreground/background colours, so having `AttributeSet`
    /// makes that more accesible/straightforward.
    ///
    /// We can rely on the computed property `container` to return an *actual*
    /// container when we need it.
    ///
    public struct AttributeSet {
      
      var foreground: Color
      var background: Color?
      
      /// Defaults to no background, as I suspect this will be most common
      ///
      init(
        _ foreground: Color = AttributeSet.primary,
        background: Color? = nil
      ) {
        self.foreground = foreground
        self.background = background
      }
      
      var container: AttributeContainer {
        var attrContainer = AttributeContainer()
        attrContainer.foregroundColor = self.foreground
        attrContainer.backgroundColor = self.background
        
        return attrContainer
      }
      
      
      static let primary: Color = Color.primary
      static let secondary: Color = Color.secondary
      static let tertiary: Color = Color.secondary.opacity(0.4)
      static let peach: Color = Swatch.peach.colour
      static let lavendar: Color = Swatch.lavendar.colour
      static let olive: Color = Swatch.olive.colour
      static let chalkBlue: Color = Swatch.chalkBlue.colour
      static let slate: Color = Swatch.slate.colour
      static let green: Color = Color.green

    } // END attribute set

  }
  
  
}



