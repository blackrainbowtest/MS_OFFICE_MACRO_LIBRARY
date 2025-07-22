Attribute VB_Name = "CreateDocs"
Const TemplateFileName = "marum template.dotx"
Const TemplateFileNameERA = "era template.dotx"
Const ProcessingColCount = 21
Const ExtensionGeneratedFiles = ".docx"
#If VBA7 Then
    Private Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As LongPtr)
#Else
    Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#End If

Sub ReportsGenerator()
    Application.ScreenUpdating = False
    Sheets("AutoCreate").Select
    TemplatePath = Replace(ThisWorkbook.FullName, ThisWorkbook.Name, TemplateFileName)
    NewFolder = NewFolderName & Application.PathSeparator
    Dim row As Range, pi As New ProgressIndicator
    r = Cells(Rows.Count, "A").End(xlUp).row: RC = r - 2
    If RC < 1 Then MsgBox "Ùß³ÏÙ³Ý »ÝÃ³Ï³ ïáÕ ãÇ Ñ³ÛïÝ³µ»ñí»É", vbCritical: Exit Sub

    pi.Show "Ø³ñáõÙÝ»ñÇ Ý³Ë³å³ïñ³ëïáõÙ": pi.ShowPercents = True: s1 = 10: s2 = 90: p = s1: a = (s2 - s1) / RC
    pi.StartNewAction , s1, "Microsoft Word Íñ³·ñÇ ÙÇ³óáõÙ"

    ' Dim WA As Word.Application, WD As Word.Document: Set WA = New Word.Application    ' c ïîäêëþ÷åíèåì áèáëèîòåêè Word
    Dim WA As Object, WD As Object: Set WA = CreateObject("Word.Application")           ' áåç ïîäêëþ÷åíèÿ áèáëèîòåêè Word

    For Each row In ActiveSheet.Rows("3:" & r)
        With row
            AAH = Trim$(.Cells(1)) & " " & Trim$(.Cells(2)) & " " & Trim$(.Cells(3))
            fileName = NewFolder & AAH & ExtensionGeneratedFiles

            pi.StartNewAction p, p + a / 3, "Üáñ ý³ÛÉÇ ëï»ÕÍáõÙ Ñ³Ù³Ó³ÛÝ Ý³Ëáñáßí³Í ß³µÉáÝÇ", AAH       ' shabloni stexcum
            Set WD = WA.Documents.Add(TemplatePath): DoEvents

            pi.StartNewAction p + a / 3, p + a * 2 / 3, "ïíÛ³ÉÝ»ñÇ ÷á÷áËáõÙ ...", AAH
            For i = 1 To ProcessingColCount
                FindText = Cells(1, i): ReplaceText = Trim$(.Cells(i))
                ' ****** change all data ******
                pi.line3 = "¸³ßï»ñÇ ÷á÷áËáõÙ " & FindText
                With WD.Range.Find
                    .TEXT = FindText
                    .Replacement.TEXT = ReplaceText
                    .Forward = True
                    .Wrap = 1
                    .Format = False: .MatchCase = False
                    .MatchWholeWord = False
                    .MatchWildcards = False
                    .MatchSoundsLike = False
                    .MatchAllWordForms = False
                    .Execute Replace:=2
                End With
                DoEvents
            Next i
            pi.StartNewAction p + a * 2 / 3, p + a, "ü³ÛÉÇ å³Ñå³ÝáõÙ ...", AAH, " "
            ' ****** printing selected WD ******
            If Sheets("BASE").Range("B18").Value = 1 Then
                WD.PrintOut
            End If
            ' ****** save WD ******
            WD.SaveAs fileName: WD.Close False: DoEvents
            p = p + a
        End With
    Next row
    pi.StartNewAction s2, , "Microsoft Word Íñ³·ñÇ ³í³ñïáõÙ", " ", " "
    WA.Quit False: pi.Hide
    Complete.Show
    'msg = Sheets("BASE").Range("A2").Value & RC & Sheets("BASE").Range("A3").Value & vbNewLine & NewFolder & Sheets("BASE").Range("A4").Value
    'MsgBox msg, vbInformation, "ä³ïñ³ëï ¿"
    Sheets("TempDataBase").Select
    Application.ScreenUpdating = True
End Sub


