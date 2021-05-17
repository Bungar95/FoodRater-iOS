import Foundation

public class Predavanja {
    
    public init() {}
    
    let pocetakNastave = 8*60
    let krajNastave = 16*60
    
    let trajanjeSat = 45
    var maliOdmorCounter = 0
    var satCounter = 0
    var uTijekuNastava = true
    
    var stringArray: Array<String> = []
    var intArray: Array<Int> = []
    
    
    public func algoritamPredavanja(trajanjeMaliOdmor: Int,
                                    trajanjeVelikiOdmor: Int,
                                    terminVelikiOdmor: Int,
                                    unosVremena: String) {
        
        let zadanoVrijeme = provjeraVremena(unos: unosVremena)
        
        if zadanoVrijeme != 0 {
            obradaNastave(maliOdmor: trajanjeMaliOdmor, velikiOdmor: trajanjeVelikiOdmor, terminVelikiOdmor: terminVelikiOdmor)
        }
        
        pronadiZadanoVrijeme(zadanoVrijeme: zadanoVrijeme)
        
    }
    
    func provjeraVremena(unos: String) -> Int {
        
        let unos = unos.replacingOccurrences(of: " ", with: "").split(separator: ":")
        guard let zadanoH = Int(unos[0]) else {
            print("Ne radi unešen sat")
            return 0
        }
        guard let zadanoMin = Int(unos[1]) else {
            print("Ne rade unešene minute")
            return 0
        }
        
        let zadanoVrijeme = zadanoH*60 + zadanoMin
        
        if zadanoVrijeme >= pocetakNastave && zadanoVrijeme <= krajNastave {
            return zadanoVrijeme
        } else {
            print("Unešeno vrijeme se nalazi izvan termina kolegija.")
            return 0
        }
    }
    
    func obradaNastave(maliOdmor: Int, velikiOdmor: Int, terminVelikiOdmor: Int){
        
        var i = pocetakNastave
        
        while i < krajNastave {
            
            if uTijekuNastava {
                satCounter += 1
                stringArray.append("sat #\(satCounter)")
                i += trajanjeSat
                intArray.append(i)
                izmijeniNastavu()
            }else{
                if provjeriVelikiOdmor(termin: terminVelikiOdmor) {
                    stringArray.append("veliki odmor")
                    i += velikiOdmor
                    intArray.append(i)
                    izmijeniNastavu()
                } else {
                    maliOdmorCounter += 1
                    stringArray.append("mali odmor #\(maliOdmorCounter)")
                    i += maliOdmor
                    intArray.append(i)
                    izmijeniNastavu()
                }
            }
        }
    }
    
    func pronadiZadanoVrijeme(zadanoVrijeme: Int) {
        
        for i in 0...stringArray.count{
            if intArray[i] > zadanoVrijeme {
                print("Zadano vrijeme: \(stringArray[i])")
                return
            }
        }
    }
    
    func provjeriVelikiOdmor(termin: Int) -> Bool {
        if satCounter == termin {
            return true
        } else {
            return false
        }
    }
    
    func izmijeniNastavu(){
        uTijekuNastava = !uTijekuNastava
    }
    
}
