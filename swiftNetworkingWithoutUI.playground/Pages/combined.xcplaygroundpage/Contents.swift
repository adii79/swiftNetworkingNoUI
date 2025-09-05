//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

import Foundation

struct Todo: Codable {
    let id: Int?
    let title: String
    let completed: Bool
}

class APIService {
    private let baseURL = "https://jsonplaceholder.typicode.com/todos"
    
    // MARK: - GET
    func getTodos() async throws -> [Todo] {
        let url = URL(string: baseURL)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Todo].self, from: data)
    }
    
    // MARK: - POST
    func createTodo(title: String) async throws -> Todo {
        let newTodo = Todo(id: nil, title: title, completed: false)
        let url = URL(string: baseURL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(newTodo)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Todo.self, from: data)
    }
    
    // MARK: - PUT
    func updateTodo(id: Int, title: String, completed: Bool) async throws -> Todo {
        let updatedTodo = Todo(id: id, title: title, completed: completed)
        let url = URL(string: "\(baseURL)/\(id)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(updatedTodo)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Todo.self, from: data)
    }
    
    // MARK: - DELETE
    func deleteTodo(id: Int) async throws {
        let url = URL(string: "\(baseURL)/\(id)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        _ = try await URLSession.shared.data(for: request)
    }
}






func getData() async throws -> iosApi {
    let endpoint = "http://localhost:9000/ios"
    
    guard let url = URL(string: endpoint) else {
        throw iosError.invalidUrl
    }
    
    let (data,responce) = try await URLSession.shared.data(from: url)
    
    guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
        throw iosError.invalidResponce
    }
    do {
        let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // above snippet convert snake to camel case (snake_case = snakeCase)
        
        return try  decoder.decode(iosApi.self, from: data)
    } catch {
        throw iosError.invalidData
    }
    
}
