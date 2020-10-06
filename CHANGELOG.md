# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2020-10-05
#### Added
* Searching/installing/managing multiple Chocolatey sources (#5)
* DSC Compatibility, including additional package arguments
* 'Upgrade' packages using the 'latest' required version keyword (#14)
  * Thanks to @matthewprenger for help with this
* Package and Choco.exe installation can run without confirmation prompts by passing the `-AcceptLicense` flag (#17)
  * Thanks to @Gregoorio for the idea
* Support for CoreCLR-based PowerShell (7.0.1 or higher) (#18)
  * Thanks to @sgryphon for bringing this up
* Availability via PSGallery on CoreCLR-based PowerShell (#18)

#### Changed
* To facilitate readability, broke up main module file into several function files
  * Grouped by 'public' functions used by PackageManagement vs 'private' functions that contain much of the shared logic for interacting with Chocolatey
  * Common logic, such as building commands, sending them to Chocolatey, and parsing results, are consolidated across multiple PackageManagement cmdlets into a single set of helper functions
* Choco.exe installed automatically without any user prompts if -Force flag is passed
* Uninstall behavior to also remove all unnecessary dependencies
* Invokes Chocolatey via native API by default under PowerShell 5.1 and below for significant performance gains
  * Thanks to @jirkapok for the inspiration

#### Fixed
* Get-Package no longer lists 'chocolatey' twice (#12)
* Improved performance when downloading large packages with embedded installers
* Choco.exe once again installs automatically after TLS 1.2 changes to chocolatey.org (#16)
  * Thanks to @kendr1ck for help with this
* Suppress Choco prompts during uninstall and upgrade actions

#### Removed
* With Chocolatey-managed upgrades via the provider now available, the package provider no longer unilaterally upgrades Chocolatey on invocation if already installed
* No longer displays progress bars in order to simplify passing data between functions via the pipeline in a way that's idiomatic to PowerShell

## [1.0.0] - 2016-09-15
Initial release