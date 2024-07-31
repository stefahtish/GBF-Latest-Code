table 50258 "Medical Scheme Lines"
{
    fields
    {
        field(1; "Medical Scheme No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; Relationship; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Relative;
        }
        field(4; SurName; Text[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(5; "Other Names"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        //This property is currently not supported
        //TestTableRelation = false;
        //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
        //ValidateTableRelation = false;
        }
        field(6; "ID No/Passport No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Occupation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Address; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Office Tel No"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Home Tel No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Service Provider"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(14; "Fiscal Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " Male", Female;
        }
        field(17; "In-Patient Entitlement"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Out-Patient Entitlment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Amount Spend (In-Patient)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Amout Spend (Out-Patient)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Policy Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Medical Cover Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "In House", Outsourced;
        }
    }
    keys
    {
        key(Key1; "Medical Scheme No", "Line No.", "Employee Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
