table 50220 "Employee Prof Membership"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." WHERE("No."=FIELD("Employee No."));
        }
        field(2; "Date Admitted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Organisation; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Membership Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Designation; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Annual Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Renewal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Company Pays Fees"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Employee First Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Employee Last Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Comment; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Language Code (Default)"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Attachement; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ", Yes, No;
        }
        field(14; "Membership No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Member No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Membership Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
