# set execution policy; adjust as needed to work in your environment
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine

# get services list, remove double quotes, and dump to text file
get-service| ConvertTo-Csv -NoTypeInformation | % { $_ -replace '"', ""} | out-file .\services.txt
# read in dump file and skip first line
$results =get-content .\services.txt |select-object -skip 1

ForEach ($line in $results)
{
    # split on comma get each column
    $arrData =$line.Split(",")
    #$arrData[0] - shortname
    #$arrData[5] - service name
    #$arrData[11] - status
    # replace special character ampersand with "And"
    if ($arrData[5] -match "&")
    {
        $arrData[5] =$arrData[5] -replace "&", "And"
    }
    # replace status string with integer
    switch ($arrData[11])
    {
        'Stopped'{ $status =0 }
        'Running'{ $status =1 }
        'Pending'{ $status =2 }
    }
    # send data to stdout
    Write-Host "<metric type=`"StringEvent`" name=`"Windows Services|$($arrData[0]):Service Name`" value=`"$($arrData[5])`"/>"
    Write-Host "<metric type=`"IntCounter`" name=`"Windows Services|$($arrData[0]):Status`" value=`"$($status)`"/>"
}
