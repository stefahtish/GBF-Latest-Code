table 50546 "Bank Branches"
{
    DrillDownPageID = "Bank Branches List";
    LookupPageID = "Bank Branches List";

    fields
    {
        field(1; "Bank Code"; Code[50])
        {
            NotBlank = true;
            TableRelation = Banks;
        }
        field(2; "Branch Code"; Code[50])
        {
        }
        field(3; "Branch Name"; Text[250])
        {
        }
        field(4; Address; Text[30])
        {
        }
        field(5; "Address 2"; Text[30])
        {
        }
        field(6; City; Text[30])
        {
        }
        field(7; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if PostCode.Get("Post Code")then City:=PostCode.City;
            end;
        }
        field(8; Contact; Text[30])
        {
        }
        field(9; "Phone No."; Text[30])
        {
        }
        field(10; "Telex No."; Text[20])
        {
        }
        field(12; "Bank Branch No."; Text[20])
        {
            NotBlank = false;
        }
        field(13; "Bank Account No."; Text[30])
        {
        }
        field(14; "Transit No."; Text[20])
        {
        }
        field(15; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(16; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(17; County; Text[30])
        {
        }
        field(18; "Fax No."; Text[30])
        {
        }
        field(19; "Telex Answer Back"; Text[20])
        {
        }
        field(20; "Language Code"; Code[10])
        {
            TableRelation = Language;
        }
        field(21; "E-Mail"; Text[80])
        {
        }
        field(22; "Home Page"; Text[80])
        {
        }
        field(23; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(24; "Rounding Type"; Option)
        {
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest, Up, Down;
        }
        field(25; "Rounding Precision"; Decimal)
        {
            DecimalPlaces = 2: 2;
        }
        field(26; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
        }
    }
    keys
    {
        key(Key1; "Bank Code", "Branch Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Branch Code", "Branch Name")
        {
        }
    }
    var PostCode: Record "Post Code";
}
