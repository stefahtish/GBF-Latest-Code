codeunit 50111 "Report Selection"
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', true, true)]
    local procedure SubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = 5 then NewReportId := Report::"Receivables-Payables-custom";
        if ReportId = 1320 then
            NewReportId := Report::"Notification Email Extension";
        if ReportId = 106 then NewReportId := Report::"Customer Detailed Aging-cust";
        if ReportId = 103 then NewReportId := Report::"Customer Register-Cust";
        if ReportId = 121 then NewReportId := Report::"Customer-Balance to Date-Cust";
        if ReportId = 101 then NewReportId := Report::"Customer - List-cust";
        if ReportId = 111 then NewReportId := Report::"Customer - Top 10 List-cust";
        if ReportId = 113 then NewReportId := Report::"Customer/Item Sales-cust";
        if ReportId = 114 then NewReportId := Report::"Salesperson - Sales Statist-2";
        if ReportId = 115 then NewReportId := Report::"Salesperson - Commission-cust";
        if ReportId = 119 then NewReportId := Report::"Customer - Sales List-Cust";
        if ReportId = 129 then NewReportId := Report::"Customer - Trial Balance-Cust";
        //Payables reports
        if ReportId = 312 then NewReportId := Report::"Purchase Statistics-Cust";
        if ReportId = 303 then NewReportId := Report::"Vendor Register-Cust";
        if ReportId = 321 then NewReportId := Report::"Vendor - Balance to Date-Cust";
        if ReportId = 329 then NewReportId := Report::"Vendor - Trial Balance-Cust";
        if ReportId = 301 then NewReportId := Report::"Vendor - List-Cust";
        if ReportId = 307 then NewReportId := Report::"Vendor - Order Summary-Cust";
        if ReportId = 309 then NewReportId := Report::"Vendor - Purchase List-Cust";
        if ReportId = 305 then NewReportId := Report::"Vendor - Summary Aging-Cust";
        if ReportId = 311 then NewReportId := Report::"Vendor - Top 10 List-Cust";
        if ReportId = 304 then NewReportId := Report::"Vendor -Detail Trial Balance-2";
        if ReportId = 313 then NewReportId := Report::"Vendor/Item Purchases-cust";
        if ReportId = 105 then NewReportId := Report::"Customer Summary Aging2";
        if ReportId = 305 then NewReportId := Report::"Vendor - Summary Aging2";
        //Account Schedule
        If ReportId = 25 then NewReportId := Report::"Account ScheduleExt";
        if ReportId = 6 then NewReportId := Report::"Trial Balance2";
        if ReportId = 106 then NewReportId := Report::"Customer  Summary Aging Simp.2";
        if ReportId = 104 then NewReportId := Report::"Customer - Detail Trial Bal2";
    end;
}
