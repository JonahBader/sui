Configuration GPO
{
    Import-DscResource -ModuleName GPRegistryPolicyDsc

    node localhost
    {
        RegistryPolicyFile 'ShowJobTitleInEventLogs'
        {
            Key        = 'SOFTWARE\Policies\Microsoft\Windows NT\Printers'
            TargetType = 'ComputerConfiguration'
            ValueName  = 'ShowJobTitleInEventLogs'
            ValueData  = 0
            ValueType  = 'DWORD'
        }

        RefreshRegistryPolicy 'RefreshGroupPolicy'
        {
            IsSingleInstance = 'Yes'
            DependsOn        = '[RegistryPolicyFile]ShowJobTitleInEventLogs'
        }
    }
}
GPO
Install-Module -Name GPRegistryPolicyDsc -Force
Start-DSCConfiguration -Wait -Verbose -Path "C:\Windows\system32\GPO" -Force
