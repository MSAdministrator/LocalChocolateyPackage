# LocalChocolateyPackage

[![Build status](https://ci.appveyor.com/api/projects/status/7yb9er834qod0xvw?svg=true)](https://ci.appveyor.com/project/MSAdministrator/localchocolateypackage)

## Creates and installs local Chocolatey packages

LocalChocolateyPackage can create and install local Chocolatey packages

## Synopsis

A PowerShell Module to create and install local Chocolatey packages.

## Description

A PowerShell Module to create and install local Chocolatey packages.

## Using LocalChocolateyPackage

To use this module, you will first need to download/clone the repository and import the module:

```powershell
Import-Module .\LocalChocolateyPackage.psm1
```

### Generating Local Chocolatey Packages

Once you have imported the module you can generate new Chocolatey pacakges.  You must specify the the `SourcePath` containing your nuspec folder structure and the `OutputPath` to store the generated nupkg packages.

Before you can generate packages you must have follow the Chocolatey guidelines for folder layout.  Here is an example:

```text
You must have a Chocolatey specified folder structure for nuspec generation:
    C:\Packages\PackageName\
        C:\Packages\PackageName.nuspec
        C:\Packages\tools\chocolateyInstall.ps1
    C:\NewPackages\
```

```powershell
New-LocalChocolateyPackage -SourcePath 'C:\Packages' -OutputPath 'C:\NewPackages'
```

### Installing Local NuGet Packages

To install your own nupkg you can run the `Install-LocalChocolateyPackage` function:

```powershell
Install-LocalChocolateyPackage -PackageName 'SomePackageName' -PackageSource 'C:\some\path_to_folder_containing_packages'
```

## Notes

```yaml
   Name: LocalChocolateyPackage
   Created by: Josh Rickard (MSAdministrator)
   Created Date: 07/13/2018
```