import Foundation

public class Palindrom {
    
    public init() {}
    
    public func provjeriPalindrom(string: String) -> String {
        let palindrom = string.lowercased().replacingOccurrences(of: " ", with: "")
        let length = palindrom.count/2
        
        for i in 0..<length {
                
            let start = palindrom.index(palindrom.startIndex, offsetBy: i)
            let end = palindrom.index(palindrom.endIndex, offsetBy: -1-i)
            
            if palindrom[start] != palindrom[end]{
                return "Unos \(palindrom) nije palindrom"
            }
        }
        
        return "Unos \(palindrom) je palindrom!"
    
    }
}
