<#
.SYNOPSIS
    Installs local chocolatey packages
.DESCRIPTION
    Takes a generated nupkg and installs it
.EXAMPLE Install local Chocolatey package
    PS :> Install-LocalChocolateyPackage -PackageName 'SomePackageName' -PackageSource 'C:\some\path_to_folder_containing_packages'
.EXAMPLE Install specified version of local Chocolatey package
    PS :> Install-LocalChocolateyPackage -PackageName 'SomePackageName' -PackageVersion '1.4.1' -PackageSource 'C:\some\path_to_folder_containing_packages'
.PARAMETER PackageName
    The name of the package you want to install
.PARAMETER PackageVersion
    The version of the package you want to install
.PARAMETER PackageSource
    The folder location containing your nupkg to install
.PARAMETER Timeout
    The duration to wait before failing.  Default is 2700 seconds
.NOTES
    Name: Install-LocalChocolateyPackage
    Author: Josh Rickard (MSAdministrator)
    DateCreated: 07/13/2018
.FUNCTIONALITY
    Install a Chocolatey package
#>
function Install-LocalChocolateyPackage {
    [CmdletBinding(DefaultParameterSetName = 'Parameter Set 1',
        PositionalBinding = $false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact = 'Medium')]
    Param (
        # The name of the package you want to install
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$PackageName,

        # The version of the package you want to install
        [Parameter(Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$PackageVersion,

        # The folder location containing your nupkg to install
        [Parameter(Mandatory = $true,
            Position = 2,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$PackageSource,

        # The duration to wait before failing.  Default is 2700 seconds
        [Parameter(Mandatory = $false,
            Position = 3,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [int]$Timeout = 2700
    )

    Write-Verbose -Message "Current package: $PackageName"

    if ([String]::IsNullOrEmpty($PackageVersion)) {
        Write-Verbose -Message "choco install -y `"$PackageName`" -source `"$PackageSource`" --execution-timeout `"$Timeout`""
        choco install -y "$PackageName" -source "$PackageSource" --execution-timeout "$Timeout"
    }
    else {
        write-host "choco install -y `"$PackageName`" -source `"$PackageSource`" --version `"$pkgVersion`" --execution-timeout `"$Timeout`""
        choco install -y "$PackageName" -source "$PackageSource" --version "$pkgVersion" --execution-timeout "$Timeout"
    }

    if ($LASTEXITCODE -eq 3010 -or $LASTEXITCODE -eq -2147205120) {
        Write-Information -Message 'Reboot pending...'
        Write-Information -Message 'Please reboot the machine and then rerun this script'

        Write-Information -Message 'ACTION REQUIRED -- reboot pending'

        Exit -1
    }
    elseif ($LASTEXITCODE -ne 0) {
        Write-Warning -Message "FAILED TO INSTALL $PackageName"
        Write-Error -ErrorRecord $Error[0]
        Exit -1
    }
    Write-Verbose -Message 'Successfully built Chocolatey packages'
}