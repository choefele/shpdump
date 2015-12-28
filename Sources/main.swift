import Commander

command(
    Argument<String>("shapefile")
  ) { fileName in
    guard let shapefile = Shapefile(fileName: fileName) else {
      return
    }
    
    print("Shapefile Type: \(shapefile.shapeTypeName)   # of Shapes: \(shapefile.shapes.count)\n")
    
    print("File Bounds: \(shapefile.minBounds)")
    print("         to  \(shapefile.maxBounds)\n")
    
    for shape in shapefile.shapes {
      print( "Shape:\(shape.shapeTypeName)  nVertices=\(shape.numberOfVertices), nParts=\(shape.numberOfParts)")
    }
}.run()
