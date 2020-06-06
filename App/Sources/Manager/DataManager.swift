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
//	ID: 126716DC-4ADE-4418-BDA0-D53D0A26AC3D
//
//	Pkg: App
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import Foundation

enum WHOEndPoint: EndPoint {
	
	case search
	
	var baseURL: URL {
		return URL(string: "https://services.arcgis.com/5T5nSi527N4F7luB/arcgis/rest/services/")!
	}
	
	var path: String {
		switch self {
		case .search: return "COVID19_hist_cases_adm0_v5_view/FeatureServer/0/query"
		}
	}
	
	var httpMethod: HTTPMethod {
		switch self {
		default: return .GET
		}
	}
}

struct Response: Codable {
	
	let features: [Feature]
	
	struct Feature: Codable {
		let attributes: [String: Int]
	}
}

struct DataManager {
	
	private let service = Service()
	
	func search(country: String = "US", completionHandler: @escaping (Statistics) -> Void) {
		
		guard let params = Bundle.config(country) else {
			return 
		}
		
		if country != "" && country.count == 2 {
			service.fetch(endpoint: WHOEndPoint.search, params: params) { (result: Result<Response, ServiceError>) in
				DispatchQueue.main.sync {
					switch result {
					case .success(let response):
						if let attributes = response.features.first?.attributes {
						
							let statistics = Statistics(cases: attributes["CumCase"] ?? 0,
														deaths: attributes["CumDeath"] ?? 0)
							
							completionHandler(statistics)
						}

					case .failure(let error): print(error)
					}
				}
			}
		}
	}
}
