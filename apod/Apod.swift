//
//  Apod.swift
//  apod
//
//  Created by ohhyung kwon on 9/6/2022.
//

import Foundation

// Astronomy Picture of the Day (APOD)  data structure
//
struct Apod{
    
    // what type of media? image or video
    enum MediaType: String, Decodable{
        case image, video
    }
    
    let copyright: String?
    let date: Date
    let explanation: String
    let mediaType: MediaType
    let title: String
    let url: URL
    
   
}

// fetch apod from network
extension Apod {
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    private static var baseUrl:String {
        "https://api.nasa.gov/planetary/apod"
    }
    
    static func fetchApod(of date:Date, completion: @escaping (Apod?) -> ()) {
        var urlComponents = URLComponents(string: baseUrl)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: ApiKeys.nasaApiKey) ,
            URLQueryItem(name: "date", value: self.dateFormatter.string(from: date))
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }
                      
            completion( try? JSONDecoder().decode(Apod.self, from: data) )
        }
        .resume()
    }
    
    static func fetchApods(from fromDate: Date, to toDate: Date, completion: @escaping ([Apod]?)->()){
        
        let dateFormatter = self.dateFormatter
        var urlComponents = URLComponents(string: baseUrl)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: ApiKeys.nasaApiKey) ,
            URLQueryItem(name: "start_date", value: dateFormatter.string(from: fromDate)),
            URLQueryItem(name: "end_date", value: dateFormatter.string(from: toDate))
        ]

        URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }
                      
            completion( try? JSONDecoder().decode([Apod].self, from: data) )
        }
        .resume()
    }
}

extension Apod: Decodable{
    
    enum DecodingError: Error{
        case wrongDateFormat
        case wrongUrlFormat
    }

    private enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, media_type, title, url
    }

    // manual decoding to transform string date to date object
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        copyright = try? values.decode(String.self, forKey: .copyright)
        
        // parse data string
        let dateFormatter = Self.dateFormatter
        let dateString = try values.decode(String.self, forKey: .date)
        guard let date = dateFormatter.date(from: dateString) else {
            throw DecodingError.wrongDateFormat
        }
        self.date = date
        
        explanation = try values.decode(String.self, forKey: .explanation)
        mediaType = try values.decode(MediaType.self, forKey: .media_type)
        title = try values.decode(String.self, forKey: .title)
        
        // parse url
        let urlString = try values.decode(String.self, forKey: .url)
        guard let url = URL(string: urlString) else {
            throw DecodingError.wrongUrlFormat
        }
        self.url = url
    }
}
