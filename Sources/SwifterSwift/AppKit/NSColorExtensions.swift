// NSColorExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Create an NSColor with different colors for light and dark mode.
    ///
    /// - Parameters:
    ///     - light: Color to use in light/unspecified mode.
    ///     - dark: Color to use in dark mode.
    @available(OSX 10.15, *)
    convenience init(light: NSColor, dark: NSColor) {
        self.init(name: nil, dynamicProvider: { $0.name == .darkAqua ? dark : light })
    }
    
    /// SwifterSwift: Create a NSColor with hex && alpha value.
    ///
    ///     let color1 = NSColor.colorWithHex("#ff0000")
    ///     let color2 = NSColor.colorWithHex("0x00ff00", 0.5)
    ///     let color3 = NSColor.colorWithHex("abc")
    ///
    /// - Parameters:
    ///   - hex: hex value.
    ///   - alpha: alpha value.
    ///   - Returns: NSColor with the specified hex and alpha.
    static func colorWithHex(_ hex: String, _ alpha: CGFloat = 1.0) -> NSColor {
        // valid hex chars
        let validHexChars = CharacterSet(charactersIn: "0123456789abcdef")
        
        // Force conversion to lowercase
        var hexString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased()
        
        // If the passed hexadecimal color has a "0x" prefix, remove the prefix
        if hexString.hasPrefix("0x") {
            hexString = String(hexString[hexString.index(hexString.startIndex, offsetBy: 2)...])
        }
        
        // If the passed hexadecimal color has a "#" prefix, remove the prefix
        if hexString.hasPrefix("#") {
            hexString = String(hexString[hexString.index(hexString.startIndex, offsetBy: 1)...])
        }
        
        // Replace invalid characters with "0"
        hexString = hexString.map { char -> String in
            let str = String(char)
            return str.rangeOfCharacter(from: validHexChars) != nil ? str : "0"
        }.joined()
        
        // Handle 3-digit shorthand format (e.g. "abc" -> "aabbcc")
        if hexString.count == 3 {
            hexString = hexString.map { "\($0)\($0)" }.joined()
        }
        
        // Pad with "0" if length < 6
        if hexString.count < 6 {
            hexString = hexString.padding(toLength: 6, withPad: "0", startingAt: 0)
        }
        
        // Trim to 6 characters if length > 6
        if hexString.count > 6 {
            hexString = String(hexString.prefix(6))
        }
        
        // Extract RGB components from the hex string
        let rStr = String(hexString.prefix(2))
        let gStr = String(hexString.dropFirst(2).prefix(2))
        let bStr = String(hexString.dropFirst(4).prefix(2))
        
        let red   = UInt64(rStr, radix: 16) ?? 0
        let green = UInt64(gStr, radix: 16) ?? 0
        let blue  = UInt64(bStr, radix: 16) ?? 0
        
        // valid alpha
        let validAlpha = min(max(alpha, 0.0), 1.0)
        // Return the color
        return NSColor(red: (CGFloat(red) / 255.0), green: (CGFloat(green) / 255.0), blue: (CGFloat(blue) / 255.0), alpha: validAlpha)
    }
}

#endif

