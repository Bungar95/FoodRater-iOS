import Foundation

public class Karte {
    
    public init() {}
    
    var spiloviKarata: [String: Int] = [:]
    
    public func brojanjeKarata(brojN :Int) {
        
        var i = 0
        
        while i < brojN {
            
            let broj = Int.random(in: 1...32)
            
            if spiloviKarata.keys.contains("\(broj)") {
                spiloviKarata["\(broj)"]? += 1
            } else {
                spiloviKarata["\(broj)"] = 1
            }
            
           i += 1
            
        }
        
        let brojSpilova = spiloviKarata.min{ a, b in a.value < b.value}
        
        print("Broj kompletnih spilova je \(brojSpilova?.value).")
    }
}
