."$PSScriptRoot\Lib_General.ps1";
$assemblyName =  "System.Data";
$assemblyFile = 'C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0\System.Data.dll';

function Invoke-Query
{
    param (
       [Parameter(Mandatory=$True)]
       [string]$query,
       [Parameter(Mandatory=$True)]
       [string]$connectionString
    )

    begin
    {
    }
    process
    {
		Test-AssemblyLoaded -assemblyName $assemblyName -assemlbyFile $assemblyFile -report $true;
        $connection = new-object System.Data.SqlClient.SQLConnection("$connectionString");
        $cmd = new-object System.Data.SqlClient.SqlCommand($query, $connection);

        $connection.Open();
        $reader = $cmd.ExecuteReader();

        $results = @();
        while ($reader.Read())
        {
            $row = @{}
            for ($i = 0; $i -lt $reader.FieldCount; $i++)
            {
                $name = $reader.GetName($i);
                $value = $reader.GetValue($i);
                $row[$name] = $value;
            }
            $results += new-object psobject -property $row;            
        }
        $reader.Close();
        $connection.Close();
    }
    end
    {
        return $results
    }
}

function Invoke-NonQuery
{
    param (
       [Parameter(Mandatory=$True)]
       [string]$query,
       [Parameter(Mandatory=$True)]
       [string]$connectionString
    )

    begin
    {
    }
    process
    {
		Test-AssemblyLoaded -assemblyName $assemblyName -assemlbyFile $assemblyFile -report $true;
        $connection = new-object System.Data.SqlClient.SQLConnection("$connectionString");
        $cmd = new-object System.Data.SqlClient.SqlCommand($query, $connection);

        $connection.Open();
        $rowsAffected = $cmd.ExecuteNonQuery();
        $connection.Close();
    }
    end
    {
        return $rowsAffected
    }
}