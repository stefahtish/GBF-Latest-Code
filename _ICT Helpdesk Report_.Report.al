report 50399 "ICT Helpdesk Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ICTHelpdeskReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("User Support Incident"; "User Support Incident")
        {
            DataItemTableView = where(Type = filter(ICT));

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
            column(Incident_Reference; "Incident Reference")
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
            column(User_Remarks; "User Remarks")
            {
            }
            column(Action_Date; "Action Date")
            {
            }
            column(Action_Time; "Action Time")
            {
            }
            column(Sent; "User Support Incident".Sent)
            {
            }
            column(Status; "User Support Incident".Status)
            {
            }
            column(Duration; Duration)
            {
            }
            column(Service_Provider; "Service Provider")
            {
            }
            column(Service_provider_Name; "Service provider Name")
            {
            }
            column(Service_provided; "Service provided")
            {
            }
            column(Incident_Description; "Incident Description")
            {
            }
            column(Feedback_on_Completion; "Feedback on Completion")
            {
            }
            column(Escalate_To_Name; "Escalate To Name")
            {
            }
            column(Asset_Description; "Asset Description")
            {
            }
            column(Serial_Number; "Serial Number")
            {
            }
            column(Tag_Number; "Tag Number")
            {
            }
            column(Details; Details)
            {
            }
            trigger OnAfterGetRecord()
            begin
                GetEmployeeData("User Support Incident"."Employee No");
                if ("Action Date" <> 0D) and ("Incident Date" <> 0D) then Duration := "Action Date" - "Incident Date";
                Clear(Details);
                if "Asset Description" <> '' then Details := "Asset Description";
                if "Serial Number" <> '' then Details := Details + ',Serial Number:' + "Serial Number";
                if "Tag Number" <> '' then Details := Details + ',Tag Number:' + "Tag Number";
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
        Duration: Integer;
        Details: Text[2000];

    local procedure GetEmployeeData(EmployeeNo: Code[50])
    begin
        if Employee.Get(EmployeeNo) then begin
            Employee."Phone No." := Employee."Phone No.";
            DimVal.SetRange(Code, Employee."Global Dimension 2 Code");
            if DimVal.FindFirst then EmployeeDept := DimVal.Name;
        end;
    end;
}
