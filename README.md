# Generating help with the ALDoc tool

![ALDoc](https://raw.githubusercontent.com/NavNab/aldoc/main/img/aldoc.png "ALDoc")

When Microsoft initially introduced ALDoc, I was enthusiastic about testing it as soon as I could access the AL pre-release. However, my attempts to follow the official documentation resulted in disappointment as nothing worked as described.

I embarked on a quest to find more resources about ALDoc, but my efforts were met with limited success. Only Stefano Demiliani wrote an article titled [Introducing ALDoc: a new command line tool for generating reference documentation for AL extensions](https://demiliani.com/2023/08/21/introducing-aldoc-a-new-command-line-tool-for-generating-reference-documentation-for-al-extensions/). Although this article delves deeper than Microsoft's documentation, the outcome remained consistent: none of the instructions produced the desired results 😥

Determined to overcome these challenges, I chose to start anew and thoroughly analyze the issues at hand. In addition, I decided to write this post to provide assistance to those struggling with ALDoc.

To contribute my insights on this matter, I opted to follow the same Table of Contents as the official documentation for [Generating help with the ALDoc tool](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/help/help-aldoc-generate-help). I will briefly outline the necessary adjustments.


## Prerequisites

Ensure the installation of .NET SDK 6.0 or a higher version.
The DocFx link can be disregarded.

## Checking your .NET version

```powershell
dotnet --list-sdks
```

The output should resemble the following:

![](https://raw.githubusercontent.com/NavNab/aldoc/main/img/dotnet%20--list-sdks.png)

## DocFx

This is where you'll need to install DocFx.

Both the Microsoft documentation and Stefano's article suggest using the command:
```powershell
dotnet tool update -g docfx
```
However, attempting this command will yield a result similar to:

![](https://raw.githubusercontent.com/NavNab/aldoc/main/img/dotnet%20tool%20update%20-g%20docfx%20NOK.png)

The "update" aspect of this command might seem peculiar, as you can't update something that is not already installed. Fortunately, Microsoft updated the documentation after the release of a video by [Erik Hougaard](https://www.youtube.com/watch?v=MNOEb5W1KQg)
```powershell
dotnet tool install docfx --version 2.70 -g
```
If you give this a try, you might still encounter the same error:

![](https://raw.githubusercontent.com/NavNab/aldoc/main/img/dotnet%20tool%20install%20docfx%20--version%202.70%20-g%20NOK.png)

In such a case, it's advisable to inspect your nuget source:

```powershell
dotnet nuget list source
```
![](https://raw.githubusercontent.com/NavNab/aldoc/main/img/dotnet%20nuget%20list%20source.png)

If the list is empty, you should add the source using the following command:
```powershell
dotnet nuget add source --name nuget.org https://api.nuget.org/v3/index.json
```
Executing this command should successfully add the source:


![](https://raw.githubusercontent.com/NavNab/aldoc/main/img/dotnet%20nuget%20add%20source%20--name%20nuget.org%20https%20api.nuget.org%20v3%20index.json.png)

With that completed, reattempt the following command:

```powershell
dotnet tool install docfx --version 2.70 -g
```
The outcome should now be successful:

![](https://raw.githubusercontent.com/NavNab/aldoc/main/img/dotnet%20nuget%20add%20source%20--name%20nuget.org%20https%20api.nuget.org%20v3%20index.json.png)

## ALDoc

Now, you can proceed to follow the other steps outlined in the Microsoft documentation to experiment with ALDoc. Alternatively, you can continue reading or, even better, clone [this repo](https://github.com/NavNab/aldoc) and explore it yourself.

In my repository, I've included:

1. A script to facilitate DocFx installation. Feel free to comment out unnecessary lines
```powershell
dotnet --list-sdks
dotnet nuget list source
dotnet nuget add source --name nuget.org https://api.nuget.org/v3/index.json
dotnet tool install docfx --version 2.70 -g
```
2. An app for testing ALDoc
3. A script for executing ALDoc
```powershell
$app = '.\NavNab_AL Doc Example_1.0.0.0.app'
$aldoc = Resolve-Path "$($env:USERPROFILE)\.vscode*\extensions\ms-dynamics-smb.al-*\bin\win32\aldoc.exe" | Select-Object -ExpandProperty Path

$output = New-Item -ItemType Directory -Path ./output -Force
Remove-Item -Path "$output\*" -Recurse -Filter * -Force

. $aldoc init -o $output -t $app
. $aldoc build -o $output -c ./package -s $app

docfx build "$output/docfx.json"
docfx serve "$output/_site"
```

Based on my experimentation, I find ALDoc to be impressive. However, it still requires some improvements from Microsoft 🙈.
For instance, if you're accustomed to having a "src" folder, you might need to reconsider that approach, as ALDoc struggles to manage subfolders.

Here are some functionalities I hope Microsoft incorporates into an upcoming version:

1. Subfolder supporting
2. Tooltips handling

Currently, I commend [NAB AL Tools](https://marketplace.visualstudio.com/items?itemName=nabsolutions.nab-al-tools#nab-generate-external-documentation) for providing similar tools a while ago. Nevertheless, I'm considering switching to ALDoc soon — my apologies to the NAB AL Tools team 🙈.

If you're still reading, I'd love to hear your feedback and to hear about the functionalities you wish to see in future versions. Feel free to share your thoughts in the comments below 😉.