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
//	ID: 572F8FA6-235B-4E64-8A9E-A346B01A67CD
//
//	Pkg: App
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import SwiftUI

struct InfoView: View {
	
	@EnvironmentObject var model: ContentViewModel
	
	var body: some View {
		ZStack(alignment: .leading) {
			
			Image("Info")
			
			VStack(alignment: .leading) {
				Text("\(model.country)'s Situation in Numbers")
					.foregroundColor(.white)
					.font(.footnote)
					.padding(.bottom)
				
				Text("\(model.statistics.cases)")
					.foregroundColor(.white)
					.font(.largeTitle)
					.bold()
					.padding(.top)
				
				Text("Confirmed Cases")
					.foregroundColor(.white)
					.font(.footnote)
					.padding(.bottom)

				
				Text("\(model.statistics.deaths) Total Deaths")
					.foregroundColor(.white)
					.font(.footnote)
					.padding(.top)
				
			}.padding()
		}.shadow(color: .gray, radius: 5)
	}
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
		InfoView()
    }
}
