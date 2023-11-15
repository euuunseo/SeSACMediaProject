//
//  TMBD_APIManager.swift
//  SeSACMediaProject
//
//  Created by 고은서 on 2023/10/31.
//

import Foundation
import Alamofire
import SwiftyJSON

class TMBD_APIManager {
    static let shared = TMBD_APIManager()
    
    private init() {  }
    
    let header: HTTPHeaders = ["Authorization" : APIKey.tmbd]
    
    func callRequest (success: @escaping (TrendAPI) -> Void ) {
        
        let url = "https://api.themoviedb.org/3/trending/all/day?language=en-US"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: TrendAPI.self) { response in
            
            switch response.result {
            case .success(let value):
                
                //String, String, String, String, String, Double, Int
                //completionHandler(value.releaseDate ?? "데이터 없음", value.mediaType.rawValue, value.posterPath, value.title ?? "제목 없음", value.overview, value.popularity, value.id)
                
                success(value)
                
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
    
    
    func callMovieIdRequest (movieId: Int, completionHandler: @escaping (JSON) -> Void) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/credits?language=en-US"
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func callSimilarRequest (movieId: Int, success: @escaping (SimilarAPI) -> Void) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/similar"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: SimilarAPI.self) { response in
            
            switch response.result {
            case .success(let value):
                
                success(value)
                
            case .failure(let error):
                print(error)
                
            }
            
            
        }
    }
    
    func callVideoAPIRequest (movidID: Int, success: @escaping (VideoAPI) -> Void) {
        
        
        let url = "https://api.themoviedb.org/3/movie/\(movidID)/videos"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: VideoAPI.self) { response in
            
            switch response.result {
            case .success(let value):
                
                success(value)
                
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
}
