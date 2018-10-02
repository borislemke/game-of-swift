import Foundation

let neighbourCoordinates = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

func getNeighboursOfCellAt (_ x: Int, _ y: Int, gridSize: Int) -> [[Int]] {
    return neighbourCoordinates.map{ [x + $0[0], y + $0[1]] }
        // This filter will ensure that out-of-bound cells are not calculated
        .filter { $0[0] >= 0 && $0[0] < gridSize && $0[1] >= 0 && $0[1] < gridSize }
}

func countLiveCellNeighboursAt (x: Int, y: Int, cells: [[Int]]) -> Int {
    return getNeighboursOfCellAt(x, y, gridSize: cells.count)
        .map{ cells[$0[1]][$0[0]] }.filter{ $0 == 1 }.count
}

// You can do better than this...
func setStateByNeighBourAndPreviousState(_ liveNeighbours: Int, _ state: Int) -> Int {
    switch true {
    case state == 1 && (liveNeighbours < 2 || liveNeighbours > 3):
        return 0
    case (state == 0 && liveNeighbours == 3) || (state == 1 && liveNeighbours == 2 || liveNeighbours == 3):
        return 1
    default:
        return state
    }
}

func prepareNextCellsState (_ cells: [[Int]]) -> [[Int]] {
    return cells.enumerated().map { y, column in
        return column.enumerated().map { x, cell in
            let neighbours = countLiveCellNeighboursAt(x: x, y: y, cells: cells)
            return setStateByNeighBourAndPreviousState(neighbours, cell)
        }
    }
}

func loopWithMatrix (_ matrix: [[Int]], _ refreshRate: Double, renderer: @escaping ([[Int]]) -> Void) {
    renderer(matrix)
    let nextMatrix = prepareNextCellsState(matrix)
    DispatchQueue.main.asyncAfter(deadline: .now() + refreshRate) {
        loopWithMatrix(nextMatrix, refreshRate) { renderer($0) }
    }
}