Sub EraReportsGenerator()
    Application.ScreenUpdating = False
    Sheets("AutoCreate").Select
    TemplatePath = Replace(ThisWorkbook.FullName, ThisWorkbook.Name, TemplateFileNameERA)
    NewFolder = NewFolderNameEra & Application.PathSeparator
    Dim row As Range, pi As New ProgressIndicator
    r = Cells(Rows.Count, "A").End(xlUp).row: RC = r - 2
    If RC < 1 Then MsgBox "Ùß³ÏÙ³Ý »ÝÃ³Ï³ ïáÕ ãÇ Ñ³ÛïÝ³µ»ñí»É", vbCritical: Exit Sub

    pi.Show "Ø³ñáõÙÝ»ñÇ Ý³Ë³å³ïñ³ëïáõÙ": pi.ShowPercents = True: s1 = 10: s2 = 90: p = s1: a = (s2 - s1) / RC
    pi.StartNewAction , s1, "Microsoft Word Íñ³·ñÇ ÙÇ³óáõÙ"

    ' Dim WA As Word.Application, WD As Word.Document: Set WA = New Word.Application    ' c ïîäêëþ÷åíèåì áèáëèîòåêè Word
    Dim WA As Object, WD As Object: Set WA = CreateObject("Word.Application")           ' áåç ïîäêëþ÷åíèÿ áèáëèîòåêè Word

    For Each row In ActiveSheet.Rows("3:" & r)
        With row
            AAH = Trim$(.Cells(1)) & " " & Trim$(.Cells(2)) & " " & Trim$(.Cells(3))
            fileName = NewFolder & AAH & ExtensionGeneratedFiles

            pi.StartNewAction p, p + a / 3, "Üáñ ý³ÛÉÇ ëï»ÕÍáõÙ Ñ³Ù³Ó³ÛÝ Ý³Ëáñáßí³Í ß³µÉáÝÇ", AAH       ' shabloni stexcum
            Set WD = WA.Documents.Add(TemplatePath): DoEvents

            pi.StartNewAction p + a / 3, p + a * 2 / 3, "ïíÛ³ÉÝ»ñÇ ÷á÷áËáõÙ ...", AAH
            For i = 1 To ProcessingColCount
                FindText = Cells(1, i): ReplaceText = Trim$(.Cells(i))
                ' ****** change all data ******
                pi.line3 = "¸³ßï»ñÇ ÷á÷áËáõÙ " & FindText
                With WD.Range.Find
                    .TEXT = FindText
                    .Replacement.TEXT = ReplaceText
                    .Forward = True
                    .Wrap = 1
                    .Format = False: .MatchCase = False
                    .MatchWholeWord = False
                    .MatchWildcards = False
                    .MatchSoundsLike = False
                    .MatchAllWordForms = False
                    .Execute Replace:=2
                End With
                DoEvents
            Next i
            pi.StartNewAction p + a * 2 / 3, p + a, "ü³ÛÉÇ å³Ñå³ÝáõÙ ...", AAH, " "
            ' ****** printing selected WD ******
            If Sheets("BASE").Range("B18").Value = 1 Then
                WD.PrintOut
            End If
            ' ****** save WD ******
            WD.SaveAs fileName: WD.Close False: DoEvents
            p = p + a
        End With
    Next row
    pi.StartNewAction s2, , "Microsoft Word Íñ³·ñÇ ³í³ñïáõÙ", " ", " "
    WA.Quit False: pi.Hide
    Complete.Show
    'msg = Sheets("BASE").Range("A2").Value & RC & Sheets("BASE").Range("A3").Value & vbNewLine & NewFolder & Sheets("BASE").Range("A4").Value
    'MsgBox msg, vbInformation, "ä³ïñ³ëï ¿"
    Sheets("TempDataBase").Select
    Application.ScreenUpdating = True
End Sub

