table 50353 "Fuel Allocation Ledger Entries"
{
    Caption = 'Fuel Allocation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Vehicle"; Code[50])
        {
            Caption = 'Vehicle ';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset" where("Fixed Asset Type"=FILTER(Fleet));
        }
        field(2; "Type"; Option)
        {
            Caption = 'Minimum Amount';
            OptionMembers = Allocation, Usage, Transfer;
        }
        field(3; "Done by"; Code[20])
        {
            Caption = 'Allocated by';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Period; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Card No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Registration Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Card No")
        {
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        FuelLedger.Reset();
        if FuelLedger.FindLast()then "Entry No.":=FuelLedger."Entry No." + 1
        else
            "Entry No.":=1;
    end;
    var UserSetup: Record "User Setup";
    Employee: Record Employee;
    FuelLedger: Record "Fuel Allocation Ledger Entries";
}
