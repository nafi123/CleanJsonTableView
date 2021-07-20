//
//  JsonPlaceHolderService.swift
//  CleanJsonPlaceTableView
//
//  Created by Mehmet Nafi ISLEK on 1.07.2021.
//

import Foundation
import Alamofire

protocol JsonPlaceHolderProtocol {
    func fetchAllPosts(onSuccess: @escaping ([PostModel]) -> Void, onFail: @escaping (String?) -> Void )
}

enum JsonPlaceHolderPath: String{
    case POSTS = "/posts"
}

extension JsonPlaceHolderPath {
    func withBaseUrl() -> String {
        return "https://jsonplaceholder.typicode.com\(self.rawValue)"
    }
}

struct JsonPlaceHolderService: JsonPlaceHolderProtocol {
    func fetchAllPosts(onSuccess: @escaping ([PostModel]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(JsonPlaceHolderPath.POSTS.withBaseUrl(), method: .get).validate().responseDecodable(of: [PostModel].self) { (responce) in
            guard let items = responce.value else {
                onFail(responce.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}
