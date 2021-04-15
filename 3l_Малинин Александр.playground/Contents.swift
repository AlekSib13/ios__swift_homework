import UIKit

var str = "Hello, playground"


//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//
//6. Вывести значения свойств экземпляров в консоль.



enum EngineStatus: String {
    case engine_launched = "двигатель запущен"
    case engine_stoped = "двигетель выключен"
}


enum WindowsStatus: String {
    case windows_opened = "окна открыты"
    case windows_closed = "окна закрыты"
}


enum TrunkStatus: String {
    case loaded = "багажник/кузов загружен"
    case unloaded = "багажник/кузов пустой"
}



struct SportCar {
    static var wheels = 4
    let car_brand: String
    let production_year: Int
    let trunk_volume: Int
    var engine_status: EngineStatus
    var windows_status: WindowsStatus
    var trunk_loaded: Int
    var trunk_loaded_status: TrunkStatus {
        get { if trunk_loaded != 0 {
            return .loaded
        }
            else {
                return .unloaded
        }
        }
        set { if newValue == .loaded {
            return trunk_loaded = Int.random(in: 100...trunk_volume)}
        else {
            return trunk_loaded = 0
        }
        }
    }

    func describe_car () {
        print("""
            \n\n
            марка автомобиля: \(self.car_brand),\n
            количество колес: \(SportCar.wheels),\n
            год выпуска: \(self.production_year),\n
            объем багажника: \(self.trunk_volume),\n
            багажник заполнен на: \(self.trunk_loaded),\n
            багажник: \(self.trunk_loaded_status.rawValue),\n
            двигатель: \(self.engine_status.rawValue),\n
            окна: \(self.windows_status.rawValue)
            """)
    }

    mutating func open_close_windows(status: WindowsStatus) {
        self.windows_status = status
    }

    mutating func start_stop_engine(status: EngineStatus) {
        self.engine_status = status
    }

    mutating func trunk_load_unload(status: TrunkStatus) {
        self.trunk_loaded_status = status
    }

}



var car_porshe = SportCar(car_brand: "Porshe", production_year: 1982, trunk_volume: 120, engine_status: .engine_launched, windows_status: .windows_closed, trunk_loaded: 105)

car_porshe.describe_car()
car_porshe.start_stop_engine(status: .engine_stoped)
car_porshe.describe_car()


var car_bmw = SportCar(car_brand: "BMW", production_year: 2005, trunk_volume: 130, engine_status: .engine_launched, windows_status: .windows_opened, trunk_loaded: 110)

car_bmw.describe_car()





struct TrunkCar {
    static var wheels = 6
    let car_brand: String
    let production_year: Int
    let trunk_volume: Int
    var engine_status: EngineStatus
    var windows_status: WindowsStatus
    var trunk_loaded: Int
    var trunk_loaded_status: TrunkStatus {
        get { if trunk_loaded != 0 {
            return .loaded
        }
            else {
                return .unloaded
        }
        }
        set { if newValue == .loaded {
            return trunk_loaded = Int.random(in: 100...trunk_volume)}
        else {
            return trunk_loaded = 0
        }
        }
    }
    
    
    init? (brand: String,year: Int,trunk_volume: Int, engine_status: EngineStatus, windows_status: WindowsStatus, volume_to_load: Int) {
        self.car_brand = brand
        self.production_year = year
        self.trunk_volume = trunk_volume
        guard trunk_volume >= 10_000 && trunk_volume <= 20_000 else {
            return nil
        }
        self.engine_status = engine_status
        self.windows_status = windows_status
        self.trunk_loaded = volume_to_load
        guard self.trunk_loaded <= self.trunk_volume else {
            return nil
        }
        
}
    
    mutating func open_close_windows(status: WindowsStatus) {
        self.windows_status = status
    }

    mutating func start_stop_engine(status: EngineStatus) {
        self.engine_status = status
    }

    mutating func trunk_load_unload(status: TrunkStatus) {
        self.trunk_loaded_status = status
    }

    func describe_car () {
        print("""
            \n\n
            марка автомобиля: \(self.car_brand),\n
            количество колес: \(TrunkCar.wheels),\n
            год выпуска: \(self.production_year),\n
            объем багажника: \(self.trunk_volume),\n
            багажник заполнен на: \(self.trunk_loaded),\n
            багажник: \(self.trunk_loaded_status.rawValue),\n
            двигатель: \(self.engine_status.rawValue),\n
            окна: \(self.windows_status.rawValue)
            """)
    }
}


var truck_scania = TrunkCar (brand: "Scania", year: 2010, trunk_volume: 15_000, engine_status: .engine_launched, windows_status: .windows_closed, volume_to_load: 14_000)

truck_scania?.describe_car()
truck_scania?.open_close_windows(status: .windows_opened)
truck_scania?.describe_car()

var truck_mercedes = TrunkCar(brand: "Mercedes", year: 2018, trunk_volume: 17_000, engine_status: .engine_stoped, windows_status: .windows_opened, volume_to_load: 17_000)

truck_mercedes?.describe_car()
truck_mercedes?.trunk_load_unload(status: .unloaded)
truck_mercedes?.describe_car()
