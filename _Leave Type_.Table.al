table 50214 "Leave Type"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Days; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Acrue Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Unlimited Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Gender;enum "Employee Gender")
        {
            DataClassification = ToBeClassified;
        }
        field(7; Balance; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Ignore,Carry Forward,Convert to Cash';
            OptionMembers = Ignore, "Carry Forward", "Convert to Cash";
        }
        field(8; "Inclusive of Holidays"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Inclusive of Saturday"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Inclusive of Sunday"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Off/Holidays Days Leave"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Max Carry Forward Days"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Balance <> Balance::"Carry Forward" then "Max Carry Forward Days":=0;
            end;
        }
        field(13; "Conversion Rate Per Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Allocate Leave Monthly"; Boolean)
        {
            Caption = 'Allocate Leave Monthly';
            Editable = true;
        }
        field(14; "Annual Leave"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active, Inactive;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
