report 50477 "Shortlisted Applicants"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ShortlistedApplicants.rdl';

    dataset
    {
        dataitem("Recruitment Needs"; "Recruitment Needs")
        {
            column(No_; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Compnay_logo; CompInfor.Picture)
            {
            }
            column(Company_Name; CompInfor.Name)
            {
            }
            dataitem("Applicant job applied"; "Applicant job applied")
            {
                DataItemLink = "Need Code"=field("No.");

                column(Application_No_; "Application No.")
                {
                }
                column(Application_Date; "Application Date")
                {
                }
                column(First_Name; "First Name")
                {
                }
                column(Middle_Name; "Middle Name")
                {
                }
                column(Last_Name; "Last Name")
                {
                }
                column(gvGender; gvGender)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not "Applicant job applied".Qualified then CurrReport.Skip();
                    Clear(gvGender);
                    ApplicationsRc.Reset();
                    ApplicationsRc.SetRange("No.", "Applicant job applied"."Application No.");
                    if ApplicationsRc.FindFirst()then gvGender:=Format(ApplicationsRc.Gender);
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInfor.get();
        CompInfor.CalcFields(Picture);
    end;
    var gvGender: Text[20];
    ApplicationsRc: Record Applicants2;
    CompInfor: Record "Company Information";
}
