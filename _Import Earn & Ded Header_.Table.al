table 50391 "Import Earn & Ded Header"
{
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Payment,Deduction,Saving Scheme,Loan';
            OptionMembers = Payment, Deduction, "Saving Scheme", Loan;
        }
        field(3; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=FILTER(Payment))EarningsX
            ELSE IF(Type=FILTER(Deduction))DeductionsX
            ELSE IF(Type=FILTER(Loan))"Loan Product Type";

            trigger OnValidate()
            begin
                if Earnings.Get(Code)then Description:=Earnings.Description;
                if Deductions.Get(Code)then Description:=Deductions.Description;
                if LoanProd.Get(Code)then Description:=LoanProd.Description;
            end;
        }
        field(4; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Pay Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX";

            trigger OnValidate()
            begin
                PayPeriod.Reset;
                PayPeriod.SetRange(Closed, false);
                if PayPeriod.FindFirst then begin
                    if "Pay Period" <> PayPeriod."Starting Date" then begin
                        if "Pay Period" > PayPeriod."Starting Date" then Error('Kindly close the previous periods before Posting')end;
                end;
                if PayPeriod.Get("Pay Period")then begin
                    if PayPeriod.Closed = true then Error('The specified period %1 is closed', "Pay Period");
                end;
                PayPeriodText:=Format("Pay Period", 0, '<Month Text> <Year4>');
                "Pay Period Text":=PayPeriodText;
            end;
        }
        field(6; "Pay Period Text"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released';
            OptionMembers = Open, "Pending Approval", Released;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Total; Decimal)
        {
            CalcFormula = Sum("Import Earn & Ded Lines".Amount WHERE(No=FIELD(No)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        HRSetup.Get;
        NoSeriesMgt.InitSeries(HRSetup."Payroll Import Nos", xRec.No, 0D, No, "No. Series");
        Date:=Today;
        "User ID":=UserId;
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Earnings: Record EarningsX;
    Deductions: Record DeductionsX;
    LoanProd: Record "Loan Product Type";
    PayPeriodText: Text;
    PayPeriod: Record "Payroll PeriodX";
}
