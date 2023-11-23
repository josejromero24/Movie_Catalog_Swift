//
//  AlamofireUtils.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import Alamofire

class AlamofireUtils {
    
    static func createHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYTEwNTA5MjcwZTZkOTZlOTFkY2M5ZWUxYjNiZmI0NCIsInN1YiI6IjY1NWNkMTU2ZWE4NGM3MTA5NWEwZDRiYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GzaEOMvM_EuP0h1anr-bYbvwlR4WneoBiZj8yrUCgxw"
        ]
        
        return headers
    }
    
    static func getUrlBaseImage() -> String {
        return "https://image.tmdb.org/t/p/w500/"
    }
}
