import Quick
import Nimble

@testable import Stores

class DataProviderSpec: QuickSpec {
    override func spec() {
        
        var dataProvider: DataProvider<Store>!
        
        describe("DataProvider New Data") {
            
            var result: [Store] = []
            
            beforeEach {
                let db = MockDataBase(new: [["id": "ID1",
                                             "indexRow": UInt(2),
                                             "name": "MOCK Store",
                                             "count": 10],
                                            ["id": "ID2",
                                             "indexRow": UInt(3),
                                             "name": "MOCK Store 2",
                                             "count": 5]])
                dataProvider = DataProvider<Store>.init(dataBaseAPI: db)
                dataProvider.newData(completion: { (stores) in
                    result = stores
                }).listen()
            }
            
            context("when data is loaded") {
                it("should have 2 stores loaded") {
                    expect(result.count).to(equal(2))
                }
                
                it("should have 3 stores loaded") {
                    expect(result.count).to(equal(2))
                }
            }
        }
    }
}
