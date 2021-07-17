# Make sure the SWID passed to us has a valid version in the range requested by the user
function Test-PackageVersion {
	[CmdletBinding()]
	[OutputType([bool])]
	param (
		[Parameter(Mandatory=$true)]
		[Microsoft.PackageManagement.MetaProvider.PowerShell.SoftwareIdentity]
		$Package,

		[Parameter()]
		[string]
		$RequiredVersion,

		[Parameter()]
		[string]
		$MinimumVersion,

		[Parameter()]
		[string]
		$MaximumVersion
	)

	# User didn't have any version requirements
	if (-not ($RequiredVersion -or $MinimumVersion -or $MaximumVersion)) {
		return $true
	}

	[System.Version]$version = $Package.Version.TrimStart('v')

	# User specified a specific version - it either matches or it doesn't
	if ($RequiredVersion) {
		return $Version -eq [System.Version]$RequiredVersion
	}

	# Conditional filtering of the version based on optional minimum and maximum version requirements
	$version | Where-Object {
		if ($MinimumVersion) {
			$_ -ge [System.Version]$MinimumVersion
		}
	} | Where-Object {
		if ($MaximumVersion) {
			$_ -le [System.Version]$MaximumVersion
		}
	}
}