Function NewFolderName() As String
    Dim Year5
    Year5 = Year(Get_Date)
    NewFolderName = Replace(ThisWorkbook.FullName, ThisWorkbook.Name, Year5 & " MARUM\" & MainFolderName & " MARUM AUTO")
    If Dir(NewFolderName, vbDirectory) = "" Then
        MkDir NewFolderName
    End If
End Function

Function NewFolderNameEra() As String
    Dim Year5
    Year5 = Year(Get_Date)
    NewFolderNameEra = Replace(ThisWorkbook.FullName, ThisWorkbook.Name, Year5 & " MARUM\" & MainFolderName & " ERA")
    If Dir(NewFolderNameEra, vbDirectory) = "" Then
        MkDir NewFolderNameEra
    End If
End Function

Function Get_Date() As String: Get_Date = Replace(Replace(DateValue(Now), "/", "-"), ".", "-"): End Function
Function Get_Time() As String: Get_Time = Replace(TimeValue(Now), ":", "-"): End Function
Function Get_Now() As String: Get_Now = Get_Date & " â " & Get_Time: End Function

Function MainFolderName() As String
    Dim ReturnData, Year5, Month5, Day5
    Day5 = Day(Get_Date)
    If Day5 < 10 Then
        Day5 = 0 & Day5
    End If
    Month5 = Month(Get_Date)
    If Month5 < 10 Then
        Month5 = 0 & Month5
    End If
    Year5 = Mid(Year(Get_Date), 3, 2)
    MainFolderName = Year5 & "." & Month5 & "." & Day5
End Function

Sub ConvertWordDocsToPDF()
    Dim folderPath As String
    Dim fileList As Collection
    Dim pi As New ProgressIndicator

    ' Step 1: Get folder and .docx files
    folderPath = GetTargetFolder()
    If folderPath = "" Then Exit Sub

    Set fileList = GetDocxFileList(folderPath)
    If fileList.Count = 0 Then
        MsgBox "No .docx files found in: " & folderPath, vbInformation
        Exit Sub
    End If

    ' Step 2: Initialize progress bar
    pi.Show "Converting Word documents to PDF"
    pi.ShowPercents = True

    ' Step 3: Convert documents
    ConvertFilesToPDF folderPath, fileList, pi

    ' Step 4: Finalize
    pi.StartNewAction 90, , "Finalizing...", "Moving original Word files..."
    Call MoveWordDocsToSubfolder(folderPath)
    pi.Hide
End Sub

Private Function GetTargetFolder() As String
    Dim folderPath As String
    folderPath = NewFolderName()
    If Right(folderPath, 1) <> "\" Then folderPath = folderPath & "\"
    If Dir(folderPath, vbDirectory) = "" Then
        MsgBox "Folder not found: " & folderPath, vbCritical
        GetTargetFolder = ""
    Else
        GetTargetFolder = folderPath
    End If
End Function

Private Function GetDocxFileList(folderPath As String) As Collection
    Dim fileList As New Collection
    Dim fileName As String
    fileName = Dir(folderPath & "*.docx")
    Do While fileName <> ""
        fileList.Add fileName
        fileName = Dir()
    Loop
    Set GetDocxFileList = fileList
End Function

Private Sub ConvertFilesToPDF(folderPath As String, fileList As Collection, pi As ProgressIndicator)
    Dim wordApp As Object, doc As Object
    Dim i As Long
    Dim fileName As String, pdfName As String
    Dim s1 As Integer, s2 As Integer, p As Single, a As Single

    ' Progress range
    s1 = 10: s2 = 90
    p = s1
    a = (s2 - s1) / fileList.Count
    pi.StartNewAction , s1, "Starting Microsoft Word..."

    ' Start Word
    On Error Resume Next
    Set wordApp = GetObject(, "Word.Application")
    If wordApp Is Nothing Then Set wordApp = CreateObject("Word.Application")
    On Error GoTo 0

    If wordApp Is Nothing Then
        MsgBox "Failed to start Microsoft Word", vbCritical
        pi.Hide
        Exit Sub
    End If
    wordApp.Visible = False

    ' Main loop
    For i = 1 To fileList.Count
        On Error GoTo ConversionError

        fileName = fileList(i)
        pdfName = folderPath & Replace(fileName, ".docx", ".pdf")

        pi.StartNewAction p, p + a / 2, "Opening document...", , fileName
        Set doc = wordApp.Documents.Open(folderPath & fileName, ReadOnly:=True)
        DoEvents

        If doc Is Nothing Then
            MsgBox "Could not open file: " & fileName, vbExclamation
            GoTo ContinueLoop
        End If

        pi.StartNewAction p + a / 2, p + a, "Exporting to PDF...", , fileName
        doc.ExportAsFixedFormat OutputFileName:=pdfName, ExportFormat:=17
        doc.Close False
        Set doc = Nothing

        DoEvents
        Sleep 500 ' allow cleanup
        p = p + a
        GoTo ContinueLoop

ConversionError:
        MsgBox "Error converting file: " & fileName & vbCrLf & "Error: " & Err.Description, vbCritical
        If Not doc Is Nothing Then
            On Error Resume Next
            doc.Close False
            Set doc = Nothing
            On Error GoTo 0
        End If

ContinueLoop:
        On Error GoTo 0
    Next i

    wordApp.Quit
    Set wordApp = Nothing
End Sub

Sub MoveWordDocsToSubfolder(folderPath As String)
    Dim fso As Object
    Dim sourceFile As String
    Dim destinationFolder As String
    
    Set fso = CreateObject("Scripting.FileSystemObject")

    ' Add a slash if there isn't one.
    If Right(folderPath, 1) <> "\" Then folderPath = folderPath & "\"

    ' Assignments folder
    destinationFolder = folderPath & "Words\"

    ' Create a folder if it doesn't exist
    If Dir(destinationFolder, vbDirectory) = "" Then
        MkDir destinationFolder
    End If

    ' Move all .docx files
    sourceFile = Dir(folderPath & "*.docx")
    Do While sourceFile <> ""
        Name folderPath & sourceFile As destinationFolder & sourceFile
        sourceFile = Dir()
    Loop

    'MsgBox "Word files have been moved to the folder: " & destinationFolder, vbInformation
End Sub
