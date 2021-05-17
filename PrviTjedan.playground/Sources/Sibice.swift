import Foundation

public class Sibice {
    
    public init() {}
    
    let brojSibicaPoBroju: Array<Int> = [6, 2, 5, 5, 4, 5, 6, 3, 7, 6]
    var brojPotrebnihSibica = 0
    
    public func prebrojSibice(brojN :Int) {
        
        for i in 0...brojN {
            
            let iString: String = String(i)
            
            for j in iString {
                let x: String = String(j)
                brojPotrebnihSibica += brojSibicaPoBroju[Int(x) ?? 0]
            }
            
        }
        
        print("Broj potrebnih šibica od 0 do \(brojN) je \(brojPotrebnihSibica).")
        
    }
    
    
}
