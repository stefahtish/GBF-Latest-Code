report 50199 "Employee Appraisals"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeAppraisals.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Employee Appraisal"; "Employee Appraisal")
        {
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Comp_Logo; CompanyInfo.Picture)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Department_Code; "Employee Appraisal"."Department Code")
            {
            }
            column(Appraisal_No; "Employee Appraisal"."Appraisal No")
            {
            }
            column(Employee_No; "Employee Appraisal"."Employee No")
            {
            }
            column(Appraisal_Type; "Employee Appraisal"."AppraisalType")
            {
            }
            column(Appraisal_Period; "Employee Appraisal"."Appraisal Period")
            {
            }
            column(NoSupervised_Directly; "Employee Appraisal"."No. Supervised (Directly)")
            {
            }
            column(NoSupervised_InDirectly; "Employee Appraisal"."No. Supervised (In-Directly)")
            {
            }
            column(JobID; "Employee Appraisal"."Job ID")
            {
            }
            column(Agreement_With_Rating; "Employee Appraisal"."Agreement With Rating")
            {
            }
            column(General_Comments; "Employee Appraisal"."General Comments")
            {
            }
            column(Date; "Employee Appraisal".Date)
            {
            }
            column(Rating; "Employee Appraisal".Rating)
            {
            }
            column(Rating_Description; "Employee Appraisal"."Rating Description")
            {
            }
            column(Appraiser_No; "Employee Appraisal"."Appraiser No")
            {
            }
            column(Appraisers_Name; "Employee Appraisal"."Appraisers Name")
            {
            }
            column(Appraisee_ID; "Employee Appraisal"."Appraisee ID")
            {
            }
            column(Appraiser_ID; "Employee Appraisal"."Appraiser ID")
            {
            }
            column(Appraisee_Name; "Employee Appraisal"."Appraisee Name")
            {
            }
            column(Job_Group; "Employee Appraisal"."Job Group")
            {
            }
            column(Appraisers_Job_Title; "Employee Appraisal"."Appraiser's Job Title")
            {
            }
            column(Appraisees_Job_Title; "Employee Appraisal"."Appraisee's Job Title")
            {
            }
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
        CompanyInfo: Record "Company Information";
}
