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
//	ID: F3AC459B-1A18-45DA-A5D9-DE0DC678162E
//
//	Pkg: GitHubBrowser
//
//	Swift: 5.0
//
//	MacOS: 10.15
//

import Foundation

protocol EndPoint {
	var baseURL: URL { get }
	var path: String { get }
	var httpMethod: HTTPMethod { get }
}

enum HTTPMethod: String {
	case GET
	case POST
	case PUT
	case DELETE
	case PATCH
}

enum ServiceError: Error {
	case noResponse
	case jsonDecodingError(error: Error)
	case networkError(error: Error)
}

struct Service {
	
	func fetch<T: Codable>(endpoint: EndPoint, params: [String: String]?, decoder: JSONDecoder = JSONDecoder(), completionHandler: @escaping (Result<T, ServiceError>) -> Void) {
		
		let queryURL = endpoint.baseURL.appendingPathComponent(endpoint.path)
		var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
		components.queryItems = [URLQueryItem]()
		
		if let params = params {
			for (_, value) in params.enumerated() {
				components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
			}
		}
		
		var request = URLRequest(url: components.url!)
		request.httpMethod = endpoint.httpMethod.rawValue
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			
			guard let data = data else {
				completionHandler(.failure(.noResponse))
				return
			}
			guard error == nil else {
				completionHandler(.failure(.networkError(error: error!)))
				return
			}
			do {
				decoder.dateDecodingStrategy = .iso8601
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let object = try decoder.decode(T.self, from: data)
				completionHandler(.success(object))
			} catch let error {
				print(error)
				completionHandler(.failure(.jsonDecodingError(error: error)))
			}
		}
		task.resume()
	}
}
