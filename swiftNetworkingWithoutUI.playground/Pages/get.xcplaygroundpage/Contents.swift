//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

struct dataStruct: Codable  {
    let _id: String
    let message: String
    let number: Bool
}


//later add throws
func getMethod() async throws -> [dataStruct] {
    let endpoint = "http://localhost:9000/get"
    
    guard let url = URL(string: endpoint) else {
        print("url is not valid")
        throw URLError(.badURL)
    }
    let (data, responce) = try await URLSession.shared.data(from: url)
    
    guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
        print("responce is invalid")
        throw URLError(.badServerResponse)
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([dataStruct].self, from:  data)
    } catch {
         print("recieved data is invalid")
        throw error
    }
}


Task {
    do{
        let output:[dataStruct] = try await getMethod()
        
        for item in output {
            print("-------")
            print(item.message)
            print(item.number)
            print(item._id)
        }

        
    } catch {
        print("error: \(error)")
    }
}






















// this all are trash consider above code for good ref 


//
//
//import Foundation
//
//struct DataStruct: Codable {
//    let message: String
//    let number: Bool
//}
//
//func getMethod() {
//    guard let url = URL(string: "http://localhost:9000/get") else {
//        print("❌ Error: cannot create URL")
//        return
//    }
//    
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("❌ Error calling GET:", error)
//            return
//        }
//        
//        guard let response = response as? HTTPURLResponse,
//              (200 ..< 300).contains(response.statusCode) else {
//            print("❌ Error: HTTP request failed")
//            return
//        }
//        
//        guard let data = data else {
//            print("❌ Error: Did not receive data")
//            return
//        }
//        
//        do {
//            // Decode JSON into [DataStruct]
//            let decodedData = try JSONDecoder().decode([DataStruct].self, from: data)
//            
//            // Print decoded Swift objects
//            for item in decodedData {
//                print("Message: \(item.message), Number: \(item.number)")
//            }
//            
//            // If you want pretty-printed JSON
//            if let jsonObject = try? JSONSerialization.jsonObject(with: data),
//               let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
//               let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) {
//                print("\n🌐 Raw JSON:\n", prettyPrintedJson)
//            }
//            
//        } catch {
//            print("❌ Error decoding JSON:", error)
//        }
//    }.resume()
//}
//
//// Call it
//getMethod()
