# Game of Life

Usage:
```

// Starting matrix, 0 = dead cell, 1 = live cell
// width and height must be the same (errors if not, can be easily fixed)
let inputMatrix: [[Int]] = [
  [0, 1, 0],
  [0, 1, 0],
  [0, 1, 0]
]

// Define a renderer function that will be executed on each frame / tick.
// Example by printing console, you could, say for example, draw a grid with Core Graphics on iOS:
func renderCells (_ cells: [[Int]]) -> Void {
    cells.forEach {
        $0.forEach { print($0 == 1 ? "0" : "-", terminator: "") }
        print("")
    }
}

// Start game
loopWithMatrix(inputMatrix, 0.5, renderer: renderCells)

```
