//
//  URLSessionNetworking.swift
//  Buzz
//
//  Created by Felipe Assis on 14/11/2024.
//

import Foundation

protocol NetworkingService {
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodeError
}

class URLSessionNetworking: NetworkingService {
    func request<T>(url: URL, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch {
                completion(.failure(error))
                return
            }
        }
        task.resume()
    }
}
