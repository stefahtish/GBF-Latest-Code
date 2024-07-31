report 50357 "Incident Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './IncidentReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("User Support Incident"; "User Support Incident")
        {
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyAddr; CompanyInfo.Address)
            {
            }
            column(CompanyCIty; CompanyInfo.City)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(EmployeeName; "User Support Incident"."Employee Name")
            {
            }
            column(IncidenceLocation; "User Support Incident"."Incidence Location")
            {
            }
            column(IncidenceLocationName; "User Support Incident"."Incidence Location Name")
            {
            }
            column(IncidentDate; "User Support Incident"."Incident Date")
            {
            }
            column(IncidentTime; "User Support Incident"."Incident Time")
            {
            }
            column(IncidentDescription; "User Support Incident"."Incident Description")
            {
            }
            column(IncidentCause; "User Support Incident"."Incident Cause")
            {
            }
            column(UserRemarks; "User Support Incident"."User Remarks")
            {
            }
            column(EmployeeDept; EmployeeDept)
            {
            }
            column(EmployeePhoneNo; EmployeePhoneNo)
            {
            }
            column(Action_Taken; "User Support Incident"."Action taken")
            {
            }
            column(Priority; "User Support Incident".Priority)
            {
            }
            column(Recommendation; "User Support Incident"."User Remarks")
            {
            }
            column(Linked_Risk; "User Support Incident"."Linked Risk")
            {
            }
            column(Sent; "User Support Incident".Sent)
            {
            }
            column(Status; "User Support Incident".Status)
            {
            }
            trigger OnAfterGetRecord()
            begin
                GetEmployeeData("User Support Incident"."Employee No");
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
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        EmployeeDept: Code[100];
        EmployeePhoneNo: Code[20];
        DimVal: Record "Dimension Value";

    local procedure GetEmployeeData(EmployeeNo: Code[50])
    begin
        if Employee.Get(EmployeeNo) then begin
            Employee."Phone No." := Employee."Phone No.";
            DimVal.SetRange(Code, Employee."Global Dimension 2 Code");
            if DimVal.FindFirst then EmployeeDept := DimVal.Name;
        end;
    end;
}
