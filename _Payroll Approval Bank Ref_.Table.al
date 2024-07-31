table 50550 "Payroll Approval Bank Ref"
{
    Caption = 'Payroll Approval Bank Ref';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; Bank; Code[20])
        {
            Caption = 'Bank';
            DataClassification = ToBeClassified;
            Tablerelation = Banks where("Non-Bank"=const(true));

            trigger OnValidate()
            var
                Banks: record Banks;
            begin
                if Banks.Get(Bank)then begin
                    Banks.testfield("Bank Code");
                    Banks.TestField("Bank Branch Code");
                    "Bank Name":=Banks.Name;
                    "Bank Code":=Banks."Bank Code";
                    "Bank Branch":=Banks."Bank Branch Code";
                end;
            end;
        }
        field(3; Reference; Code[100])
        {
            Caption = 'Reference';
            DataClassification = ToBeClassified;
        }
        field(4; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Pay Directly"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Bank Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Bank Branch"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", Bank)
        {
            Clustered = true;
        }
    }
}
