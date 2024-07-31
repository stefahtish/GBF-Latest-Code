table 50547 "Bank account confirmation"
{
    fields
    {
        field(1; "Bank Code."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAcc: Record "Bank Account";
            begin
                BankAcc.SetRange(BankAcc."No.", "Bank Code.");
                if BankAcc.FindFirst()then begin
                    BankAcc.CalcFields("Balance at Date");
                    Name:=BankAcc.Name;
                    Balance:=BankAcc."Balance at Date";
                end;
            end;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Bank Account No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Balance; Decimal)
        {
            Caption = 'Petty cash as per reconciliation';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Variance:=Balance - "Actual Balance";
            end;
        }
        field(6; "Balance (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Actual Balance"; Decimal)
        {
            Caption = 'Petty cash as per cash count';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Date checked":=Today;
                Variance:=Balance - "Actual Balance";
            end;
        }
        field(8; Variance; Decimal)
        {
            Caption = 'Difference';
            DataClassification = ToBeClassified;
        }
        field(9; "Date checked"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(12; "Employee Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Findings"; Text[70])
        {
            Caption = 'Conclusion/Finding';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Bank Code.", "Date checked")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "Date checked":=Today;
        "User ID":=UserId;
        if UserSetup.Get(UserId)then begin
            "User ID":=UserSetup."User ID";
            if Employee.Get(UserSetup."Employee No.")then begin
                "Employee No":=Employee."No.";
                "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        end;
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
}
