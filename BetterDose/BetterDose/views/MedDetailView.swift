import SwiftUI

struct MedDetailView:View{
    var med:Medication
    
    
    var body: some View{
        VStack{
            Text(med.openfda.brandName[0].capitalized).font(.title2).foregroundColor(Color("betterRed")).padding(.horizontal, 20)
            Rectangle().frame(height: 2)
                .padding(.horizontal, 20).foregroundColor(Color("betterRed"))
            List{
                Section(header: Text("OpenFDA").font(.headline).foregroundColor(Color("betterRed"))) {
                    HStack(spacing: 20){
                        Text("Brand name:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 100)
                        Text(med.openfda.brandName[0].capitalized)
                    }.frame(alignment: .leading)
                    HStack(spacing: 20){
                        Text("Substance name:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 70)
                        Text(med.openfda.substanceName[0].capitalized)
                    }.frame(alignment: .leading)
                    HStack(spacing: 20){
                        Text("Manufacturer name:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 100)
                        Text(med.openfda.manufacturerName[0].capitalized)
                    }.frame(alignment: .leading)
                    HStack(spacing: 20){
                        Text("Product type:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 100)
                        Text(med.openfda.productType[0].capitalized)
                    }.frame(alignment: .leading)
                }
                
                Section(header: Text("Drug information").font(.headline).foregroundColor(Color("betterRed"))) {
                    HStack(spacing: 20){
                        Text("Dosage form:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 100)
                        Text(med.products[0].dosageForm.capitalized)
                    }.frame(alignment: .leading)
                    HStack(spacing: 20){
                        Text("Route:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 50)
                        Text(med.products[0].route.capitalized)
                    }.frame(alignment: .leading)
                    HStack(spacing: 20){
                        Text("Marketing status:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 70)
                        Text(med.products[0].marketingStatus.capitalized)
                    }.frame(alignment: .leading)
                    
                    Section(header: Text("Active Ingredients").font(.headline).foregroundColor(Color("betterRed"))) {
                        ForEach(med.products[0].activeIngredients, id: \.self) { ing in
                            HStack(spacing: 20){
                                Text("Name:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 50)
                                Text(ing.name.capitalized)
                            }
                            HStack(spacing: 20){
                                Text("Strength:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 60)
                                Text(ing.strength.capitalized)
                            }
                        }
                        
                    }.frame(alignment: .leading)
                }
            }
        }
    }
}
