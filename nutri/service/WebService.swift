//
//  WebService.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import Foundation

class WebService {
    
    // MARK - download todays nutrition facts for user
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
            print(url)
            let (data, response) = try await URLSession.shared.data(from: url)
            print(data)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
        
        return nil
    }
    
    // MARK - Automatically logs food absed on a barcode
    func logFood(for log: AutomaticLogging, fromURL: String) async {
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
            print(url)
            var request = URLRequest(url: url)
            request.timeoutInterval = 30
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let data = try JSONEncoder().encode(log)
            let (_, response) = try await URLSession.shared.upload(for: request, from: data)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            print("Success logging food")
        } catch NetworkError.badUrl {
            print("There was an error creating the URL for the upload")
        } catch NetworkError.badResponse {
            print("Did not get a valid response from the upload")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the upload response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type during upload")
        } catch {
            print("An error occured uploading the data")
        }
    }
}
