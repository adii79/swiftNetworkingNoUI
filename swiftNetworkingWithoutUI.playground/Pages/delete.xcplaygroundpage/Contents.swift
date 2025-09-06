//: [Previous](@previous)

import Foundation

func deleteData(id: String) async throws {
    let endpoint = "http://localhost:9000/delete/\(id)"
    guard let url = URL(string: endpoint) else { throw URLError(.badURL) }
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
    
    print("🗑️ DELETE finished. Status: \(httpResponse.statusCode)")
    if let responseString = String(data: data, encoding: .utf8) {
        print("Server response: \(responseString)")
    }
}



Task {
    do {
        try await deleteData(id: "68bb2339b28a2e8f3dccef46")
    } catch {
        print("❌ Error: \(error)")
    }
}


