import CShapelib

class Shapefile {
  let shapeType: Int
  let shapeTypeName: String
  let minBounds: (Double, Double, Double, Double)
  let maxBounds: (Double, Double, Double, Double)
  let shapes: [Shape]

  private let handle: UnsafeMutablePointer<SHPInfo>
  
  init?(fileName: String) {
    handle = SHPOpen(fileName, "rb")
    if handle == nil {
      return nil
    }
    
    let (numberOfShapes, shapeType, minBounds, maxBounds) = Shapefile.getInfo(handle)
    self.shapeType = shapeType
    self.shapeTypeName =  Shapefile.typeName(shapeType)
    self.minBounds = minBounds
    self.maxBounds = maxBounds
    
    self.shapes = Shapefile.readShapes(handle, numberOfShapes:numberOfShapes)
  }
  
  deinit {
    SHPClose(handle)
  }
  
  private class func getInfo(handle: UnsafeMutablePointer<SHPInfo>) -> (Int, Int, (Double, Double, Double, Double), (Double, Double, Double, Double)) {
    var numberOfShapes: CInt = 0, shapeType: CInt = 0;
    var minBounds = [0.0, 0.0, 0.0, 0.0], maxBounds = [0.0, 0.0, 0.0, 0.0]
    SHPGetInfo(handle, &numberOfShapes, &shapeType, &minBounds, &maxBounds);

    return (Int(numberOfShapes), Int(shapeType), (minBounds[0], minBounds[1], minBounds[2], minBounds[3]), (maxBounds[0], maxBounds[1], maxBounds[2], maxBounds[3]))
  }
  
  private class func typeName(shapeType: Int) -> String {
    let typeName = String.fromCString(SHPTypeName(CInt(shapeType))) ?? "unknown"
    return typeName
  }

  private class func readShapes(handle: UnsafeMutablePointer<SHPInfo>, numberOfShapes: Int) -> [Shape] {
    var shapes = [Shape]()
    for index in 0..<numberOfShapes {
      if let shape = Shapefile.readShape(handle, index:index) {
        shapes.append(shape)        
      }
    }
    
    return shapes
  }
  
  private class func readShape(handle: UnsafeMutablePointer<SHPInfo>, index: Int) -> Shape? {
    let shapeHandle = SHPReadObject(handle, CInt(index))
    if shapeHandle == nil {
      return nil
    }
    
    let shapeType = Int(shapeHandle.memory.nSHPType)
    let shapeTypeName = Shapefile.typeName(shapeType)
    let numberOfVertices = Int(shapeHandle.memory.nVertices)
    let numberOfParts = Int(shapeHandle.memory.nParts)
    
    SHPDestroyObject(shapeHandle)
  
    return Shape(shapeType: shapeType, shapeTypeName: shapeTypeName, numberOfVertices: numberOfVertices, numberOfParts: numberOfParts)
  }
}