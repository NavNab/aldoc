$app = '.\NavNab_AL Doc Example_1.0.0.0.app'
$aldoc = Resolve-Path "$($env:USERPROFILE)\.vscode*\extensions\ms-dynamics-smb.al-*\bin\win32\aldoc.exe" | Select-Object -ExpandProperty Path

$output = New-Item -ItemType Directory -Path ./output -Force
Remove-Item -Path "$output\*" -Recurse -Filter * -Force

. $aldoc init -o $output -t $app
. $aldoc build -o $output -c ./package -s $app

docfx build "$output/docfx.json"

docfx serve "$output/_site"