report 50185 "Letter of Offer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LetterofOffer.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Applicants; Applicants2)
        {
            column(First_Name; Applicants."First Name")
            {
            }
            column(Middle_Name; Applicants."Middle Name")
            {
            }
            column(Last_Name; Applicants."Last Name")
            {
            }
            column(Postal_Address; Applicants."Postal Address")
            {
            }
            column(Residential_Address; Applicants."Residential Address")
            {
            }
            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Comp_Address; CompanyInfo.Address)
            {
            }
            column(Comp_Tel; CompanyInfo."Phone No.")
            {
            }
            column(Comp_City; CompanyInfo.City)
            {
            }
            column(Comp_Logo; CompanyInfo.Picture)
            {
            }
            column(Comp_Email; CompanyInfo."E-Mail")
            {
            }
            column(Comp_Website; CompanyInfo."Home Page")
            {
            }
            column(Comp_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Salutation; Salutation)
            {
            }
            column(Job_Grade; JobGroup)
            {
            }
            column(Reporting_To; ReportingTo)
            {
            }
            column(Reporting_Date; Applicants."Expected Reporting Date")
            {
            }
            column(Sign_Name; Signatories."Signing Name")
            {
            }
            column(Sign_Title; Signatories."Title/Position")
            {
            }
            column(Sign_Signature; Signatories.Signature)
            {
            }
            dataitem("Applicant job applied"; "Applicant job applied")
            {
                DataItemLink = "Application No." = field("No.");

                column(Job_Description; Job)
                {
                }
                column(Basic_Salary; BasicPay)
                {
                }
                column(House_Allowance; HouseAllowance)
                {
                }
                column(Salary_Pointer; MinPointer)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Jobs.Reset;
                    Jobs.SetRange("Job ID", "Applicant job applied"."Job ID");
                    if Jobs.Find('-') then JobGroup := Jobs.Grade;
                    ReportingTo := GetJobReporting(Jobs."Position Reporting to");
                    Scale.Reset;
                    if Scale.Get(JobGroup) then MinPointer := Scale."Minimum Pointer";
                    Pointer.Reset;
                    if Pointer.Get(JobGroup, MinPointer) then begin
                        //Get Basic Salary
                        Earning.Reset;
                        Earning.SetRange("Basic Salary Code", true);
                        if Earning.Find('-') then begin
                            Benefits.Reset;
                            Benefits.SetRange("ED Code", Earning.Code);
                            Benefits.SetRange("Salary Scale", JobGroup);
                            Benefits.SetRange("Salary Pointer", MinPointer);
                            if Benefits.FindFirst then BasicPay := Benefits.Amount;
                        end;
                        //Get House Allowance
                        Earning.Reset;
                        Earning.SetRange("House Allowance Code", true);
                        if Earning.Find('-') then begin
                            Benefits.Reset;
                            Benefits.SetRange("ED Code", Earning.Code);
                            Benefits.SetRange("Salary Scale", JobGroup);
                            Benefits.SetRange("Salary Pointer", MinPointer);
                            if Benefits.FindFirst then HouseAllowance := Benefits.Amount;
                        end;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(Salutation);
                Applicants.Reset;
                Applicants.SetRange("No.", "No.");
                if Applicants.FindFirst then begin
                    if Applicants.Gender = Applicants.Gender::Male then
                        Salutation := 'Mr'
                    else if (Applicants.Gender = Applicants.Gender::Female) AND (Applicants."Marital Status" = Applicants."Marital Status"::Single) then
                        Salutation := 'Miss'
                    else
                        Salutation := 'Mrs';
                end;
                Signatories.Reset;
                Signatories.SetRange("Document Type", Signatories."Document Type"::"Offer Letter");
                if Signatories.FindFirst then Signatories.CalcFields(Signature);
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        RecNeeds: Record "Recruitment Needs";
        Job_Description: Text[250];
        CompanyInfo: Record "Company Information";
        Signatories: Record Signatories;
        Salutation: Text;
        Scale: Record "Salary Scale";
        Pointer: Record "Salary Pointer";
        Jobs: Record "Company Job";
        JobGroup: Code[10];
        MinPointer: Code[10];
        Earning: Record EarningsX;
        BasicPay: Decimal;
        HouseAllowance: Decimal;
        Benefits: Record "Scale Benefits";
        ReportingTo: Text;

    local procedure GetJobReporting(JobId: Code[10]): Text[250]
    var
        Jobs: Record "Company Job";
    begin
        if Jobs.Get(JobId) then exit(Jobs."Job Description");
    end;
}
