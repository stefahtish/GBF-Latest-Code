table 50241 "Travelling Non Employees"
{
    fields
    {
        field(1; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = false;
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Source; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Destination; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Passport No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Airline; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Itinerary; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Travel Insurance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Ticket Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Economy,Business';
            OptionMembers = , Economy, Business;
        }
        field(14; "Cost Centre"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "FSC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Fn Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Request No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
