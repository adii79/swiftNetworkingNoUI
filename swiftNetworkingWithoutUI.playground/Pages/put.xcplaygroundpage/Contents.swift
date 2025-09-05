//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

import Foundation

struct dataStruct: Codable  {
    let message: String
    let number: Bool
}

func putUpdateData(id: String, newMessage: String, newNumber: Bool) async throws {
    let endpoint = "http://localhost:9000/update/\(id)"
    guard let url = URL(string: endpoint) else { throw URLError(.badURL) }
    
    let obj = dataStruct(message: newMessage, number: newNumber)
    let payload = try JSONEncoder().encode(obj)
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (data, response) = try await URLSession.shared.upload(for: request, from: payload)
    guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
    
    print("✅ PUT finished. Status: \(httpResponse.statusCode)")
    if let responseString = String(data: data, encoding: .utf8) {
        print("Server response: \(responseString)")
    }
}


Task {
    do {
        // 🔹 PUT (replace everything)
                try await putUpdateData(
                    id: "68bb2091879d2ef2e242f950",
                    newMessage: "Full replace 🚀",
                    newNumber: true
                )
    }
}
