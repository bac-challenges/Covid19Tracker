//	MIT License
//
//	Copyright © 2020 Emile, Blue Ant Corp
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.
//
//	ID: 5E55187B-20FB-4700-AF70-F4835B569256
//
//	Pkg: App
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import Foundation

extension Bundle {
	
	static func config(_ country: String) -> [String: String]? {
		
		guard let path = self.main.path(forResource: "Config", ofType: "plist") else {
			print("Error loading configuration")
			return nil
		}
		
		let url = URL(fileURLWithPath: path)
		let data = try! Data(contentsOf: url)
		
		guard var config = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String] else {
			print("Error decoding configuration")
			return nil
		}
		
		config["where"] = "ISO_2_CODE='\(country)'"
		
		return config
	}
}
