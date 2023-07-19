Public Class ArtAttack
    'Declare global variables and arrays
    Dim i, j, k, x, y, z As Integer
    Dim colours() As String = {"red", "orange", "yellow", "green", "blue"}
    Dim shapes() As String = {"circle", "square", "triangle", "rectangle"}
    Dim canvas(1000, 2000) As String
    
    Sub Main()
        'Randomly assign colours and shapes to points on canvas
        Randomize()
        For i = 0 To 1000
            For j = 0 To 2000
                x = Int(Rnd() * 5)
                y = Int(Rnd() * 4)
                canvas(i, j) = colours(x) & shapes(y)
            Next
        Next
        
        'Randomly assign position for shapes
        For k = 0 To 200
            x = Int(Rnd() * 1000)
            y = Int(Rnd() * 2000)
            z = Int(Rnd() * 4)
            canvas(x, y) = shapes(z)
        Next
        
        'Print canvas on screen
        For i = 0 To 1000
            For j = 0 To 2000
                Console.Write(canvas(i, j) & " ")
            Next
            Console.WriteLine()
        Next
    End Sub
End Class