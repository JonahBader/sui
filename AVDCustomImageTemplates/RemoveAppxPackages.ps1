function Remove-ProvidedAppxPackages($AppxPackages) {
	 Begin {
		 $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
         Write-host "Starting AVD AIB Customization: Remove Appx Packages : $((Get-Date).ToUniversalTime()) "
        }

     Process {
		 Foreach ($App in $AppxPackages) {
			 try {
				 Write-Host "AVD AIB CUSTOMIZER PHASE : Removing Provisioned Package $($App)"
                 Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -like ("*{0}*" -f $App) } | Remove-AppxProvisionedPackage -Online
                         
                 Write-Host "AVD AIB CUSTOMIZER PHASE : Attempting to remove [All Users] $App "
                 Get-AppxPackage -AllUsers -Name ("*{0}*" -f $App) | Remove-AppxPackage -AllUsers
                         
                 Write-Host "AVD AIB CUSTOMIZER PHASE : Attempting to remove $App"
                 Get-AppxPackage -Name ("*{0}*" -f $App) | Remove-AppxPackage
             }
             catch {
                 Write-Host "AVD AIB CUSTOMIZER PHASE : Failed to remove Appx Package $App - $($_.Exception.Message)"
             }
         } 
     }
     
     End {    
         $stopwatch.Stop()
         $elapsedTime = $stopwatch.Elapsed
         Write-Host "*** AVD AIB CUSTOMIZER PHASE : Remove Appx Packages -  Exit Code: $LASTEXITCODE ***"    
         Write-Host "Ending AVD AIB Customization : Remove Appx Packages - Time taken: $elapsedTime"
     }
 }

 Remove-ProvidedAppxPackages -AppxPackages "Clipchamp.Clipchamp","Microsoft.BingNews","Microsoft.BingWeather","Microsoft.GamingApp","Microsoft.GetHelp","Microsoft.Getstarted","Microsoft.MicrosoftOfficeHub","Microsoft.Office.OneNote","Microsoft.MicrosoftSolitaireCollection","Microsoft.MicrosoftStickyNotes","Microsoft.Paint","Microsoft.People","Microsoft.PowerAutomateDesktop","Microsoft.ScreenSketch","Microsoft.SkypeApp","Microsoft.Todos","Microsoft.Windows.Photos","Microsoft.WindowsAlarms","Microsoft.WindowsCalculator","Microsoft.WindowsCamera","Microsoft.windowscommunicationsapps","Microsoft.WindowsFeedbackHub","Microsoft.WindowsMaps","Microsoft.WindowsSoundRecorder","Microsoft.Xbox.TCUI","Microsoft.XboxGameOverlay","Microsoft.XboxGamingOverlay","Microsoft.XboxIdentityProvider","Microsoft.XboxSpeechToTextOverlay","Microsoft.YourPhone","Microsoft.ZuneMusic","Microsoft.ZuneVideo","Microsoft.XboxApp","Microsoft.549981C3F5F10","Microsoft.Office.ActionsServer","Microsoft.OfficePushNotificationUtility","Microsoft.OneDriveSync","Microsoft.OutlookForWindows","MicrosoftCorporationII.QuickAssist","MSTeams","Microsoft.WindowsTerminal"
 
