import Foundation

public class Igraci {
    
    public init() {}
    
    var smjer = true
    var igrac = 0
    var i = 1
    
    public func brojanjeDoN(brojN :Int){
        
        while i <= brojN {
            
            if i%7==0 {
                promijeniSmjer()
            }else if i%13==0{
                sljedeciIgrac()
            }
            
            sljedeciIgrac()
            i += 1
        }
        
        print("Igra je zavrsila na igraču broj \(igrac)")
        
    }
    
    func sljedeciIgrac(){
        
        if smjer {
            igrac += 1
        }else{
            igrac -= 1
        }
        
        if igrac == 11 {
            igrac = 1
        }else if igrac == 0 {
            igrac = 10
        }
        
    }
    
    func promijeniSmjer(){
        smjer = !smjer
    }
    
}
