<#
.SYNOPSIS
    Generates local chocolatey packages
.DESCRIPTION
    Generates local chocolatey packages and outputs a nupkg
.EXAMPLE Generates local Chocolatey package
    You must have a Chocolatey specified folder structure for nuspec generation:
    C:\Packages\PackageName\
        C:\Packages\PackageName.nuspec
        C:\Packages\tools\chocolateyInstall.ps1
    C:\NewPackages\

    PS :> New-LocalChocolateyPackage -SourcePath 'C:\Packages' -OutputPath 'C:\NewPackages'
.PARAMETER SourcePath
    The folder that contains the package or packages you want to generate
.PARAMETER OutputPath
    The folder location to place the generated nupkg package(s)
.NOTES
    Name: New-LocalChocolateyPackage
    Author: Josh Rickard (MSAdministrator)
    DateCreated: 07/13/2018
.FUNCTIONALITY
    Install a Chocolatey package
#>
function New-LocalChocolateyPackage {
    [CmdletBinding(DefaultParameterSetName = 'Parameter Set 1',
        PositionalBinding = $false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact = 'Medium')]
    Param (
        # The folder that contains the package or packages you want to generate
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$SourcePath,

        # The folder location to place the generated nupkg package(s)
        [Parameter(Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$OutputPath
    )
    begin {
        Write-Verbose -Message 'Building local Chocolately packages'

        if (-not (Test-Path $OutputPath)) {
            New-Item $OutputPath -Type Directory
            Write-Verbose -Message "Creating $OutputPath"
        }

        $pkgs = Get-ChildItem -Directory $srcPath
    }
    process {
        foreach ($pkg in $pkgs) {
            $pkgPath = "$SourcePath\$pkg"

            Push-Location $pkgPath
            Write-Verbose -Message "Trying to build NuGet package for $pkg"

            choco pack --outputdirectory "$OutputPath" --use-system-powershell\

            if ($LASTEXITCODE -ne 0) {
                Write-Warning -Message "Failed to build Chocolatey package for $pkg"
                Write-Error -ErrorRecord $Error[0] 
                Pop-Location

                Exit -1
            }
            Pop-Location
        }
    }
    end {
        Write-Verbose -Message 'Successfully built Chocolatey packages'
    }
}