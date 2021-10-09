//
//  ApiClient.swift
//  weather
//
//  Created by User on 9/17/21.
//

import Foundation

class ApiClient {

    private let autocompleteSearch = "http://dataservice.accuweather.com/locations/v1/cities/autocomplete"
    
    private let fiveDaysOfDailyForecasts = "http://dataservice.accuweather.com/forecasts/v1/daily/5day/"
        
    func getFiveDaysOfDailyForecasts(cityKey: Int, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let parameters: [String: String] = [
            "apikey"    : Constants.API_KEY,
            "details"   : "false",
            "metric"    : "true",
            "language"  : Constants.LANGUAGE_RU
        ]
        
        sendRequest("\(fiveDaysOfDailyForecasts)\(cityKey)", parameters: parameters, completionHandler: completionHandler)
    }
    
    func getAutocompleteSearch(search: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let parameters: [String: String] = [
            "apikey"    : Constants.API_KEY,
            "q"         : search,
            "language"  : Constants.LANGUAGE_EN
        ]
        
        sendRequest(autocompleteSearch, parameters: parameters, completionHandler: completionHandler)

    }
    
    func sendRequest(_ url: String, parameters: [String: String]? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        print("Send \n\(url)\nrequest -->")
        
        var components = URLComponents(string: url)!
        
        if let parameters = parameters {
            print("request params \(parameters)")
            
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        print("Send request <--")
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, request, error in
            print("Get response in \nURL: \(url)\nBytes: \(data)\nRequest: \(request)\nError: \(error)\n<--")
            
            completionHandler(data, request, error)
        }).resume()
        print("Send Response \(url) -->")
    }
}

