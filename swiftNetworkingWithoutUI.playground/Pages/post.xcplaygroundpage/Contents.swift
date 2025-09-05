//: [Previous](@previous)

import Foundation


struct dataStruct: Codable  {
    let message: String
    let number: Bool?
}

func uploadData( payload: Data) async throws -> Void {
    let endpoint = "http://localhost:9000/save"
    
    guard let url = URL(string: endpoint) else {
        print("1")
        throw URLError(.badURL)
    }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  
    let (data,reponse) = try await URLSession.shared.upload(for: request , from: payload)
    guard let httpResponce = reponse as? HTTPURLResponse
//            , httpResponce.statusCode == 201
    else
    {
        print("3")
        throw URLError(.badServerResponse)
    }
    
    print("✅ Upload successful. Server responded with:")
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
    
}


Task {
    do {
        let obj = dataStruct(message: "data added form the swift code 123", number: nil)
        let jsonData = try JSONEncoder().encode(obj)
        
        try await uploadData(payload: jsonData)
    } catch {
        print("❌ Error: \(error)")
    }
}








//
//func postMethod() {
//        guard let url = URL(string: "http://localhost:9000/save") else {
//            print("Error: cannot create URL")
//            return
//        }
//        
//        // Create model
//        struct UploadData: Codable {
//            let message: String
//            let number: Bool
//        }
//        
//        // Add data to the model
//        let uploadDataModel = UploadData(message: "Jack", number: false )
//        
//        // Convert model to JSON data
//        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
//            print("Error: Trying to convert model to JSON data")
//            return
//        }
//        // Create the url request
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
//        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
//        request.httpBody = jsonData
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                print("Error: error calling POST")
//                print(error!)
//                return
//            }
//            guard let data = data else {
//                print("Error: Did not receive data")
//                return
//            }
////            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
////                print("Error: HTTP request failed")
////                return
////            }
//            do {
//                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                    print("Error: Cannot convert data to JSON object")
//                    return
//                }
//                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                    print("Error: Cannot convert JSON object to Pretty JSON data")
//                    return
//                }
//                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                    print("Error: Couldn't print JSON in String")
//                    return
//                }
//                
//                print(prettyPrintedJson)
//            } catch {
//                print("Error: Trying to convert JSON data to string")
//                return
//            }
//        }.resume()
//    }
//
//
//postMethod()
//
//
//
//
//
//
//
//
