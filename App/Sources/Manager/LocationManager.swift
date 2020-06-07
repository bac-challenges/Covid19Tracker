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
//	ID: DAE31051-A244-42DC-8066-1893AED80CCE
//
//	Pkg: App
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
	
	static let shared = LocationManager()
	
	var manager: CLLocationManager?
	var callback: ((String) -> Void)?
	
	@discardableResult
	override private init() {
		
		super.init()
		
		manager = CLLocationManager()
		manager?.delegate = self
	}
	
	func requestAlwaysAuthorization() {
		manager?.requestAlwaysAuthorization()
	}
	
	func getLocation(callback: @escaping (String) -> Void) {
		self.callback = callback
		manager?.requestLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedAlways || status == .authorizedWhenInUse {
			if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
				if CLLocationManager.isRangingAvailable() {
					print("Core Location Avaliable")
				}
			}
		}
		else {
			print("Core Location Unavaliable")
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			
			let geocoder = CLGeocoder()
			geocoder.reverseGeocodeLocation(location) { (result, error) in
				if let placemark = result?[0] {
					
					guard let location = placemark.isoCountryCode else {
						return
					}
					
					print("Found user's location: \(location)")
					
					if let callback = self.callback {
						callback(location)
					}
				}
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Failed to find user's location: \(error.localizedDescription)")
	}
}
