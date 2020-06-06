
import Foundation

class SpecProvider {
    
    static let currentSpec: Spec = {
        #if DEBUG
        return ProdSpec()
        #elseif ADHOC
        return ProdSpec()
        #else
        return ProdSpec()
        #endif
    } ()
}
