# shpdump
Tool to dump information contained in [shapefiles](https://en.wikipedia.org/wiki/Shapefile#Mixing_shape_types). This is a Swift port of the tool that's part of [shapelib](http://shapelib.maptools.org/shapelib-tools.html#shpdump).

## Build
You need to have Swift installed either via `brew install swift` or from `swift.org`
```
brew install shapelib
swift build
```

## Run

```
$ .build/debug/shpdump lines
Shapefile Type: Arc   # of Shapes: 5

File Bounds: (13.394208037171223, 52.510181887430107, 0.0, 0.0)
         to  (13.416767305660128, 52.523441582610694, 0.0, 0.0)

Shape:Arc  nVertices=42, nParts=1
Shape:Arc  nVertices=27, nParts=1
Shape:Arc  nVertices=2, nParts=1
Shape:Arc  nVertices=12, nParts=1
Shape:Arc  nVertices=12, nParts=1
```


