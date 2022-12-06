import Foundation

struct Medication: Decodable{
    var sponsorName: String
    var openfda: OpenFDA
    var products: [Product]
    
    private enum CodingKeys : String, CodingKey {
        case sponsorName = "sponsor_name",openfda,products
    }
    
    struct Ingredients: Decodable, Hashable{
        var name: String
        var strength: String
    }
    
    struct OpenFDA: Decodable{
        var manufacturerName: [String]
        var brandName: [String]
        var productType:[String]
        var route:[String]
        var substanceName:[String]
        
        private enum CodingKeys : String, CodingKey {
            case manufacturerName="manufacturer_name", brandName="brand_name", productType="product_type",route,substanceName="substance_name"
        }
    }
    
    struct Product: Decodable{
        var brandName: String
        var activeIngredients:[Ingredients]
        var dosageForm:String
        var route:String
        var marketingStatus:String
        
        private enum CodingKeys : String, CodingKey {
            case  brandName="brand_name", activeIngredients="active_ingredients",dosageForm="dosage_form",route,marketingStatus="marketing_status"
        }
    }
    
}
