report 50212 "Employee Below A third"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeBelowPay.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            RequestFilterFields = "Payroll Period";

            column(CoName; CompanyInfo.Name)
            {
            }
            column(CoRec_Picture; CompanyInfo.Picture)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(CompPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(PreparedBy; HRMgmt.GetUserName(Approver[1]))
            {
            }
            column(PreparedBySignature; Usersetup.Signature)
            {
            }
            column(PreparedBydate; ApproverDate[1])
            {
            }
            column(ApprovedBy; HRMgmt.GetUserName(Approver[2]))
            {
            }
            column(ApprovedBySignature; Usersetup1.Signature)
            {
            }
            column(ApprovedBydate; ApproverDate[2])
            {
            }
            column(Approved2By; HRMgmt.GetUserName(Approver[3]))
            {
            }
            column(Approved2BySignature; Usersetup2.Signature)
            {
            }
            column(Approved2Bydate; ApproverDate[3])
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_No; "Assignment Matrix-X"."Employee No")
            {
            }
            column(Type; "Assignment Matrix-X".Type)
            {
            }
            column(Payroll_Period; UpperCase(Format("Assignment Matrix-X"."Payroll Period", 0, '<Month Text> <year4>')))
            {
            }
            column(Amount; "Assignment Matrix-X".Amount)
            {
            }
            column(Employee_Name; GetName("Assignment Matrix-X"."Employee No"))
            {
            }
            column(Gross_Pay; GrossPay)
            {
            }
            column(GPay; GPay)
            {
            }
            column(Basic_Pay; BasicPay)
            {
            }
            column(Total_Deductions; Deductions)
            {
            }
            trigger OnAfterGetRecord()
            begin
                AssignMatrix.Reset;
                AssignMatrix.SetRange(AssignMatrix."Payroll Period", "Payroll Period");
                AssignMatrix.SetRange("Employee No", "Employee No");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                AssignMatrix.SetRange("Non-Cash Benefit", false);
                if AssignMatrix.Find('-') then begin
                    AssignMatrix.CalcSums(Amount);
                    GrossPay := AssignMatrix.Amount;
                end;
                AssignMatrix.Reset;
                AssignMatrix.SetRange(AssignMatrix."Payroll Period", "Payroll Period");
                AssignMatrix.SetRange("Employee No", "Employee No");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                AssignMatrix.SetRange(Taxable, true);
                if AssignMatrix.Find('-') then begin
                    AssignMatrix.CalcSums(Amount);
                    GPay := AssignMatrix.Amount;
                end;
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", "Payroll Period");
                AssignMatrix.SetRange("Employee No", "Employee No");
                AssignMatrix.SetRange("Basic Salary Code", true);
                if AssignMatrix.Find('-') then begin
                    BasicPay := AssignMatrix.Amount;
                end;
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", "Payroll Period");
                AssignMatrix.SetRange("Employee No", "Employee No");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                if AssignMatrix.Find('-') then begin
                    AssignMatrix.CalcSums(Amount);
                    Deductions := AssignMatrix.Amount;
                end;
                ApprovalEntries.Reset;
                ApprovalEntries.SetRange("Table ID", Database::"Payroll Approval");
                ApprovalEntries.SetRange("Document No.", HRMgmt.GetPayrollApprovalCode("Payroll Period"));
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[1] := ApprovalEntries."Sender ID";
                            ApproverDate[1] := ApprovalEntries."Date-Time Sent for Approval";
                            if UserSetup.Get(Approver[1]) then UserSetup.CalcFields(Signature);
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then UserSetup2.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup3.Get(Approver[4]) then UserSetup3.CalcFields(Signature);
                        end;
                    until ApprovalEntries.Next = 0;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
            }
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
        Period := "Assignment Matrix-X".GetFilter("Payroll Period");
        if Period = '' then Error(PayPeriodErr);
    end;

    var
        HRMgmt: codeunit "HR Management";
        ApprovalEntries: Record "Approval Entry";
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        AssignMatrix: Record "Assignment Matrix-X";
        GrossPay: Decimal;
        GPay: Decimal;
        BasicPay: Decimal;
        Deductions: Decimal;
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        PayPeriodErr: Label 'Pay Period cannot be blank. Kindly Specify the Period.';
        Period: Text;

    procedure GetName(No: Code[20]): Text[250]
    begin
        if Employee.Get(No) then exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
    end;
}
