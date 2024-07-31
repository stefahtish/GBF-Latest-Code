report 50513 "In-Complete Applicant Report"
{
    Caption = 'In-Complete Applicants Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/InCompleteApplicantReportSummary.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Applicants; Applicants2)
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(No_Applicants; "No.")
            {
            }
            column(Name; "First Name" + ' ' + "Last Name" + ' ' + "Middle Name")
            {
            }
            column(Age_Applicants; Age)
            {
            }
            column(Gender_Applicants; Gender)
            {
            }
            column(IDNumber_Applicants; "ID Number")
            {
            }
            trigger OnAfterGetRecord()
            begin
                JobsApplied.Reset();
                JobsApplied.SetRange("Application No.", Applicants."No.");
                IF (StartDate <> 0D) and (EndDate <> 0D) then JobsApplied.SetRange("Application Date", StartDate, EndDate);
                if JobsApplied.FindSet() then CurrReport.Skip();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Application Dates';

                    field("StartDate"; "StartDate")
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field("EndDate"; "EndDate")
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        JobsApplied: Record "Applicant job applied";
        StartDate: date;
        EndDate: date;
}
