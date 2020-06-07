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
//	ID: 56ACA9C1-E43B-4421-AE70-25A5AD1431E1
//
//	Pkg: App
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import SwiftUI

struct CardPagerView: View {
	
	@State var statistics: Statistics
	
	@State private var currentPageIndex = 0
	
    var body: some View {
		VStack(spacing: 0) {			
			PagerView(pageCount: 2, currentIndex: $currentPageIndex) {
				DashboardView()
				InfoView()
			}.frame(height: 200)
			
			PageControl(numberOfPages: 2, currentPageIndex: $currentPageIndex)
		}
    }
}

struct CardPagerView_Previews: PreviewProvider {
    static var previews: some View {
		CardPagerView(statistics: Statistics(cases: 0, deaths: 0))
    }
}
