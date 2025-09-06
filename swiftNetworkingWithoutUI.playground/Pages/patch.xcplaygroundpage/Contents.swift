//: [Previous](@previous)

import Foundation

struct patchStruct: Codable  {
    let message: String?
    let number: Bool?
}

func patchUpdateData(id: String, newMessage: String? = nil, newNumber: Bool? = nil) async throws {
    let endpoint = "http://localhost:9000/patch/\(id)"
    guard let url = URL(string: endpoint) else { throw URLError(.badURL) }
    
    let obj = patchStruct(message: newMessage, number: newNumber)
    let payload = try JSONEncoder().encode(obj)
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (data, response) = try await URLSession.shared.upload(for: request, from: payload)
    guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
    
    print("✅ PATCH finished. Status: \(httpResponse.statusCode)")
    if let responseString = String(data: data, encoding: .utf8) {
        print("Server response: \(responseString)")
    }
}


Task {
    do {
        // 🔹 PATCH (update only one field)
        try await patchUpdateData(
            id: "68bb2339b28a2e8f3dccef46",
//            newMessage: "Just message updated 📝"
            newNumber: true
            // number not passed → unchanged
        )
    } catch {
        print("❌ Error: \(error)")
    }
}
