$ErrorActionPreference = 'Stop';


$packageName= 'gatling' # arbitrary name for the package, used in messages
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$folderName = 'gatling-charts-highcharts-bundle-2.2.0'
$url        = "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/2.2.0/$folderName-bundle.zip" # download url

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url

  # optional, highly recommended
  softwareName  = 'gatling*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = ''
  checksumType  = 'md5' #default is md5, can also be sha1
}

Install-ChocolateyZipPackage @packageArgs

$unziped = Join-Path $toolsDir $folderName
Write-Warning "Moving all files from $unziped to $toolsDir"
# Moving all unpacked folder content to toolsDir
mv "$unziped\*" $toolsDir

rm $unziped

$binPath = Join-Path $toolsDir 'bin'
Write-Warning "Adding $binPath to PATH"
Install-ChocolateyPath $binPath

Install-ChocolateyEnvironmentVariable "GATLING_HOME" $toolsDir
