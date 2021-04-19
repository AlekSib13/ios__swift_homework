import UIKit

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//
//6. Вывести сами объекты в консоль.



enum CarTypes: String {
    case sedan = "Седан"
    case coupe = "Купэ"
    case universal = "Универсал"
    case hatchback = "Хэтчбэк"
    case offroad = "Внедорожник"
    case lorry  = "Грузовой"
}

enum EngineStatus: String {
    case start = "Двигатель запущен"
    case stop = "Двигатель остановлен"
}

enum HoodStatus: String {
    case open = "Капот открыт"
    case close = "Капот закрыт"
}

enum WindowsStatus: String {
    case open = "Окна открыты"
    case close = "Окна закрыты"
}



protocol Car: class {
    var brand: String {get}
    var place_of_production: String {get set}
    var car_type: CarTypes {get set}
    var engine_status: EngineStatus {get set}
    var hood_status: HoodStatus {get set}
    var windows_status: WindowsStatus {get set}
    
    func engine_start_stop(action: EngineStatus)
    func windows_open_close(action: WindowsStatus)
    func hood_open_close(action: HoodStatus)
}



extension Car {
    
    func windows_open_close(action: WindowsStatus) {
        switch action {
        case .open:
            return self.windows_status = .open
        default:
            return self.windows_status = .close
        }
    }
    
    func hood_open_close(action: HoodStatus) {
        switch action {
        case .open:
            return self.hood_status = .open
        default:
            return self.hood_status = .close
        }
        
    }
    
    func engine_start_stop(action: EngineStatus) {
        switch action {
        case .start:
            self.engine_status = .start
        default:
            self.engine_status = .stop
        }
        
    }
}




class SportCar: Car {
    var brand: String
    var place_of_production: String
    var car_type: CarTypes
    var horsepower: Int
    var additional_options: [String]
    var engine_status: EngineStatus
    var hood_status: HoodStatus
    var windows_status: WindowsStatus
    
    init(car_brand: String, origin: String, car_type: CarTypes, power: Int, additional_options: [String], engine: EngineStatus, hood: HoodStatus, windows: WindowsStatus) {
        self.brand = car_brand
        self.place_of_production = origin
        self.car_type = car_type
        self.horsepower = power
        self.additional_options = additional_options
        self.engine_status = engine
        self.hood_status = hood
        self.windows_status = windows
    }
}





class TrunkCar: Car {
    var brand: String
    var place_of_production: String
    var car_type: CarTypes
    var engine_status: EngineStatus
    var hood_status: HoodStatus
    var windows_status: WindowsStatus
    
    
    init(car_brand: String, origin: String, car_type: CarTypes, engine: EngineStatus, hood: HoodStatus, windows: WindowsStatus) {
        self.brand = car_brand
        self.place_of_production = origin
        self.car_type = car_type
        self.engine_status = engine
        self.hood_status = hood
        self.windows_status = windows
    }
}





var bmw = SportCar (car_brand: "BMW", origin: "Germany", car_type: .sedan, power: 200, additional_options: ["Зимний пакет","Электропривод багажника"], engine: .start, hood: .close, windows: .open)
var scania = TrunkCar (car_brand: "Scania", origin: "Sweden", car_type: .lorry, engine: .stop, hood: .open, windows: .close)



extension SportCar: CustomStringConvertible {
    var description: String {
       return
        """
        \n
        марка автомобиля: \(self.brand)
        место производства: \(self.place_of_production)
        тип автомобиля: \(self.car_type.rawValue)
        состояние двигателя: \(self.engine_status.rawValue)
        капот: \(self.hood_status.rawValue)
        окна: \(self.windows_status.rawValue)
        тип автомобиля: \(self.car_type.rawValue)
        лошадиные силы: \(self.horsepower)
        дополнительные опции: \(self.additional_options)\n
        """
    }
    
    
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        """
        \n
        марка автомобиля: \(self.brand)
        место производства: \(self.place_of_production)
        тип автомобиля: \(self.car_type.rawValue)
        состояние двигателя: \(self.engine_status.rawValue)
        капот: \(self.hood_status.rawValue)
        окна: \(self.windows_status.rawValue)
        тип автомобиля: \(self.car_type.rawValue)\n
        """
    }
}


print(bmw)
print(scania)

bmw.hood_open_close(action: .open)
scania.windows_open_close(action: .open)

print(bmw)
print(scania)






