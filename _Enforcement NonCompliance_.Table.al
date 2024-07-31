table 50576 "Enforcement NonCompliance"
{
    Caption = 'Enforcement Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = General, Confiscation;
        }
        field(5; "Milk Volume"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Action To be Taken"; Option)
        {
            DataClassification = ToBeClassified;
            optionmembers = " ", "Given timeline to achieve compliance", "Proceed to Prosecution";
        }
        field(7; "Compliance Dateline"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Complied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Overdue; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Judgement Process"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Fine, Punishment;
            OptionCaption = ' ,Fine,Punishment';
        }
        field(12; "Compliance Officer No"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Enforcement Header"."Confiscation Officer No" where("No."=field("No.")));
        }
        field(13; "Compliance Officer Name"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Enforcement Header"."Confiscation Officer Name" where("No."=field("No.")));
        }
        field(14; "Status"; Option)
        {
            Caption = 'Action Status';
            OptionMembers = " ", "[IMMEDIATELY]", "[WITHIN (14) DAYS]";
        }
    }
    keys
    {
        key(PK; "No.", Name)
        {
            Clustered = true;
        }
    }
}
