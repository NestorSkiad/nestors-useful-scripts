param (
    [Parameter(Mandatory=$true)]
    [string]$outputFolder
)

$inputFolder = Get-Location  # Current directory

# Ensure output folder exists
if (!(Test-Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder | Out-Null
}

# Process each .mkv file
Get-ChildItem -Path $inputFolder -Filter "*.mkv" | ForEach-Object {
    $inputFile = $_.Name  # Use relative filename
    $outputFile = Join-Path -Path $outputFolder -ChildPath $_.Name

    # Construct the FFMPEG command
    $ffmpegCommand = "ffmpeg -i `"$inputFile`" -map 0 -c:v copy -c:s copy -ac 2 -c:a ac3 -b:a 640k -ar 48000 `"$outputFile`""

    # Print the command for debugging
    Write-Host "Executing: $ffmpegCommand"

    # Run the command
    Invoke-Expression $ffmpegCommand
}
