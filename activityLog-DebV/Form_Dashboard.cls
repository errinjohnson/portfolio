VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_Dashboard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database

Private Declare PtrSafe Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As LongPtr, _
    ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, _
    ByVal nShowCmd As Long) As LongPtr

Private Sub btnUpload_Click()
    On Error GoTo ErrorHandler

    Dim fd As fileDialog
    Dim selectedFilePath As String
    Dim participantName As String
    Dim folderPath As String
    Dim fileSystem As Object
    Dim targetFolderPath As String
    Dim exeFilePath As String
    Dim parameters As String
    Dim startTime As Double
    Dim logFilePath As String
    Dim errorMessage As String
    Dim awsProfile As String
    Dim awsBucketName As String
    Dim jsonContent As String
    Dim json As Object
    Dim config As Object
    
    ' Initialize the FileSystemObject
    Set fileSystem = CreateObject("Scripting.FileSystemObject")

    ' Initialize the FileDialog
    Set fd = Application.fileDialog(msoFileDialogFilePicker)

    ' Set the properties for the FileDialog
    With fd
        .title = "Select a file to upload"
        .Filters.Add "All Files", "*.*"
        .AllowMultiSelect = False

        ' Show the dialog and check if a file was selected
        If .Show = -1 Then
            selectedFilePath = .SelectedItems(1)
        Else
            MsgBox "No file selected.", vbInformation
            Exit Sub
        End If
    End With

    ' Get the selected participant's name
    participantName = Me.cmbParticipants.Value

    ' Define the target folder path for S3Uploader files on C drive
    targetFolderPath = "C:\S3Uploader"

    ' Create the target folder if it doesn't exist
    If Not FolderExistsOrCreate(fileSystem, targetFolderPath) Then
        MsgBox "Failed to create target folder: " & targetFolderPath, vbExclamation
        Exit Sub
    End If

    ' Specify the path to the .NET executable and parameters for S3Uploader
    exeFilePath = targetFolderPath & "\S3Uploader.exe"

    ' Path to appsettings.json for AWS credentials
    Dim appSettingsPath As String
    appSettingsPath = targetFolderPath & "\appsettings.json"

    ' Check if appsettings.json exists
    If Not fileSystem.FileExists(appSettingsPath) Then
        ' Download appsettings.json from AWS
        If Not DownloadFileFromS3("default-profile", "authbillpro", "appsettings.json", appSettingsPath) Then
            MsgBox "Failed to download appsettings.json file from AWS.", vbExclamation
            Exit Sub
        End If
    End If

    ' Load AWS credentials from appsettings.json
    ' Read appsettings.json content
    Open appSettingsPath For Input As #1
    jsonContent = Input$(LOF(1), 1)
    Close #1

    ' Parse JSON content
    Set json = JsonConverter.ParseJson(jsonContent)
    Set config = json("AWS")

    ' Extract AWS credentials
    awsProfile = config("Profile")
    awsBucketName = config("BucketName")

    ' Define publish folder name in S3
    Dim publishFolderInS3 As String
    publishFolderInS3 = "publish/"  ' Replace with actual folder name

    ' Parameters for S3Uploader.exe
    parameters = awsProfile & " " & publishFolderInS3

    ' Run the .NET application to download the publish folder and appsettings.json from S3
    ShellExecute 0, "open", exeFilePath, parameters, vbNullString, 1

    ' Wait for the download process to complete (adjust time as needed)
    startTime = Timer
    Do While Timer < startTime + 30 ' Wait for 30 seconds (adjust as needed)
        DoEvents ' Allow other events to process
    Loop

    ' Check if the publish folder and appsettings.json are downloaded
    If Not fileSystem.FolderExists(targetFolderPath & "\publish") Or Not fileSystem.FileExists(appSettingsPath) Then
        MsgBox "Failed to download required files from AWS.", vbExclamation
        Exit Sub
    End If

    ' Replace spaces with underscores in participant name
    participantName = Replace(participantName, " ", "_")

    ' Define the folder path for participant uploads
    folderPath = "C:\uploads\" & participantName

    ' Create the participant folder if it doesn't exist
    If Not FolderExistsOrCreate(fileSystem, folderPath) Then
        MsgBox "Failed to create participant folder: " & folderPath, vbExclamation
        Exit Sub
    End If

    ' Copy the selected file to the participant's folder
    fileSystem.CopyFile selectedFilePath, folderPath & "\" & fileSystem.GetFileName(selectedFilePath)

    ' Success message
    MsgBox "File uploaded successfully to " & folderPath, vbInformation

    ' Clean up
    Set fileSystem = Nothing
    Set fd = Nothing
    Exit Sub

ErrorHandler:
    ' Handle errors that might occur during different code sections
    MsgBox "Error: " & Err.Description, vbCritical
    Set fileSystem = Nothing
    Set fd = Nothing
End Sub

Private Function FolderExistsOrCreate(ByRef fileSystem As Object, ByVal folderPath As String) As Boolean
    On Error Resume Next
    If Not fileSystem.FolderExists(folderPath) Then
        fileSystem.CreateFolder folderPath
    End If
    FolderExistsOrCreate = fileSystem.FolderExists(folderPath)
    On Error GoTo 0
End Function

Private Function DownloadFileFromS3(ByVal profile As String, ByVal bucketName As String, ByVal keyName As String, ByVal savePath As String) As Boolean
    Dim s3Client As Object
    Dim getObjectRequest As Object

    On Error GoTo ErrorHandler

    ' Create the AmazonS3Client object
    Set s3Client = CreateObject("Amazon.S3.AmazonS3Client")
    
    ' Create the GetObjectRequest object
    Set getObjectRequest = CreateObject("Amazon.S3.Model.GetObjectRequest")
    
    ' Set properties of GetObjectRequest
    s3Client.profile = profile
    getObjectRequest.bucketName = bucketName
    getObjectRequest.Key = keyName
    
    ' Download file from S3
    s3Client.GetObject getObjectRequest, savePath
    
    DownloadFileFromS3 = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error downloading file from S3: " & Err.Description, vbExclamation
    DownloadFileFromS3 = False
End Function
