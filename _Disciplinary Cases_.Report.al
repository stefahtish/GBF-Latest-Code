report 50194 "Disciplinary Cases"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DisciplinaryCases.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Employee Discplinary"; "Employee Discplinary")
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
            column(Date_Closed; "Date Closed")
            {
            }
            dataitem("Employee Disciplinary Cases"; "Employee Disciplinary Cases")
            {
                DataItemLink = "Refference No" = field("Disciplinary Nos");

                //DataItemLink = "Disciplinary Nos" = field("Refference No");                
                column(Case_No; "Employee Disciplinary Cases"."Refference No")
                {
                }
                column(EmployeeNo; "Employee Disciplinary Cases"."Employee No")
                {
                }
                column(Date; "Employee Disciplinary Cases".Date)
                {
                }
                column(Disciplinary_Case; "Employee Disciplinary Cases"."Disciplinary Case")
                {
                }
                column(Recommended_Action; "Employee Disciplinary Cases"."Recommended Action")
                {
                }
                column(Case_Description; "Employee Disciplinary Cases"."Case Description")
                {
                }
                column(Accused_Defence; "Employee Disciplinary Cases"."Accused Defence")
                {
                }
                column(Witness; "Employee Disciplinary Cases"."Witness #1")
                {
                }
                column(Witness_Name; "Employee Disciplinary Cases"."Witness Name")
                {
                }
                column(EmployeeName; EmployeeName)
                {
                }
                column(Gender; Employee.Gender)
                {
                }
                column(Action_Taken; "Action Taken")
                {
                }
                column(Date_Taken; "Date Taken")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Employee Disciplinary Cases"."Employee No");
                if Employee.Find('-') then begin
                    EmployeeName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Gender := Employee.Gender;
                end;
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
        EmployeeName: Text;
        Employee: Record Employee;
        Gender: enum "Employee Gender";
        CompanyInfo: Record "Company Information";
        Disc: Record "Employee Discplinary";
}
