tableextension 50103 HRSetupTableExt extends "Human Resources Setup"
{
    fields
    {
        field(50001; "Corporation Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Housing Earned Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Pension Limit Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Pension Limit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Round Down"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Working Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Payroll Rounding Precision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Payroll Rounding Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Nearest, Up, Down;
        }
        field(50010; "Years To Retire"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "BFW Round Earning code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Company overtime hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Loan Product Type Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50015; "Tax Relief Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "General Payslip Message"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Incoming Mail Server"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Outgoing Mail Server"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Email Text"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Sender User ID"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Sender Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Email Subject"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Template Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Applicants Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50028; "Leave Application Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50029; "Recruitment Needs Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50030; "Disciplinary Cases Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50031; "No. Of Days in Month"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Transport Request Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50033; "Cover Selection Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50034; "Qualification Days (Leave)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Leave Allowance Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = EarningsX;
        }
        field(50036; "Telephone Request Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50037; "Training Request Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50038; "Leave Recall Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50039; "Medical Claim Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50040; "Account No (Training)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50041; "Training Evaluation Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50042; "Off Days Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Appraisal Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50044; "Leave Plan Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50045; "Keys Request Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50046; "Incidences Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50047; "Sick Of Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50048; "Conveyance Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50049; "Base Calender Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar".Code;
        }
        field(50050; "Membership No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50051; "Owner Occupied Interest Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Probation Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Stategic Plan No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50054; "Mail Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50055; "Mail Movement Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50056; "Human Resource Admin"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50057; "Disciplinary Cases No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50058; "Employee Absentism"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50059; "Conf/Sem/Request"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50060; "Conf/Sem Evaluation"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50061; "Monthly PayDate"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "User Incident"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50063; "DMS LINK"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Vehicle Filling No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50065; "Savings Withdrawal No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50066; "Med Claim DMS LINK"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Resource Request Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50068; "Appraisal Objective Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50069; "Notification Frequency"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50070; "Rate Per Kg"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "Human Resource Emails"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Retirement Age"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Probation Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Company NHIF No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "Company NSSF No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Share Top Up Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50077; "Payroll Journal Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50078; "Payroll Journal Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name"=FIELD("Payroll Journal Template"));
        }
        field(50079; "Leave Adjustment Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50081; "Leave Notification Mail Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50082; "Assignment Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50083; "Dependant Maximum Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Vehicle Maintenance Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50085; "Disabililty Tax Exp. Amt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Payroll Req Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50087; "Reference Letter Text"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(50088; "Acting Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50089; "Transfer Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50090; "Payroll Change Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50091; "Loan App No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50092; "Bill Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50093; "No of Days in a Year"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50094; "Shortlisting Criteria"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50095; "Leave Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50096; "Contract Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50097; "Payslips Path"; Text[250])
        {
            Caption = 'Payslips and P9 Path';
            DataClassification = ToBeClassified;
        }
        field(50098; "Payroll Import Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50099; "Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Employee Change Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50101; "Email Institutions Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Email Institution Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50103; "Payroll Journal No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50104; "Training Needs Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50105; "Loan Interest Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50106; "Loan Interest Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50107; "Trustee Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50108; "Secondary PAYE %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Trustee Reversal Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50110; "Trustee Reversal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50111; "Imprest Deduction Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50112; "Imprest Due Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Base Calendar Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar".Code;
        }
        field(50114; "Transport Request Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50155; "Net pay ratio to Earnings"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Ratio that defines 1/3 rule for net pay';
        }
        field(50156; "Enforce a third rule"; Boolean)
        {
        }
        field(50157; "Training Needs Request Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50158; "Payroll Approval Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50159; "Training Budget Item Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50160; "Driver Log Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50161; "Asset Transfer Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50162; "Asset Allocation Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50163; "Contract No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50164; "Board of Directors Tenure"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50165; "Job Application Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50166; "Imprest Notification Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50167; "Committee Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50168; "Net Pay Rounding Precision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50169; "Net Pay Rounding Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Nearest, Up, Down;
        }
        field(50170; "Other Retirement Age"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50171; "Employee Email Body"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Paid Months Before Increament"; Integer)
        {
            Editable = true;
            Caption = 'Min Paid Months before Increament';
        }
        field(50116; "Increment Annually"; Boolean)
        {
            Editable = true;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Increment Annually" then if "Increment Quarterly" or "Increment Semi-Annually" then Error(Text001, FieldCaption("Increment Annually"), FieldCaption("Increment Semi-Annually"), FieldCaption("Increment Quarterly"));
            end;
        }
        field(50117; "Increment Semi-Annually"; Boolean)
        {
            Editable = true;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Increment Semi-Annually" then if "Increment Annually" or "Increment Quarterly" then Error(Text001, FieldCaption("Increment Semi-Annually"), FieldCaption("Increment Annually"), FieldCaption("Increment Quarterly"));
            end;
        }
        field(50118; "Increment Quarterly"; Boolean)
        {
            Editable = true;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Increment Quarterly" then if "Increment Annually" or "Increment Semi-Annually" then Error(Text001, FieldCaption("Increment Quarterly"), FieldCaption("Increment Annually"), FieldCaption("Increment Semi-Annually"));
            end;
        }
        field(50119; "Post Training Evaluation Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50120; "Leave Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50121; "Contract Notification Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50122; "Target Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50136; "Net pay POP Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "POP Codes";
        }
        field(50137; "Default Bank"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" WHERE("Bank Type"=CONST(Bank));
        }
        field(50139; "EFT Document Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50140; "Interbank EFT Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50141; "Pay Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(50142; "Current Bank Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" WHERE("Bank Type"=CONST(Bank));
        }
        field(50143; "Max Appraisal Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50144; "Payment Description1"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50145; "Payment Description2"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50146; "Payment Description3"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50147; "Payment Description4"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50148; "Debit Narrative"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50149; "Credit Narrative"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; "Purpose Pay"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "Serial No"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50152; "Target Max Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50153; "Interview Committee No.s"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    var Text001: Label '%1 cannot be marked since either %2 or %3 is already marked.';
}
