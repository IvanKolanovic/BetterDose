

import Foundation

class MyUser: Identifiable, Codable{
    internal var id: String
    private var email: String
    private var fullName: String
    private var createdAt: String
    
    init(id: String, email: String, fullName: String, createdAt: String) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.createdAt = createdAt
    }
    
    func getId() -> String {
        return self.id
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getFullName() -> String {
        return self.fullName
    }
    
    func getCreatedAt() -> String {
        return self.createdAt
    }
    
    func setId(_ id:String) {
        self.id = id
    }
    
    func setEmail(_ email:String) {
        self.email = email
    }
    
    func setFullName(_ fullName:String) {
        self.fullName = fullName
    }
    
    func setCreatedAt(_ createdAt:String) {
        self.createdAt = createdAt
    }
}
