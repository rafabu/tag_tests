#$bicepFilePath = $stdInput.bicepFilePath

$bicepFilePath = "C:\Users\raphael.burri\Repos\work.isolutions.marina\issb-07\data_tenant\issb-07\tenant-service-arm-monitor\monitor-class-example\web-tests\wt-example-webtest.bicep"

if ((Test-Path $bicepFilePath) -eq $false) {
    Write-Error ("ERROR: Unable to find file {0}" -f $bicepFilePath)
}

# build ARM template
$armTemplate = (az bicep build --file "$bicepFilePath" --stdout)
# encode to overcome tf's limitation of string only output values
try {
    $armTemplateEncoded = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($armTemplate))
}
catch {
    Write-Error ("ERROR: Unable to encode template file {0} after bicep to arm build. Build output: {1}" -f $bicepFilePath, $armTemplate)
    exit
}

Write-Output @{
    # "armTemplateEncoded" = $armTemplateEncoded
    "armTemplateEncoded" = @{}
    "test" = "test"
}  | ConvertTo-JSON