import UIKit

var str = "Hello, playground"


import UIKit

//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.



enum BuingErrors: String, Error{
    case insuffisientQuantity = "Недостаточное количество товара"
    
}



enum Sex: String {
    case men = "Мужская"
    case womean = "Женская"
    case unisex = "Юнисекс"
}


protocol ApparelAndFootwear {
    var name: String {get}
    var size: Int {get}
    var description: String {get}
    var sex: Sex {get}
}



class ClothesStock: ApparelAndFootwear {
    let name: String, size: Int, description: String, sex: Sex
    
    static var stocksLevels = Dictionary<String,Int>()
    
    
    init(clothesName: String, clothesSize: Int, clothesDescription: String, clothesSex: Sex) {
        self.name = clothesName
        self.size = clothesSize
        self.description = clothesDescription
        self.sex = clothesSex
    }
    
    func increaseStocks(name: String, quantity: Int) {
        if let value = ClothesStock.stocksLevels[name] {
            return ClothesStock.stocksLevels[name] = value + quantity
        } else {
            return ClothesStock.stocksLevels[name] = quantity
        }
    }
    
}
    

class OnlineGarmentShop: ClothesStock {
    var qty: Int, price: Decimal
    
    init?(clothesName: String, clothesSize: Int, clothesDescription: String, clothesSex: Sex, clothesQuantity: Int, clothesPrice: Decimal) {
        guard clothesQuantity > 0  &&  clothesPrice > 0 else {
            return nil
        }
        
        self.qty = clothesQuantity
        self.price = clothesPrice
        super.init(clothesName: clothesName, clothesSize: clothesSize, clothesDescription: clothesDescription, clothesSex: clothesSex)
        
        super.increaseStocks(name: self.name, quantity: self.qty)
    }
}



extension ClothesStock {
    func decreaseStocks(name: String, quantity: Int) throws {
        if let value = ClothesStock.stocksLevels[name] {
            guard value - quantity > 0 else { throw BuingErrors.insuffisientQuantity}
                ClothesStock.stocksLevels[name] = value - quantity
            }
        }
    }



extension OnlineGarmentShop {
    func buy (quantity: Int) {
        do {
        try decreaseStocks(name: self.name, quantity: quantity)
        }
        catch BuingErrors.insuffisientQuantity {
            print(BuingErrors.insuffisientQuantity.rawValue)
        }
        catch {print("Иная ошибка") }
    }
}





var jeans = OnlineGarmentShop(clothesName: "jeans", clothesSize: 32, clothesDescription: "levis jeans", clothesSex: .men, clothesQuantity: 3, clothesPrice: 300)
jeans = OnlineGarmentShop(clothesName: "jeans", clothesSize: 32, clothesDescription: "levis jeans", clothesSex: .men, clothesQuantity: 4, clothesPrice: 300)

var skirts = OnlineGarmentShop(clothesName: "skirts", clothesSize: 25, clothesDescription: "white skirts", clothesSex: .womean, clothesQuantity: 12, clothesPrice: 35)

//skirts = OnlineGarmentShop(clothesName: "skirts", clothesSize: 25, clothesDescription: "white skirts", clothesSex: .womean, clothesQuantity: -3, clothesPrice: 35)


skirts?.buy(quantity: 2)
jeans?.buy(quantity: 6)
skirts?.buy(quantity: 3)
jeans?.buy(quantity: 3)


ClothesStock.stocksLevels



