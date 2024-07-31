table 50327 "Employee Bank Accounts"
{
    Caption = 'Employee Bank Accounts';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
        }
        field(2; Bank; Code[30])
        {
            Caption = 'Bank';
            DataClassification = ToBeClassified;
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                if Banks.Get(Bank)then "Bank Name":=Banks.Name;
            end;
        }
        field(3; Branch; Code[30])
        {
            Caption = 'Branch';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code"=FIELD(Bank));

            trigger OnValidate()
            begin
                if Branches.Get(Bank, Branch)then "Branch Name":=Branches."Branch Name";
                "Employee Bank Sort Code":="Bank" + "Branch";
            end;
        }
        field(4; "Percentage to transfer"; Decimal)
        {
            Caption = 'Percentage to transfer';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EmpBanks: Record "Employee Bank Accounts";
            begin
            // EmpBanks.Reset();
            // EmpBanks.SetRange("Employee No.", "Employee No.");
            // EmpBanks.CalcSums("Percentage to transfer");
            // if EmpBanks."Percentage to transfer" > 100 then
            //     Error('Percentage to transfer cannot exceed 100');
            end;
        }
        field(5; "Bank Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Branch Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Account number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Employee Bank Sort Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Default; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Employee No.", Bank, Branch)
        {
            Clustered = true;
        }
    }
    var Banks: Record Banks;
    Branches: Record "Bank Branches";
}
