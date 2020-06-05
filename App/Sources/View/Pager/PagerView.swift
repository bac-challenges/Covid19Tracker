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
//	ID: 0498FFA5-6347-4EF1-B13E-2F2956421DFC
//
//	Pkg: App
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import SwiftUI

struct PagerView<Content: View>: View {
	let pageCount: Int
	@Binding var currentIndex: Int
	let content: Content
	
	@GestureState private var translation: CGFloat = 0
	
	init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
		self.pageCount = pageCount
		self._currentIndex = currentIndex
		self.content = content()
	}
	
	var body: some View {
		GeometryReader { geometry in
			HStack(spacing: 0) {
				self.content.frame(width: geometry.size.width)
			}
			.frame(width: geometry.size.width, alignment: .leading)
			.offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
			.offset(x: self.translation)
			.animation(.interactiveSpring())
			.gesture(
				DragGesture().updating(self.$translation) { value, state, _ in
					state = value.translation.width
				}.onEnded { value in
					let offset = value.translation.width / geometry.size.width
					let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
					self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
				}
			)
		}
	}
}
