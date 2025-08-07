// NSColorExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

@MainActor
final class NSColorExtensionsTests: XCTestCase {
    @available(macOS 10.15, *)
    func testInitLightDark() {
        let lightModeColor = NSColor.red
        let darkModeColor = NSColor.blue
        let color = NSColor(light: lightModeColor, dark: darkModeColor)

        let view = NSView()

        if #available(macOS 12, *) {
            NSAppearance(named: .aqua)?.performAsCurrentDrawingAppearance {
                view.backgroundColor = color
            }
        } else {
            NSAppearance.current = NSAppearance(named: .aqua)
            view.backgroundColor = color
        }
        XCTAssertEqual(view.backgroundColor, lightModeColor)

        if #available(macOS 12, *) {
            NSAppearance(named: .darkAqua)?.performAsCurrentDrawingAppearance {
                view.backgroundColor = color
            }
        } else {
            NSAppearance.current = NSAppearance(named: .darkAqua)
            view.backgroundColor = color
        }
        XCTAssertEqual(view.backgroundColor, darkModeColor)
    }
    
    func testColorWithHex_Examples() {
        // Example 1: #ff0000
        let color1 = NSColor.colorWithHex("#ff0000")
        XCTAssertEqual(color1.redComponent, 1.0, accuracy: 0.01)
        XCTAssertEqual(color1.greenComponent, 0.0, accuracy: 0.01)
        XCTAssertEqual(color1.blueComponent, 0.0, accuracy: 0.01)
        
        // Example 2: 0x00ff00 with alpha
        let color2 = NSColor.colorWithHex("0x00ff00", 0.5)
        XCTAssertEqual(color2.greenComponent, 1.0, accuracy: 0.01)
        XCTAssertEqual(color2.alphaComponent, 0.5, accuracy: 0.01)
        
        // Example 3: abc (3-digit shorthand)
        let color3 = NSColor.colorWithHex("abc")
        XCTAssertEqual(color3.redComponent, 0xAA / 255.0, accuracy: 0.01)
        XCTAssertEqual(color3.greenComponent, 0xBB / 255.0, accuracy: 0.01)
        XCTAssertEqual(color3.blueComponent, 0xCC / 255.0, accuracy: 0.01)
    }
}

#endif
