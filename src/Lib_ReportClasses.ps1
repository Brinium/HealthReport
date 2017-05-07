if (-not ("ReportScript" -as [type])) {
Add-Type -Language CSharp @"
namespace HealthCheck
{
    public enum Status 
    {
        Error,
        Warning,
        Success
    };

    public class ReportScript
    {
        public string Id { get; set; }  
        public string DisplayName { get; set; }    
        public System.IO.FileInfo Location { get; set; }
        public bool CanRunConcurrent { get; set; }

        public ReportScript(string id, string name, System.IO.FileInfo path, bool canRunConcurrent)
        {
            this.Id = id;
            this.DisplayName = name;
            this.Location = path;
            this.CanRunConcurrent = canRunConcurrent;
        }
    }

    public class ReportSubItem
    {
        public string DisplayName { get; set; }    
        public string LogLocation { get; set; }
        public System.DateTime DateRan { get; set; }
        public string Description { get; set; }
        public Status Health { get; set; }
    }

    public class ReportItem
    {
        public string DisplayName { get; set; }    
        public string LogLocation { get; set; }
        public System.DateTime DateRan { get; set; }
        public string Description { get; set; }
        public Status Health { get; set; }
        public System.Collections.Generic.List<ReportSubItem> SubItems { get; set; }

        public ReportItem()
        {
            this.SubItems = new System.Collections.Generic.List<ReportSubItem>();
        }
    }
}
"@;
}