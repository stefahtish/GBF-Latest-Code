report 50241 "Institution Based Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './InstitutionBasedReports.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Institutions; Institutions)
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;

            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            /*             column(CurrReport_PAGENO; CurrReport.PageNo)
                        {
                        }
             */
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(SALARY_DEDUCTIONS_PER_INSTITUTIONCaption; SALARY_DEDUCTIONS_PER_INSTITUTIONCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Assignment_Matrix_X__Employee_No_Caption; "Assignment Matrix-X".FieldCaption("Employee No"))
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Employer_AmountCaption; Employer_AmountCaptionLbl)
            {
            }
            column(InterestCaption; InterestCaptionLbl)
            {
            }
            column(DATE_____________________________________________________________________Caption; DATE_____________________________________________________________________CaptionLbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
            {
            }
            column(Approving_OfficerCaption; Approving_OfficerCaptionLbl)
            {
            }
            column(NAME_________________________________________________________________________Caption; NAME_________________________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption; DESIGNATION____________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption_Control1000000031; DESIGNATION____________________________________________________________Caption_Control1000000031Lbl)
            {
            }
            column(DATE_____________________________________________________________________Caption_Control1000000032; DATE_____________________________________________________________________Caption_Control1000000032Lbl)
            {
            }
            column(NAME_________________________________________________________________________Caption_Control1000000033; NAME_________________________________________________________________________Caption_Control1000000033Lbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption_Control1000000034; SIGNATURE___________________________________________________________Caption_Control1000000034Lbl)
            {
            }
            column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
            {
            }
            column(Institution_Code; Code)
            {
            }
            dataitem(DeductionsX; DeductionsX)
            {
                DataItemLink = "Institution Code" = FIELD(Code);
                DataItemTableView = SORTING("Institution Code");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Institution Code", "Pay Period Filter";

                column(DeductionsX_Code; Code)
                {
                }
                column(DeductionsX_Description; Description)
                {
                }
                column(Institution_Name; Institutions.Name)
                {
                }
                column(InstitutionTotal; InstitutionTotal)
                {
                }
                column(Institution_Address; Institutions.Address)
                {
                }
                column(Institution_City; Institutions.City)
                {
                }
                column(Institution_Code_Control1000000008; Institutions.Code)
                {
                }
                column(DeductionsX_Institution_Code; "Institution Code")
                {
                }
                column(DeductionsX_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
                {
                    DataItemLink = Code = FIELD(Code), "Payroll Period" = FIELD("Pay Period Filter");
                    DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No") WHERE(Type = CONST(Deduction));

                    column(Assignment_Matrix_X__Employee_No_; "Employee No")
                    {
                    }
                    column(ABS_Amount_; Abs(Amount))
                    {
                    }
                    column(EmployeeName; EmployeeName)
                    {
                    }
                    column(ABS__Employer_Amount__; Abs("Employer Amount"))
                    {
                    }
                    column(ABS__Loan_Interest__; Abs("Loan Interest"))
                    {
                    }
                    column(ABS_Amount__Control1000000021; Abs(Amount))
                    {
                    }
                    column(ABS__Employer_Amount___Control1000000038; Abs("Employer Amount"))
                    {
                    }
                    column(Assignment_Matrix_X__Payroll_Group_; "Payroll Group")
                    {
                    }
                    column(ABS__Loan_Interest___Control1000000042; Abs("Loan Interest"))
                    {
                    }
                    column(Assignment_Matrix_X_Type; Type)
                    {
                    }
                    column(Assignment_Matrix_X_Code; Code)
                    {
                    }
                    column(Assignment_Matrix_X_Payroll_Period; "Payroll Period")
                    {
                    }
                    column(Assignment_Matrix_X_Reference_No; "Reference No")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if EmpRec.Get("Assignment Matrix-X"."Employee No") then begin
                            EmployeeName := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                            if EmpRec."Employee Job Type" <> EmpRec."Employee Job Type"::"  " then CurrReport.Skip;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    DeductionsX.CalcFields("Total Amount", "Total Amount Employer");
                    InstitutionTotal := InstitutionTotal + Abs(DeductionsX."Total Amount");
                    GrandTotal := GrandTotal + InstitutionTotal;
                    if (DeductionsX."Total Amount" = 0) and (DeductionsX."Total Amount Employer" = 0) then CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Institution Code");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                InstitutionTotal := 0;
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
        DateSpecified := DeductionsX.GetRangeMin(DeductionsX."Pay Period Filter");
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        InstitutionTotal: Decimal;
        DateSpecified: Date;
        GrandTotal: Decimal;
        EmployeeName: Text[50];
        EmpRec: Record Employee;
        InstitutionCode: array[100] of Code[30];
        InstitutionRec: Record Institutions;
        i: Integer;
        SALARY_DEDUCTIONS_PER_INSTITUTIONCaptionLbl: Label 'SALARY DEDUCTIONS PER INSTITUTION';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        AmountCaptionLbl: Label 'Amount';
        NameCaptionLbl: Label 'Name';
        Employer_AmountCaptionLbl: Label 'Employer Amount';
        InterestCaptionLbl: Label 'Interest';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        Approving_OfficerCaptionLbl: Label 'Approving Officer';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        DESIGNATION____________________________________________________________Caption_Control1000000031Lbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________Caption_Control1000000032Lbl: Label 'DATE ....................................................................';
        NAME_________________________________________________________________________Caption_Control1000000033Lbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________Caption_Control1000000034Lbl: Label 'SIGNATURE ..........................................................';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by Company Authorised Officer ';
}
