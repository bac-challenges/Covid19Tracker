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
//	ID: B634F60C-A056-401D-B44D-F95E474444D0
//
//	Pkg: App
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import Foundation
import UIKit
import SwiftUI

struct PageControl: UIViewRepresentable {
	
	var numberOfPages: Int
	
	@Binding var currentPageIndex: Int
	
	func makeUIView(context: Context) -> UIPageControl {
		let control = UIPageControl()
		control.numberOfPages = numberOfPages
		control.currentPageIndicatorTintColor = .secondaryLabel
		control.pageIndicatorTintColor = .lightGray
		
		return control
	}
	
	func updateUIView(_ uiView: UIPageControl, context: Context) {
		uiView.currentPage = currentPageIndex
	}
	
}
