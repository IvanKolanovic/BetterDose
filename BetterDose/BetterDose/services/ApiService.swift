import Foundation


class ApiService: ObservableObject{
    @Published var meds: [Medication] = []
    @Published var showAlert:Bool = false
    
    func getMedsByName(_ medName:String) {
        
        let queryItems = [URLQueryItem(name: "search", value: "openfda.brand_name:\(medName)")]
        let baseUrl = "https://api.fda.gov/drug/drugsfda.json"
        
        guard var urlComps = URLComponents(string: baseUrl) else { fatalError("Missing URL") }
        urlComps.queryItems = queryItems
        
        guard let url = urlComps.url else { fatalError("URL Comps failed to construct a valid url") }
        print(url)
        
        let urlRequest = URLRequest(url: url,cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { self.showAlert = true; return}
            
            DispatchQueue.main.async {
                if response.statusCode == 200 {
                    guard let data = data else { self.showAlert = true;  return}
                    do {
                        let decodedMeds = try JSONDecoder().decode(MyResults.self, from: data)
                        self.meds = decodedMeds.results
                    } catch let error {
                        print("Error decoding: ", error)
                        self.showAlert = true
                        
                    }
                    
                }
                else{
                    self.showAlert = true
                }
            }
        }
        dataTask.resume()
    }// end of method
} // end of class
